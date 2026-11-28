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
    parser.add_argument("--level-diff", type=float, default=0, help="monster level minus yours, for level correction")
    args = parser.parse_args(argv)

    rows = load_rows(args.csv)
    if args.target:
        rows = [r for r in rows if r.get("target") == args.target]
    result = analyze(rows, parse_tp_bonus(args.tp_bonus), args.level_diff)

    if result["targets"]:
        print(f"{'target':20} {'debuffs/flags':24} {'DEF (90%)':>22} {'conf':>5} {'EVA (90%)':>22} {'conf':>5}  status")
        for t in result["targets"]:
            cells = []
            for x in (t["def"], t["eva"]):
                if x["value"] is not None:
                    cells.append((f"{x['value']:,.0f} ({x['low']:,.0f}-{x['high']:,.0f})", f"{x['confidence']:.0f}%"))
                elif x["upper_bound"] is not None:
                    cells.append((f"<= {x['upper_bound']:,.0f}", "-"))
                elif x["lower_bound"] is not None:
                    cells.append((f">= {x['lower_bound']:,.0f}", "-"))
                else:
                    cells.append(("-", "-"))
            print(f"{t['target'][:20]:20} {t['context'][:24]:24} {cells[0][0]:>22} {cells[0][1]:>5} "
                  f"{cells[1][0]:>22} {cells[1][1]:>5}  DEF {t['def']['status']}, EVA {t['eva']['status']}")
        fit = result["level_fit"]
        print(f"Level-correction fit: {fit['verdict']}" + (f" (plausible {fit['range'][0]}-{fit['range'][1]})" if fit.get("range") else ""))
        print()
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

    if result["defense"]:
        print()
        print(f"{'player':12} {'target':20} {'debuffs/flags':24} {'attack':>6} {'n':>5} {'spread':>7} {'ratio':>6}  DEF / verdict")
        for g in result["defense"]:
            if g["def"] is not None:
                value = f"{g['def']:,.0f}" + (f" ({g['def_low']:,.0f}-{g['def_high']:,.0f})" if g["def_low"] else "")
            elif g["def_max"] is not None:
                value = f"<= {g['def_max']:,.0f}"
            else:
                value = "-"
            print(f"{g['player'][:12]:12} {g['target'][:20]:20} {g['context'][:24]:24} {_num(g['attack']):>6} {g['n']:>5} "
                  f"{_num(g['spread'], 3):>7} {_num(g['ratio'], 2):>6}  {value}  {g['verdict']}  [{g.get('check') or '-'}]")
    if result["evasion"]:
        print()
        print(f"{'player':12} {'target':20} {'debuffs/flags':24} {'acc':>6} {'swings':>6} {'hit%':>6} {'cap':>4}  EVA / verdict")
        for g in result["evasion"]:
            if g["eva"] is not None:
                value = f"{g['eva']:,.0f} ({g['eva_low']:,.0f}-{g['eva_high']:,.0f})"
            elif g["eva_max"] is not None:
                value = f"<= {g['eva_max']:,.0f}"
            elif g["eva_min"] is not None:
                value = f">= {g['eva_min']:,.0f}"
            else:
                value = "-"
            print(f"{g['player'][:12]:12} {g['target'][:20]:20} {g['context'][:24]:24} {_num(g['accuracy']):>6} "
                  f"{g['swings']:>6} {_num(g['hit_rate'], 1):>6} {g['hit_cap']:>4.0f}  {value}  {g['verdict']}  [{g.get('check') or '-'}]")
    print(f"\nLevel correction: {'off' if not args.level_diff else f'on ({args.level_diff} levels)'}")


if __name__ == "__main__":
    main()
