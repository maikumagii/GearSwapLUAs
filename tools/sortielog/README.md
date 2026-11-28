# SortieLog

Logs weapon skill and melee damage against Sortie bosses (or any monster) and judges
whether each player is at the **pDIF cap** from the spread of that damage. You don't need
the boss's DEF or a model of the debuff stack.

- At the cap, both pDIF bounds clamp to the ceiling and only the 1.00–1.05 randomizer
  remains, so same-condition damage spreads by about 5%.
- Below the cap, the bounds are apart and the spread is wider (10–25%).
- Second check: if damage rises with more attack buffs, you are not capped.

```
Player PC                                   Cloudflare                     Raspberry Pi
┌──────────────────────┐   HTTPS + key   ┌─────────────────┐   tunnel   ┌──────────────────────┐
│ SortieLog addon      │                 │ sortie.<domain> │ ◀───────── │ cloudflared (host)   │
│  └─ data/logs/*.csv  │──▶ forwarder ──▶│ Access: /ingest │  (outbound │  └▶ localhost:8090   │
│                      │   (PowerShell)  │  bypass, rest   │   only)    │    sortielog (Docker)│
└──────────────────────┘                 │  needs login    │            └──────────────────────┘
                                         └─────────────────┘
```

- The game never makes network calls itself. The addon only writes CSV, so it can't
  stall the client.
- The forwarder ships new CSV lines every 3 s, resumes after outages, and the server
  ignores rows it already has.
- The Pi only makes outbound connections to Cloudflare, through the cloudflared service
  that already runs EventMoogle's tunnel: no router port forwarding and no exposed home IP.
  It works the same from your house or a friend's.

## 1. Addon (every player)

1. Copy `addon/SortieLog` to `Windower/addons/SortieLog`.
2. In game: `//lua load sortielog` (add it to `Windower/scripts/init.txt` to autoload).

| Command | What it does |
|---|---|
| `//slog status` | Settings and active flags |
| `//slog targets <name,name>` | Only log these monsters (empty = all) |
| `//slog flag <name> [on\|off]` | Context the game doesn't report: `frailty`, `aria`, `sv_aria`, `fury`… |
| `//slog flag clear` / `//slog flags` | Clear or list flags |
| `//slog note <text>` | Free-text marker row (e.g. `//slog note Aminon pull 2`) |
| `//slog acc <main> [sub]` | Set Accuracy by hand (normally picked up from `/checkparam`) |
| `//slog new` | Start a new session/CSV |
| `//slog udp on\|off`, `//slog host <ip> [port]`, `//slog token <key>` | Optional LAN-only UDP push (see below) |

Each row records: time, session and a row number, zone, kind (`ws`, `melee`, `ranged`,
misses, `party_action`, `status_on`/`status_off`, `flag`, `note`), actor and target, WS,
damage, crit, hand, your TP when you sent the WS, job, your buffs, statuses seen landing on
the target, your flags, and WS Wall features (`wall_same` = how many of the last 6 WS on
that target were the same WS). It also records your main-hand Attack, read automatically from
the game's status packet (`0x061`) whenever gear or buffs change, your Accuracy, and your
main weapon type.

**Accuracy for the evasion estimate:** after buffs are up and you're in your TP set, run
`/checkparam <me>`. The addon reads the Accuracy numbers from the chat output and confirms
with "SortieLog: accuracy main … sub …". If it doesn't confirm, use `//slog acc <main> [sub]`.
Run it again whenever your accuracy changes noticeably, since rows are grouped by that value.

## 2. Forwarder (every player)

In `Windower/addons/SortieLog/forwarder/`:

1. Double-click `SortieLogForwarder.bat` once. It creates `forwarder.json` and exits.
2. Edit `forwarder.json`:
   ```json
   { "url": "https://sortie.eventmoogle.com", "key": "<your player key>" }
   ```
3. Run `SortieLogForwarder.bat` again and leave the window open while you play.

On its first run it uploads every existing log, then keeps following new rows. Its
progress is kept in `forwarder-state.json`; delete that file to re-upload everything,
and the server will skip the duplicates.

## 3. Server on the Raspberry Pi

Needs Docker with the compose plugin on 64-bit Pi OS.

```bash
cd tools/sortielog/server
cp .env.example .env      # then fill it in, see section 4
docker compose up -d --build
docker compose logs -f
```

`.env` settings:

| Variable | Meaning |
|---|---|
| `SORTIELOG_HTTP_PORT` | Host port the tunnel forwards to (default 8090; 8080–8082 are EventMoogle's) |
| `SORTIELOG_BIND` | `127.0.0.1` (default) = tunnel only; `0.0.0.0` also opens it on the LAN |
| `SORTIELOG_KEYS` | `name:key` pairs, one per player. Generate a key with `openssl rand -hex 24` |
| `SORTIELOG_TP_BONUS` | Optional TP bonus per WS for fTP normalization, e.g. `Black Halo=250` |
| `SORTIELOG_LEVEL_DIFF` | Level correction for DEF/EVA: monster level minus yours (0 = off) |

After changing keys, run `docker compose up -d`. The data lives in the
`sortielog-data` volume. To back it up: `docker compose cp sortielog:/data ./backup`.

Before the first start, check that the port is free (no output means free):

```bash
sudo ss -ltnp | grep ':8090 '
```

## 4. Cloudflare setup (one time)

Requirement: `eventmoogle.com` must use Cloudflare's nameservers, with the domain shown as
*Active* in the Cloudflare dashboard. The examples use the subdomain `sortie`, so anything
on the root domain is untouched.

### 4a. Tunnel: add a hostname to the existing EventMoogle tunnel

cloudflared already runs on the Pi as a system service (not in Docker) and is managed from
the dashboard. That tunnel serves `dev.eventmoogle.com`, so `eventmoogle.com` is already in
the right account. You don't need a new tunnel or a second cloudflared.

1. Start SortieLog (section 3) and check it answers locally on the Pi:
   ```bash
   curl -s http://localhost:8090/health
   ```
2. Go to **Cloudflare dashboard → Zero Trust → Networks → Tunnels**, open the tunnel that
   serves `dev.eventmoogle.com`, then **Public hostname** (called *Published application
   routes* in the newer UI) → **Add**:
   - Subdomain `sortie`, Domain `eventmoogle.com`, Path empty
   - Service type **HTTP**, URL **`localhost:8090`**
3. Save. Cloudflare creates the DNS record, and the running cloudflared picks up the new
   route without a restart. The existing EventMoogle hostnames are untouched.

### 4b. Access: login for the dashboard, open path for uploads

In **Zero Trust → Access → Applications**, create two **Self-hosted** applications.

| Application | Hostname / path | Policy |
|---|---|---|
| `SortieLog ingest` | `sortie.eventmoogle.com`, path `ingest*` | Action **Bypass**, Include **Everyone** |
| `SortieLog dashboard` | `sortie.eventmoogle.com`, path empty | Action **Allow**, Include **Emails**: yours, plus anyone you share it with |

The more specific `ingest*` path wins, so the forwarder can upload, and the server's
per-player keys protect that path. Everything else (dashboard, `/api/*`, `/health`) needs
the Access login, which uses a one-time PIN by email by default.

### 4c. Bot protection

If **Security → Bots → Bot Fight Mode** is on, it can challenge the forwarder, which isn't a
browser. If uploads fail with 403 or "challenge" errors, turn Bot Fight Mode off for this
zone. On the free plan it can't be skipped per path.

### 4d. Check it

```bash
curl -s https://sortie.eventmoogle.com/ingest -H 'X-Token: <your key>' \
  -H 'Content-Type: application/json' -d '{"kind":"note","session":"setup-test","detail":"hello"}'
```

That should print `{"accepted":1}`. Then open `https://sortie.eventmoogle.com/`, log in
through Access, and the dashboard should load.

### Adding a player

1. Generate a key: `openssl rand -hex 24`.
2. Append `,name:key` to `SORTIELOG_KEYS` in `.env`, then run `docker compose up -d`.
3. Send them the addon folder, the URL and their key.
4. To let them see the dashboard, add their email to the dashboard Access policy.

Each player's rows are tagged with their key's name, and the analysis never mixes players.

## API

| Method | Path | Notes |
|---|---|---|
| POST | `/ingest/csv` | Raw addon CSV (header + rows). Key in `X-Token` or `Authorization: Bearer` |
| POST | `/ingest` | JSON object or list (addon schema) |
| GET | `/api/analysis?uploader=&session=&target=&minutes=` | Spread and attack-check summaries |
| GET | `/api/events?kind=ws,melee&uploader=&target=&session=&after_id=&limit=` | Raw rows |
| GET | `/api/sessions`, `/api/targets`, `/api/uploaders` | Filters |
| GET | `/health` | Row and rejected-packet counts |

## Optional: LAN-only UDP push

If the game PC is on the Pi's network, the addon can also push rows over UDP:
`//slog host <pi-lan-ip> 5140`, `//slog token <key>`, `//slog udp on`. You also need to
publish `5140:5140/udp` in compose. It doesn't work through Cloudflare, so use the
forwarder for anything remote.

## Offline analysis (no server)

```bash
cd tools/sortielog/server
pip install -r requirements.txt
python -m sortielog.cli /path/to/Windower/addons/SortieLog/data/logs/*.csv --target Aminon
```

## Reading the results

- Groups are **player × target × WS × wall position**. Damage is divided by fTP at the WS
  TP, so WS at different TP can be compared. This works for Black Halo, Savage Blade,
  Rudra's Storm, Judgment and Origin; other WS are grouped into 250-TP bands instead.
- **Spread** = p90 / p10. About 1.06 or less means likely capped, above 1.10 means likely
  below cap, and anything between is borderline. You need at least 8 WS in a group.
- **99,999 hits are excluded** and only counted.
- **Attack check**: median damage by attack-buff count (Minuet, Attack Boost/Fury,
  Chaos Roll, Berserk, …). A gain of 3% or more means below the cap.
- The **melee table** reflects each player's TP set, not their WS set.

### Effective DEF and evasion

Both come from your own main-hand melee and are "effective", meaning measured with the
debuffs listed in the row (Dia, steps, Frailty flag, …). Rows are grouped by player, boss,
Attack or Accuracy, and debuffs, and need about 30 hits or swings.

- **DEF:** below the pDIF cap, non-crit damage is uniform between a lower and an upper pDIF
  bound that depend only on Attack ÷ DEF (BG-Wiki PDIF), times the 1.00–1.05 randomizer.
  The p90/p10 spread therefore pins the ratio, and DEF = Attack ÷ ratio, with a bootstrap
  90% range. At the pDIF cap (spread ≤ 1.06) only **DEF ≤ Attack ÷ cap ratio** can be shown
  (1H 3.625, H2H/GKT 3.875, 2H 4.125, Scythe 4.375). "Close to cap" rows run low, because
  the weapon cap may be trimming the top of the range.
- **Evasion:** hit rate = 75% + (ACC − EVA) ÷ 2, floored at 20% and capped at 99% (1H main
  hand, H2H) or 95% (2H, off hand). With a 90% range on the hit rate, EVA = ACC − 2 × (hit% − 75).
  If the range reaches the cap, you're hit-capped and only **EVA ≤ value** can be shown. To
  pin EVA down, swing in a lower-accuracy TP set for a while.
- **Level correction:** BG-Wiki's formulas subtract 0.05 from the ratio and 2% from hit
  rate per level above you, but Sortie isn't on its list of zones with or without
  correction. It's off by default. Set `SORTIELOG_LEVEL_DIFF`, or run the CLI with
  `--level-diff 26`, to compare. Whichever setting gives consistent DEF across your
  different Attack values is probably right.
- **Per-target summary:** for each boss and debuff state, all group estimates are combined,
  weighting the tighter ones more. It shows a 90% range and **"±5% conf."**, the chance the
  true value is within 5% of the estimate. Capped groups add upper bounds, and "close to cap"
  groups add lower bounds. If the estimate breaks a bound, the status says *conflict*.
- **Checking incoming data:** each group is compared with all the *other* groups for the same
  boss and debuff state. The **Check** column says *consistent*, *suspicious* (z ≥ 2) or
  *outlier* (z ≥ 3). Outliers are removed worst-first and left out of the summary, so one bad
  group can't get good ones flagged. An outlier means the data disagrees, not which side is
  wrong. Usual causes: an unlogged debuff (use `//slog flag`), stale Accuracy (re-run
  `/checkparam`), a boss phase change, or the wrong level-correction setting.
- **Level-correction fit:** level correction changes DEF by a different amount at each
  Attack value, so groups at clearly different Attack (5% or more apart) only agree under
  the right setting. The dashboard shows the best-fitting level difference with a 90%
  plausible range, and says when the data clearly prefers a different setting from yours.
  EVA's correction is a constant offset, so it can't be fitted this way.
- **Base DEF** (without debuffs) isn't estimated. Compare groups with and without a debuff
  to see its effect.

## Caveats

- Thresholds are heuristics. Multi-attack procs on the first WS hit add some spread on their
  own, so a capped group may read about 1.06–1.08.
- WS Wall rules are community-tested, not official. Party WS on the target are counted in `wall_same`.
- Geo bubbles, Aria and Soul Voice don't appear as target debuffs, so use `//slog flag`.
- TP bonus gear isn't visible to the addon. Set `SORTIELOG_TP_BONUS` if your WS sets use
  Moonshade or TP-bonus weapons.
- Attack comes from the status packet and Accuracy from `/checkparam`. Neither has been
  checked in game yet, so confirm `//slog status` shows sensible values.
- Not tested in game yet. Check the first real CSV before trusting the dashboard.
- Everyone with dashboard access sees every player's character names and damage.
