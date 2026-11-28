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
| `//slog new` | Start a new session/CSV |
| `//slog udp on\|off`, `//slog host <ip> [port]`, `//slog token <key>` | Optional LAN-only UDP push (see below) |

Each row records: time, session and a row number, zone, kind (`ws`, `melee`, `ranged`,
misses, `party_action`, `status_on`/`status_off`, `flag`, `note`), actor and target, WS,
damage, crit, hand, your TP when you sent the WS, job, your buffs, statuses seen landing on
the target, your flags, and WS Wall features (`wall_same` = how many of the last 6 WS on
that target were the same WS).

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

## Caveats

- Thresholds are heuristics. Multi-attack procs on the first WS hit add some spread on their
  own, so a capped group may read about 1.06–1.08.
- WS Wall rules are community-tested, not official. Party WS on the target are counted in `wall_same`.
- Geo bubbles, Aria and Soul Voice don't appear as target debuffs, so use `//slog flag`.
- TP bonus gear isn't visible to the addon. Set `SORTIELOG_TP_BONUS` if your WS sets use
  Moonshade or TP-bonus weapons.
- Not tested in game yet. Check the first real CSV before trusting the dashboard.
- Everyone with dashboard access sees every player's character names and damage.
