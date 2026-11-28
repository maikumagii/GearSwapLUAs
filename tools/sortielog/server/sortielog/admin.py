"""SortieLog maintenance commands. On the Pi run them inside the container, for example:

    docker compose exec sortielog python -m sortielog.admin weapons
    docker compose exec sortielog python -m sortielog.admin set-weapon --player Kalali --main-dmg 130 --sub-dmg 38

set-weapon fills in weapon DMG for rows uploaded by addons that didn't log it. By default it
only touches rows with no DMG yet; narrow it with --session or --from/--to (local time,
"2026-11-28 20:15") when you used different weapons at different times. Add --dry-run to
see how many rows would change first.
"""

import argparse
import os
import sys
from datetime import datetime

from .store import Store


def _time(text):
    if not text:
        return None
    for fmt in ("%Y-%m-%d %H:%M:%S", "%Y-%m-%d %H:%M", "%Y-%m-%d"):
        try:
            return datetime.strptime(text, fmt).timestamp()
        except ValueError:
            continue
    raise SystemExit(f"can't read time {text!r}; use e.g. '2026-11-28 20:15'")


def main(argv=None):
    parser = argparse.ArgumentParser(description="SortieLog maintenance commands")
    parser.add_argument("--db", default=os.environ.get("SORTIELOG_DB", "/data/sortielog.db"))
    commands = parser.add_subparsers(dest="command", required=True)

    weapons = commands.add_parser("weapons", help="show weapon DMG coverage per player and session")
    weapons.add_argument("--player")

    setw = commands.add_parser("set-weapon", help="fill in weapon DMG on existing rows")
    setw.add_argument("--player", help="character name (actor)")
    setw.add_argument("--uploader", help="key name the rows were uploaded with")
    setw.add_argument("--session", help="only this session (see the weapons command)")
    setw.add_argument("--from", dest="since", help="only rows at or after this local time")
    setw.add_argument("--to", dest="until", help="only rows before this local time")
    setw.add_argument("--main-dmg", type=int)
    setw.add_argument("--sub-dmg", type=int)
    setw.add_argument("--main-name", help="optional main weapon name, e.g. Mandau")
    setw.add_argument("--sub-name", help="optional off-hand weapon name")
    setw.add_argument("--overwrite", action="store_true", help="also replace DMG already on rows")
    setw.add_argument("--dry-run", action="store_true", help="only count the rows that would change")
    args = parser.parse_args(argv)

    store = Store(args.db)
    try:
        if args.command == "weapons":
            sql = ("SELECT actor, session, COUNT(*), SUM(main_dmg IS NOT NULL), "
                   "GROUP_CONCAT(DISTINCT main_dmg), GROUP_CONCAT(DISTINCT sub_dmg), MIN(t), MAX(t) "
                   "FROM events WHERE is_me = 1 AND kind IN ('melee', 'melee_miss', 'ws')")
            params = []
            if args.player:
                sql += " AND actor = ? COLLATE NOCASE"
                params.append(args.player)
            sql += " GROUP BY actor, session ORDER BY MIN(t)"
            print(f"{'player':12} {'session':16} {'from':16} {'to':6} {'rows':>6} {'with DMG':>8}  main / sub DMG")
            for actor, session, rows, with_dmg, mains, subs, start, end in store._conn.execute(sql, params):
                fmt = lambda t: datetime.fromtimestamp(t).strftime("%Y-%m-%d %H:%M") if t else "-"
                print(f"{actor or '?':12} {session or '?':16} {fmt(start):16} {fmt(end)[-5:]:6} {rows:>6} {with_dmg or 0:>8}"
                      f"  {mains or '-'} / {subs or '-'}")
            return 0

        if args.main_dmg is None and args.sub_dmg is None:
            parser.error("give --main-dmg and/or --sub-dmg")
        if not (args.player or args.uploader or args.session):
            parser.error("give --player, --uploader or --session so other players' rows aren't touched")
        changed = store.set_weapon(actor=args.player, uploader=args.uploader, session=args.session,
                                   since=_time(args.since), until=_time(args.until),
                                   main_dmg=args.main_dmg, sub_dmg=args.sub_dmg,
                                   main_weapon=args.main_name, sub_weapon=args.sub_name,
                                   overwrite=args.overwrite, dry_run=args.dry_run)
        verb = "would change" if args.dry_run else "changed"
        print(", ".join(f"{hand} hand: {count} rows {verb}" for hand, count in changed.items()) or "nothing to do")
        if not args.dry_run and any(changed.values()):
            print("The dashboard refits on its next refresh.")
        return 0
    finally:
        store.close()


if __name__ == "__main__":
    sys.exit(main())
