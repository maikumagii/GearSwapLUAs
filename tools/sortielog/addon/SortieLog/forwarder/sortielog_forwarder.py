#!/usr/bin/env python3
"""SortieLog forwarder: ships new SortieLog CSV rows to the server over HTTPS.

Python 3 standard library only, so it runs natively on SteamOS (Steam Deck), Linux, macOS
or Windows. Same settings and progress files as the PowerShell forwarder:
forwarder.json ({"url": ..., "key": ...}) and forwarder-state.json, next to this script.

    python3 sortielog_forwarder.py                 # follow the logs until stopped
    python3 sortielog_forwarder.py --once          # send what's there and exit
    python3 sortielog_forwarder.py --log-dir PATH  # logs somewhere other than ../data/logs
"""

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

HERE = Path(__file__).resolve().parent
CONFIG_PATH = HERE / "forwarder.json"
STATE_PATH = HERE / "forwarder-state.json"
PLACEHOLDER_KEY = "paste-your-key-here"
MAX_READ = 8 * 1024 * 1024
USER_AGENT = "SortieLogForwarder/0.2 (python)"


def log(message):
    print(time.strftime("%H:%M:%S"), message, flush=True)


def load_json(path, default):
    try:
        return json.loads(path.read_text(encoding="utf-8-sig"))   # PowerShell writes a BOM
    except (FileNotFoundError, ValueError):
        return default


def save_state(state):
    tmp = STATE_PATH.with_suffix(".tmp")
    tmp.write_text(json.dumps(state, indent=1), encoding="utf-8")
    os.replace(tmp, STATE_PATH)


def read_header(path):
    with open(path, "rb") as handle:
        return handle.readline().rstrip(b"\r\n")


def post(endpoint, key, body):
    request = urllib.request.Request(endpoint, data=body, method="POST", headers={
        "Content-Type": "text/csv; charset=utf-8", "X-Token": key, "User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=20) as response:
        return json.loads(response.read().decode("utf-8") or "{}")


def send_file(path, state, headers, endpoint, key, batch_lines):
    """Returns 'idle', 'sent', 'more' (a full batch went out) or 'failed'."""
    name = path.name
    offset = int(state.get(name, 0))
    size = path.stat().st_size
    if size < offset:
        offset = 0   # file was replaced
    if size == offset:
        return "idle"
    with open(path, "rb") as handle:
        handle.seek(offset)
        data = handle.read(min(size - offset, MAX_READ))

    # Only complete lines, at most batch_lines of them.
    end, lines, pos = -1, 0, 0
    while lines < batch_lines:
        index = data.find(b"\n", pos)
        if index < 0:
            break
        end, lines, pos = index, lines + 1, index + 1
    if end < 0:
        return "idle"
    chunk = data[:end + 1]
    if offset > 0:
        if name not in headers:
            headers[name] = read_header(path)
        chunk = headers[name] + b"\n" + chunk

    try:
        result = post(endpoint, key, chunk)
    except urllib.error.HTTPError as err:
        detail = err.read().decode("utf-8", "replace")[:200]
        log(f"{name}: upload failed: HTTP {err.code} {detail}")
        return "failed"
    except (urllib.error.URLError, OSError, ValueError) as err:
        log(f"{name}: upload failed: {err}")
        return "failed"
    state[name] = offset + end + 1
    save_state(state)
    log(f"{name}: sent {result.get('received', '?')} rows, {result.get('accepted', '?')} new")
    return "more" if lines >= batch_lines else "sent"


def main(argv=None):
    parser = argparse.ArgumentParser(description="Ship SortieLog CSV rows to a SortieLog server.")
    parser.add_argument("--url")
    parser.add_argument("--key")
    parser.add_argument("--log-dir", default=str(HERE.parent / "data" / "logs"))
    parser.add_argument("--interval", type=float, default=3.0)
    parser.add_argument("--batch-lines", type=int, default=2000)
    parser.add_argument("--once", action="store_true", help="send what's there and exit")
    args = parser.parse_args(argv)

    config = load_json(CONFIG_PATH, {})
    url = args.url or config.get("url")
    key = args.key or config.get("key")
    if not url or not key or key == PLACEHOLDER_KEY:
        if not CONFIG_PATH.exists():
            CONFIG_PATH.write_text(json.dumps(
                {"url": "https://sortie.example.com", "key": PLACEHOLDER_KEY}, indent=1), encoding="utf-8")
        log(f"Put your server url and key in {CONFIG_PATH} (or pass --url and --key), then run again.")
        return 1

    endpoint = url.rstrip("/") + "/ingest/csv"
    log_dir = Path(args.log_dir)
    state = {k: int(v) for k, v in load_json(STATE_PATH, {}).items()}
    headers = {}
    log(f"SortieLog forwarder: {log_dir} -> {endpoint} (Ctrl+C to stop)")

    delay = args.interval
    warned = False
    try:
        while True:
            failed = False
            if log_dir.is_dir():
                warned = False
                more = True
                while more and not failed:
                    more = False
                    for path in sorted(log_dir.glob("*.csv")):
                        status = send_file(path, state, headers, endpoint, key, args.batch_lines)
                        more = more or status == "more"
                        if status == "failed":
                            failed = True
                            break
            elif not warned:
                log(f"Log folder not found yet: {log_dir}")
                warned = True
            if args.once:
                return 1 if failed else 0
            # Back off while the server is unreachable, up to a minute.
            delay = min(delay * 2, 60) if failed else args.interval
            time.sleep(delay)
    except KeyboardInterrupt:
        log("stopped")
        return 0


if __name__ == "__main__":
    sys.exit(main())
