"""Effective DEF and EVA estimates from your own melee rows.

DEF: below the pDIF cap, non-crit melee damage is (base) x U(LL, UL) x U(1.00, 1.05), where
LL/UL depend only on the attack/defense ratio (BG-Wiki PDIF). The damage spread (p90/p10)
therefore pins the ratio, and DEF = Attack / ratio. At the cap only an upper bound remains.

EVA: hit rate = 75 + (ACC - EVA) / 2 - 2 x dLVL, floored at 20% and capped at 99%
(one-handed main hand, hand-to-hand) or 95% (two-handed). At the cap only an upper bound remains.

"Effective" means with whatever debuffs were up; rows are grouped by the debuffs seen and
your //slog flags. Level correction is a setting because it's unsettled for Sortie.
"""

import random
from collections import defaultdict
from math import sqrt
from statistics import median

from .schema import split_list

MIN_DEF_HITS = 30
MIN_EVA_SWINGS = 30
CAPPED_SPREAD = 1.06
UNCAPPED_SPREAD = 1.10
Z90 = 1.645

WEAPON_CLASS = {
    "Dagger": "1h", "Sword": "1h", "Axe": "1h", "Katana": "1h", "Club": "1h",
    "Hand-to-Hand": "h2h", "Great Katana": "gkt",
    "Great Sword": "2h", "Great Axe": "2h", "Polearm": "2h", "Staff": "2h",
    "Scythe": "scythe",
}
# Attack/defense ratio at which the non-crit pDIF cap is reached with no PDL gear (BG-Wiki).
RATIO_CAP = {"1h": 3.625, "h2h": 3.875, "gkt": 3.875, "2h": 4.125, "scythe": 4.375}
HIT_CAP = {"1h": 99.0, "h2h": 99.0, "gkt": 95.0, "2h": 95.0, "scythe": 95.0}
HIT_FLOOR = 20.0

_R_STEPS = [1.0 + 0.05 * (i + 0.5) / 10 for i in range(10)]
_P_STEPS = 100
_RATIO_MIN, _RATIO_MAX = 1.51, 9.0   # spread is monotonic in the ratio above ~1.5


def pdif_bounds(w):
    """Non-crit pDIF lower/upper bound for wRatio w (BG-Wiki PDIF, melee)."""
    if w < 0.5:
        upper = w + 0.5
    elif w < 0.7:
        upper = 1.0
    elif w < 1.2:
        upper = w + 0.3
    elif w < 1.5:
        upper = w * 1.25
    else:
        upper = w + 0.375
    if w < 0.38:
        lower = 0.0
    elif w < 1.25:
        lower = w * 1176 / 1024 - 448 / 1024
    elif w < 1.51:
        lower = 1.0
    elif w < 2.44:
        lower = min(max(w * 1176 / 1024 - 755 / 1024, 0.9968359375), 2.064882813)
    else:
        lower = w - 0.375
    return max(lower, 0.0), upper


def _quantile(ordered, q):
    pos = q * (len(ordered) - 1)
    low = int(pos)
    high = min(low + 1, len(ordered) - 1)
    return ordered[low] + (ordered[high] - ordered[low]) * (pos - low)


def model_spread(w):
    """p90/p10 of U(LL, UL) x U(1.00, 1.05) for ratio w, with no cap clipping."""
    lower, upper = pdif_bounds(w)
    values = sorted((lower + (upper - lower) * (j + 0.5) / _P_STEPS) * r
                    for j in range(_P_STEPS) for r in _R_STEPS)
    return _quantile(values, 0.9) / _quantile(values, 0.1)


_TABLE = []


def _spread_table():
    """(ratio, spread) pairs on a fine grid, ratio ascending and spread descending; built once."""
    if not _TABLE:
        steps = int((_RATIO_MAX - _RATIO_MIN) / 0.005) + 1
        _TABLE.extend((_RATIO_MIN + i * 0.005, model_spread(_RATIO_MIN + i * 0.005)) for i in range(steps))
    return _TABLE


def solve_ratio(spread):
    """Attack/defense ratio whose modeled spread matches; None if outside the solvable range."""
    table = _spread_table()
    if spread is None or spread > table[0][1] or spread < table[-1][1]:
        return None
    lo, hi = 0, len(table) - 1
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if table[mid][1] > spread:
            lo = mid
        else:
            hi = mid
    (w0, s0), (w1, s1) = table[lo], table[hi]
    return w0 if s0 == s1 else w0 + (w1 - w0) * (s0 - spread) / (s0 - s1)


def _spread(values):
    ordered = sorted(values)
    p10 = _quantile(ordered, 0.1)
    return _quantile(ordered, 0.9) / p10 if p10 else None


def _bootstrap_ratio(values, rounds=120, seed=7):
    rng = random.Random(seed)
    n = len(values)
    ratios = []
    for _ in range(rounds):
        ratio = solve_ratio(_spread([values[rng.randrange(n)] for _ in range(n)]))
        if ratio is not None:
            ratios.append(ratio)
    if len(ratios) < rounds // 2:
        return None
    ratios.sort()
    return _quantile(ratios, 0.05), _quantile(ratios, 0.95)


def _context(row):
    parts = split_list(row.get("mob_status")) + ["flag:" + f for f in split_list(row.get("flags"))]
    return ";".join(sorted(parts)) or "none"


def _main_hand(row):
    hand = row.get("hand") or 0
    if row.get("weapon") == "Hand-to-Hand":
        return hand in (0, 1)   # both fists are the same weapon; 2/3 are kicks
    return hand == 0


def estimate_defense(rows, level_diff=0):
    groups = defaultdict(lambda: {"values": [], "attacks": []})
    for row in rows:
        if (row.get("kind") != "melee" or not row.get("is_me") or row.get("crit")
                or not row.get("damage") or row.get("attack") is None or not _main_hand(row)):
            continue
        key = (row.get("actor") or row.get("uploader") or "?", row.get("target") or "?",
               row.get("weapon") or "?", int(round(row["attack"] / 25.0) * 25), _context(row))
        groups[key]["values"].append(float(row["damage"]))
        groups[key]["attacks"].append(row["attack"])

    out = []
    correction = 0.05 * level_diff
    for (player, target, weapon, _bucket, context), group in sorted(groups.items()):
        values, attack = group["values"], median(group["attacks"])
        entry = {"player": player, "target": target, "weapon": weapon, "context": context,
                 "attack": attack, "n": len(values), "spread": _spread(values) if len(values) > 1 else None,
                 "ratio": None, "ratio_raw": None, "ratio_low": None, "ratio_high": None,
                 "def": None, "def_low": None, "def_high": None, "def_max": None}
        cap = RATIO_CAP.get(WEAPON_CLASS.get(weapon, "1h"), 3.625)
        spread = entry["spread"]
        if len(values) < MIN_DEF_HITS or spread is None:
            entry["verdict"] = "need more hits"
        elif spread <= CAPPED_SPREAD:
            entry["def_max"] = attack / (cap + correction)
            entry["verdict"] = "pDIF-capped: upper bound only"
        else:
            ratio = solve_ratio(spread)
            if ratio is None:
                entry["verdict"] = "ratio below 1.5 (very high DEF)" if spread > 1.5 else "out of model range"
            else:
                entry["ratio_raw"] = ratio
                entry["ratio"] = ratio + correction
                entry["def"] = attack / entry["ratio"]
                interval = _bootstrap_ratio(values)
                if interval:
                    entry["ratio_low"], entry["ratio_high"] = interval
                    entry["def_low"] = attack / (interval[1] + correction)
                    entry["def_high"] = attack / (interval[0] + correction)
                # Above (base cap - 0.375) the weapon cap may trim the top of the range, which
                # narrows the spread and makes the ratio read high and DEF read low.
                clipped = ratio > cap - 0.75
                if spread <= UNCAPPED_SPREAD:
                    entry["verdict"] = "near cap: estimate may run low"
                elif clipped:
                    entry["verdict"] = "close to cap: true DEF may be higher"
                else:
                    entry["verdict"] = "estimate"
                if spread <= UNCAPPED_SPREAD:
                    entry["def_max"] = attack / (cap + correction)
        out.append(entry)
    return out


def _wilson(hits, n, z=Z90):
    p = hits / n
    denom = 1 + z * z / n
    centre = (p + z * z / (2 * n)) / denom
    half = z * sqrt(p * (1 - p) / n + z * z / (4 * n * n)) / denom
    return max(0.0, centre - half), min(1.0, centre + half)


def estimate_evasion(rows, level_diff=0):
    groups = defaultdict(lambda: [0, 0])
    for row in rows:
        kind = row.get("kind")
        if kind not in ("melee", "melee_miss") or not row.get("is_me") or row.get("accuracy") is None:
            continue
        if not _main_hand(row):
            continue
        key = (row.get("actor") or row.get("uploader") or "?", row.get("target") or "?",
               row.get("weapon") or "?", row["accuracy"], _context(row))
        groups[key][0 if kind == "melee" else 1] += 1

    def eva_at(rate_pct, accuracy):
        return accuracy - 2 * (rate_pct - 75 + 2 * level_diff)

    out = []
    for (player, target, weapon, accuracy, context), (hits, misses) in sorted(groups.items()):
        n = hits + misses
        cap = HIT_CAP.get(WEAPON_CLASS.get(weapon, "1h"), 95.0)
        entry = {"player": player, "target": target, "weapon": weapon, "context": context,
                 "accuracy": accuracy, "swings": n, "hits": hits, "hit_rate": hits / n * 100 if n else None,
                 "hit_low": None, "hit_high": None, "hit_cap": cap,
                 "eva": None, "eva_low": None, "eva_high": None, "eva_max": None, "eva_min": None}
        if n < MIN_EVA_SWINGS:
            entry["verdict"] = "need more swings"
            out.append(entry)
            continue
        low, high = _wilson(hits, n)
        entry["hit_low"], entry["hit_high"] = low * 100, high * 100
        if entry["hit_high"] >= cap - 0.5:
            entry["eva_max"] = eva_at(entry["hit_low"], accuracy)
            entry["verdict"] = "hit-capped: upper bound only"
        elif entry["hit_low"] <= HIT_FLOOR + 0.5:
            entry["eva_min"] = eva_at(entry["hit_high"], accuracy)
            entry["verdict"] = "at hit floor: lower bound only"
        else:
            entry["eva"] = eva_at(entry["hit_rate"], accuracy)
            entry["eva_low"] = eva_at(entry["hit_high"], accuracy)
            entry["eva_high"] = eva_at(entry["hit_low"], accuracy)
            entry["verdict"] = "estimate"
        out.append(entry)
    return out
