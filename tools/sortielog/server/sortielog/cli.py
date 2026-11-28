"""Offline analysis of SortieLog CSV files: python -m sortielog.cli logs/*.csv"""

import argparse
import csv

from .analysis import analyze, parse_tp_bonus
from .model import parse_weapon_dmg
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
    parser.add_argument("--weapon-dmg", default="", help='e.g. "Kalali:Dagger=131" to anchor base damage')
    args = parser.parse_args(argv)

    rows = load_rows(args.csv)
    if args.target:
        rows = [r for r in rows if r.get("target") == args.target]
    result = analyze(rows, parse_tp_bonus(args.tp_bonus), args.level_diff, parse_weapon_dmg(args.weapon_dmg))

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

    print()
    print("Per-target summary")
    for t in result["targets"]:
        d, e = t["def"], t["eva"]
        def_text = (f"DEF {d['value']:,.0f} ({d['low']:,.0f}-{d['high']:,.0f}), {d['confidence']:.0f}% within 5%"
                    if d.get("value") else f"DEF {d['status']}")
        eva_text = (f"EVA {e['value']:,.0f} ({e['low']:,.0f}-{e['high']:,.0f})" if e.get("value") is not None
                    else f"EVA <= {e['upper_bound']:,.0f}" if e.get("upper_bound") else f"EVA {e['status']}")
        print(f"  {t['target']}: {def_text} | {eva_text}")
        n = t.get("now")
        if n and n.get("defense"):
            print(f"    now [{n['context']}]: DEF {n['defense']:,.0f}, Attack {n['attack']:,.0f}, ratio {n['ratio']:.2f}, "
                  f"pDIF {n['pdif_low']:.2f}-{n['pdif_high']:.2f} (cap {n['pdif_cap']:.2f}), "
                  f"Attack for cap {n['attack_for_cap']:,.0f}{' - capped' if n['capped'] else ''}")
    for f in result["def_fits"]:
        print(f"\nDEF fit {f['player']} vs {f['target']} ({f['weapon']}): {f['status']}, {f.get('n', 0)} hits"
              + (f", {f['double_damage_pct']:.0f}% double damage" if f.get("double_damage_pct", 0) > 1 else "")
              + (f", base includes {', '.join(f['folded'])}" if f.get("folded") else "")
              + (f", base damage {f['base_damage']:.0f}" if f.get("base_damage") else "")
              + (f" (DMG {f['weapon_dmg']:.0f} + fSTR {f['fstr']:+.0f})" if f.get("fstr") is not None else ""))
        for e in f.get("effects", []):
            span = f" ({e['low']:+.1f}..{e['high']:+.1f})" if e.get("low") is not None else ""
            print(f"    {e['tag']:28} DEF {e['pct']:+.1f}%{span}  [{e['hits']} hits]")
        for c in f.get("contexts", []):
            p = "-" if c["fit_p"] is None else f"p={c['fit_p']:.2f}"
            print(f"    segment {c['context'][:40]:40} n={c['n']:<4} DEF {c['predicted_def']:,.0f}  {p} {c['check'] or ''}")
    for f in result["eva_fits"]:
        print(f"\nEVA fit {f['player']} vs {f['target']}: {f['status']}, {f.get('swings', 0)} swings {f.get('hands')}")
        for e in f.get("effects", []):
            print(f"    {e['tag']:28} EVA {e['offset']:+.0f}  [{e['hits']} swings]")
        for c in f.get("contexts", []):
            z = "-" if c["z"] is None else f"z={c['z']:+.1f}"
            print(f"    segment {c['context'][:40]:40} {c['hits']}/{c['swings']} hits, expected {c['expected_hits']:.1f}  {z} {c['check'] or ''}")
    print(f"\nAccuracy filled in for {result['accuracy_filled']} rows. "
          f"Level correction: {'off' if not args.level_diff else f'on ({args.level_diff} levels)'}")

if __name__ == "__main__":
    main()
