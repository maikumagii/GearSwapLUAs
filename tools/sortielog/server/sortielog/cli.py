"""Offline analysis of SortieLog CSV files: python -m sortielog.cli logs/*.csv"""

import argparse
import csv

from .analysis import analyze, parse_tp_bonus
from .schema import normalize


def load_rows(paths):
    rows = []
    for path in paths:
        with open(path, newline="", encoding="utf-8", errors="replace") as handle:
            rows.extend(normalize(row) for row in csv.DictReader(handle))
    return rows


def _num(value, digits=0):
    return "-" if value is None else f"{value:,.{digits}f}"


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("csv", nargs="+", help="SortieLog CSV files")
    parser.add_argument("--target", help="only this monster name")
    parser.add_argument("--tp-bonus", default="", help='e.g. "Black Halo=250,Savage Blade=250"')
    args = parser.parse_args(argv)

    rows = load_rows(args.csv)
    if args.target:
        rows = [r for r in rows if r.get("target") == args.target]
    result = analyze(rows, parse_tp_bonus(args.tp_bonus))

    print(f"{'player':12} {'target':20} {'ws':16} {'wall':>4} {'basis':14} {'n':>4} {'99999':>5} {'p10':>9} {'p50':>9} {'p90':>9} {'spread':>7}  verdict / attack check")
    for g in result["ws"]:
        attack = g.get("attack") or {}
        gain = attack.get("gain")
        attack_text = "" if not attack else f" | atk {gain * 100:+.1f}% {attack.get('verdict')}" if gain is not None else ""
        print(f"{g['player'][:12]:12} {g['target'][:20]:20} {g['ws'][:16]:16} {g['wall_same']:>4} {g['basis'][:14]:14} {g['n']:>4} {g['damage_capped']:>5} "
              f"{_num(g.get('p10')):>9} {_num(g.get('p50')):>9} {_num(g.get('p90')):>9} {_num(g.get('spread'), 3):>7}  "
              f"{g['verdict']}{attack_text}")
    if result["melee"]:
        print()
        print(f"{'player':12} {'target':20} {'hand':5} {'n':>5} {'p10':>7} {'p50':>7} {'p90':>7} {'spread':>7}  verdict (TP set)")
        for g in result["melee"]:
            print(f"{g['player'][:12]:12} {g['target'][:20]:20} {g['hand']:5} {g['n']:>5} {_num(g['p10']):>7} {_num(g['p50']):>7} "
                  f"{_num(g['p90']):>7} {_num(g['spread'], 3):>7}  {g['verdict']}")


if __name__ == "__main__":
    main()
