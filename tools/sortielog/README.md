# SortieLog

Logs weapon skill and melee damage against Sortie bosses (or any monster) and judges
whether each player is at the **pDIF cap** from the spread of that damage. You don't need
the boss's DEF or a model of the debuff stack.

- At the cap, both pDIF bounds clamp to the ceiling and only the 1.00–1.05 randomizer
  remains, so same-condition damage spreads by about 5%.
- Below the cap, the bounds are apart and the spread is wider (10–25%).
- Second check: if damage rises with more attack buffs, you are not capped.

```
Player (Windows PC or Steam Deck)              Cloudflare                     Raspberry Pi
┌──────────────────────────────┐   HTTP + key   ┌─────────────────┐   tunnel   ┌──────────────────────┐
│ SortieLog addon (in Windower)│ ─────────────▶ │ sortie.<domain> │ ◀───────── │ cloudflared (host)   │
│  ├─ live upload every 5 s    │                │                 │  (outbound │  └▶ localhost:8090   │
│  └─ data/logs/*.csv (backup) │                └─────────────────┘   only)    │    sortielog (Docker)│
└──────────────────────────────┘                                              └──────────────────────┘
```

- **Nothing to run besides the game.** The addon uploads by itself. That works the same on a
  Windows PC and on a Steam Deck (Windower under Proton).
- **The game never waits on the network.** Uploads use a non-blocking socket that advances a
  little on every rendered frame, and rows go out in batches every 5 seconds.
- **Nothing is lost.** Every row is also written to a CSV first. Failed uploads are retried
  with backoff, the server ignores rows it already has, and old CSVs can be uploaded later.
- **The Pi only makes outbound connections** to Cloudflare, through the cloudflared service
  that already runs EventMoogle's tunnel: no port forwarding and no exposed home IP.
- **Plain HTTP:** Windower's Lua has no TLS library, so the addon sends plain HTTP to
  Cloudflare. Your key travels unencrypted between your device and Cloudflare. The worst
  case is someone on the same network uploading junk under your key, so ask for a new one if
  you suspect that. The optional forwarders in section 2 use HTTPS.

## 1. Install the addon (every player)

### Get the files
1. On the GitHub repository page, click **Code → Download ZIP**, unzip it, and open
   `tools/sortielog/addon/`. If you don't have access to the repository, ask for a zip of the
   `SortieLog` folder.
2. Copy the whole **`SortieLog`** folder into Windower's `addons` folder, keeping the name exactly:
   - **Windows:** `Windower\addons\SortieLog\SortieLog.lua`
   - **Steam Deck:** in Desktop Mode, find your Windower folder inside the Proton prefix and
     copy it into `addons` there. If you're not sure where Windower is, run this in Konsole:
     ```bash
     find ~ /run/media -type d -name addons -path '*Windower*' 2>/dev/null
     ```

### Turn it on (in game)
```
//lua load sortielog
//slog token <your player key>
//slog http on
//slog status
```
`//slog status` should show `http on -> http://sortie.eventmoogle.com | key set`. After a fight,
it should show `sent` going up and `ok`. Settings are saved, so next time only
`//lua load sortielog` is needed. To load it automatically, add `lua load sortielog` to
`Windower/scripts/init.txt`.

If uploads fail, the addon says so once in chat ("SortieLog upload: …") and keeps retrying.
`//slog flush` sends queued rows immediately.

### Accuracy (for the evasion estimate): automatic
Accuracy isn't in any status packet and it changes with every song, bubble, food or gear
piece, so the addon measures it with `/checkparam` and remembers it per **buff and gear state**:
- **When you're engaged in a combination of buffs and gear it hasn't measured yet,** it waits
  about 3 seconds for things to settle, then runs `/checkparam <me>`. The output is hidden from
  your chat, and it runs at most once every 20 seconds.
- **When you return to a state it has already measured** (March drops, then comes back), the
  remembered value is used immediately.
- **While the current state hasn't been measured,** rows get **no** Accuracy rather than a stale
  one, and the evasion estimate skips them.
- **Memory resets** after 10 minutes and on zone change, because buff potencies can differ
  between runs.

`//slog checkparam` measures right now (output shown), and a `/checkparam` you type yourself
is captured too. `//slog autocheck off` turns the automatic runs off. Attack doesn't need any
of this: it's read from the game's status packet whenever gear or buffs change.

The one gap: the same buff name at a different potency (a different bard's March, Indi-Precision
versus an Entrusted one, a different food) looks identical, so the old value is reused until
the 10-minute expiry.

### Debuffs on the target: automatic
Debuffs your party or alliance lands are logged with whatever affects their strength, so the
server can work out each one's real effect later:

| Tracked as | Example label | How |
|---|---|---|
| Spell tier | `Dia III`, `Distract III` | From the spell that landed |
| Saboteur | `Distract III+Saboteur` | RDM used Saboteur shortly before the spell |
| Steps | `Box Step lv3` | Daze level from the step. Expires 60 s after the last step |
| Geo bubbles | `Geo-Frailty+Bolster`, `+BoG`, `+EA` | GEO's Geo- spell at the target. Lasts while their luopan is alive |
| Indi auras | `Indi-Frailty+Entrust` | Assumed active for 3 minutes |
| Light Shot | `Light Shot` | Cleared when Dia wears off |

Still manual: effects that never show up as a message, such as Aria of Passion and Soul Voice.
Use `//slog flag aria` / `//slog flag sv_aria` for those.

### During a run
| When | Command |
|---|---|
| Before a run | `//slog new` (starts a fresh log) |
| Aria of Passion or Soul Voice is up | `//slog flag aria`, `//slog flag sv_aria` |
| It drops | `//slog flag aria off` (or `//slog flag clear`) |
| Mark something | `//slog note Aminon pull 2` |

### All commands
| Command | What it does |
|---|---|
| `//slog status` | Settings, upload state, Attack/Accuracy/weapon, flags |
| `//slog http on\|off` | Live upload to the server |
| `//slog url <http://host[:port]>` | Server address (default `http://sortie.eventmoogle.com`) |
| `//slog token <key>\|clear` | Your player key |
| `//slog flush` | Send queued rows now |
| `//slog checkparam` | Measure Accuracy now (output shown) |
| `//slog autocheck on\|off` | Automatic hidden `/checkparam` for new buff/gear states (default on) |
| `//slog acc <main> [sub]` | Set Accuracy by hand for the current buff/gear state |
| `//slog targets <name,name>` | Only log these monsters (empty = all) |
| `//slog flag <name> [on\|off]`, `flag clear`, `flags` | Context the game doesn't report |
| `//slog note <text>` | Free-text marker row |
| `//slog new` | Start a new session/CSV |
| `//slog udp on\|off`, `//slog host <ip> [port]` | Optional LAN-only UDP push |

Each row records: time, session and row number, zone, kind (`ws`, `melee`, `ranged`, misses,
`party_action`, `status_on`/`status_off`, `flag`, `note`), actor and target, WS, damage, crit,
hand, your TP when you sent the WS, job, buffs, statuses seen on the target, flags, WS Wall
features, main-hand Attack, Accuracy and weapon type.

### Updating
Replace `SortieLog.lua` with the new one and type `//lua reload sortielog`. Your settings
(in `SortieLog/data/settings.xml`) and logs stay.

## 2. Optional: HTTPS forwarders

You don't need these if `//slog http on` works. They're for HTTPS uploads, or for uploading
old logs. Both read `SortieLog/data/logs`, use `forwarder.json` (`{"url": "https://…", "key": "…"}`)
and keep their progress in `forwarder-state.json`. The server skips duplicates, so they can
run alongside the live upload.

- **Windows:** double-click `forwarder/SortieLogForwarder.bat` once to create
  `forwarder.json`, fill it in, then run it again and leave the window open.
- **Steam Deck / Linux** (native, no Proton): in Konsole, from the `forwarder` folder, run
  `python3 sortielog_forwarder.py --once` to create and then test `forwarder.json`.
  `bash install-steamdeck.sh` makes it a background service that keeps running in Game Mode.
  Check it with `journalctl --user -u sortielog-forwarder -f`.

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
| `SORTIELOG_KEYS` | `name:key` pairs, one per player. Generate a key with `openssl rand -hex 24` (keep keys to letters and digits) |
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
3. Send them the addon folder and their key. They follow section 1: `//slog token <key>`,
   then `//slog http on`.
4. If you've put the dashboard behind Access, add their email to its policy.

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
- Aria and Soul Voice don't appear as messages, so use `//slog flag`. Geo bubbles, steps,
  Saboteur and spell tiers are tracked automatically.
- TP bonus gear isn't visible to the addon. Set `SORTIELOG_TP_BONUS` if your WS sets use
  Moonshade or TP-bonus weapons.
- Attack comes from the status packet and Accuracy from `/checkparam` (read from its message
  packets, or its chat text as a fallback). None of this has been checked in game yet: confirm
  `//slog status` shows numbers, that automatic checks don't show up in chat, and that
  `debuffs on target` lists what your party put on the boss.
- Not tested in game yet. Check the first real CSV before trusting the dashboard.
- Everyone with dashboard access sees every player's character names and damage.
