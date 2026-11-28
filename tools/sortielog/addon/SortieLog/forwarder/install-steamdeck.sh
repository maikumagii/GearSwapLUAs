#!/usr/bin/env bash
# Installs the SortieLog forwarder as a background service on SteamOS (Steam Deck) or Linux.
# Run it from Desktop Mode, in a terminal, from this folder:
#   bash install-steamdeck.sh            install/update and start the service
#   bash install-steamdeck.sh uninstall  stop and remove it
# Once installed it starts with your session and keeps running in Game Mode.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
unit_dir="$HOME/.config/systemd/user"
unit="$unit_dir/sortielog-forwarder.service"

if [[ "${1:-}" == "uninstall" ]]; then
    systemctl --user disable --now sortielog-forwarder.service 2>/dev/null || true
    rm -f "$unit"
    systemctl --user daemon-reload
    echo "SortieLog forwarder removed."
    exit 0
fi

python="$(command -v python3 || true)"
if [[ -z "$python" ]]; then
    echo "python3 not found. SteamOS includes it; on other Linux install python3 first." >&2
    exit 1
fi

# First run creates forwarder.json; refuse to install until url and key are filled in.
if ! "$python" - "$here/forwarder.json" <<'PY'
import json, sys
try:
    cfg = json.load(open(sys.argv[1], encoding="utf-8-sig"))
except (OSError, ValueError):
    sys.exit(1)
sys.exit(0 if cfg.get("url") and cfg.get("key") and cfg.get("key") != "paste-your-key-here" else 1)
PY
then
    "$python" "$here/sortielog_forwarder.py" --once >/dev/null 2>&1 || true
    echo "Edit $here/forwarder.json with your url and key, then run this script again."
    exit 1
fi

mkdir -p "$unit_dir"
cat > "$unit" <<UNIT
[Unit]
Description=SortieLog forwarder (uploads Sortie damage logs)
After=network-online.target

[Service]
ExecStart="$python" "$here/sortielog_forwarder.py"
Restart=always
RestartSec=15

[Install]
WantedBy=default.target
UNIT

systemctl --user daemon-reload
systemctl --user enable --now sortielog-forwarder.service
echo "SortieLog forwarder installed and running."
echo "Check it with:  journalctl --user -u sortielog-forwarder -f"
