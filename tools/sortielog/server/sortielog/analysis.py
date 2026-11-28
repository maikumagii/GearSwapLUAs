"""pDIF-cap heuristics from logged damage.

At the pDIF cap both pDIF bounds clamp to the cap and only the final 1.00-1.05
randomizer remains, so same-condition damage spreads by roughly 5%. Below the cap
the lower/upper bounds sit apart and the spread is visibly wider. A second signal
is attack sensitivity: if damage rises with more attack buffs, you are not capped.
"""

from collections import defaultdict
from statistics import median

from .aggregate import fit_level_diff, summarize_targets
from .estimate import estimate_defense, estimate_evasion
from .schema import split_list

DAMAGE_CAP = 99999

# fTP at 1000/2000/3000 TP, plus summed fTP of the extra non-replicating hits.
# Only WS whose values are well established are listed; others fall back to TP bands.
FTP_TABLE = {
    "Black Halo": ((3.0, 7.25, 9.75), 1.0),
    "Savage Blade": ((4.0, 10.25, 13.75), 1.0),
    "Rudra's Storm": ((5.0, 10.19, 13.0), 0.0),
    "Judgment": ((3.5, 8.75, 12.0), 0.0),
    "Origin": ((3.0, 6.0, 9.0), 0.0),
}

ATTACK_BUFFS = {
    "attack boost", "berserk", "warcry", "chaos roll", "last resort", "blood rage",
    "souleater", "focus", "minuet",
}

MIN_SAMPLES = 8
CAPPED_SPREAD = 1.06     # p90/p10 at or below: consistent with the 1.00-1.05 randomizer only
UNCAPPED_SPREAD = 1.10   # above: pDIF bounds are still apart
ATTACK_SENSITIVE = 0.03  # median damage gain between lowest and highest attack-buff score


def parse_tp_bonus(text):
    """'Black Halo=250,Savage Blade=250' -> {'Black Halo': 250, ...}"""
    bonus = {}
    for part in (text or "").split(","):
        if "=" in part:
            name, value = part.split("=", 1)
            try:
                bonus[name.strip()] = int(value)
            except ValueError:
                continue
    return bonus


def ftp_at(ws, tp, tp_bonus=0):
    entry = FTP_TABLE.get(ws)
    if entry is None or tp is None:
        return None
    (f1, f2, f3), extra = entry
    effective = max(1000, min(3000, tp + tp_bonus))
    if effective <= 2000:
        value = f1 + (f2 - f1) * (effective - 1000) / 1000
    else:
        value = f2 + (f3 - f2) * (effective - 2000) / 1000
    return value + extra


def quantile(sorted_values, q):
    if not sorted_values:
        return None
    if len(sorted_values) == 1:
        return sorted_values[0]
    pos = q * (len(sorted_values) - 1)
    low = int(pos)
    high = min(low + 1, len(sorted_values) - 1)
    return sorted_values[low] + (sorted_values[high] - sorted_values[low]) * (pos - low)


def spread_verdict(spread, n):
    if n < MIN_SAMPLES or spread is None:
        return "need more data"
    if spread <= CAPPED_SPREAD:
        return "likely capped"
    if spread > UNCAPPED_SPREAD:
        return "likely below cap"
    return "borderline"


def spread_stats(values):
    ordered = sorted(values)
    n = len(ordered)
    p10, p50, p90 = (quantile(ordered, q) for q in (0.1, 0.5, 0.9))
    spread = (p90 / p10) if p10 else None
    return {
        "n": n,
        "p10": p10,
        "p50": p50,
        "p90": p90,
        "min": ordered[0] if ordered else None,
        "max": ordered[-1] if ordered else None,
        "spread": spread,
        "verdict": spread_verdict(spread, n),
    }


def attack_score(buffs):
    score = 0
    for name in split_list(buffs):
        lowered = name.lower()
        if lowered in ATTACK_BUFFS or "minuet" in lowered:
            score += 1
    return score


def _attack_sensitivity(samples):
    by_score = defaultdict(list)
    for value, score in samples:
        by_score[score].append(value)
    usable = {score: vals for score, vals in by_score.items() if len(vals) >= 3}
    if len(usable) < 2:
        return None
    low, high = min(usable), max(usable)
    low_median, high_median = median(usable[low]), median(usable[high])
    gain = high_median / low_median - 1 if low_median else None
    return {
        "scores": {str(score): {"n": len(vals), "median": median(vals)} for score, vals in sorted(usable.items())},
        "gain": gain,
        "verdict": None if gain is None else ("attack-sensitive: below cap" if gain >= ATTACK_SENSITIVE else "flat: consistent with cap"),
    }


def analyze(rows, tp_bonus=None, level_diff=0):
    """rows: iterable of normalized dicts. Returns WS and melee group summaries."""
    tp_bonus = tp_bonus or {}
    ws_groups = defaultdict(lambda: {"values": [], "samples": [], "capped_hits": 0})
    melee_groups = defaultdict(list)

    rows = list(rows)
    for row in rows:
        kind, damage = row.get("kind"), row.get("damage")
        if not row.get("is_me") or not damage or damage <= 0:
            continue
        target = row.get("target") or "?"
        player = row.get("actor") or row.get("uploader") or "?"
        if kind == "ws":
            ws = row.get("ws") or "?"
            wall = min(row.get("wall_same") or 0, 3)
            ftp = ftp_at(ws, row.get("tp"), tp_bonus.get(ws, 0))
            if ftp is not None:
                key = (player, target, ws, wall, "fTP-normalized")
            else:
                tp = row.get("tp")
                band = "TP ?" if tp is None else "TP %d-%d" % (tp // 250 * 250, tp // 250 * 250 + 249)
                key = (player, target, ws, wall, band)
            group = ws_groups[key]
            if damage >= DAMAGE_CAP:
                group["capped_hits"] += 1
                continue
            value = damage / ftp if ftp else float(damage)
            group["values"].append(value)
            group["samples"].append((value, attack_score(row.get("buffs"))))
        elif kind == "melee" and not row.get("crit"):
            melee_groups[(player, target, row.get("hand") or 0)].append(float(damage))

    ws_out = []
    for (player, target, ws, wall, basis), group in sorted(ws_groups.items()):
        entry = {"player": player, "target": target, "ws": ws, "wall_same": wall, "basis": basis,
                 "damage_capped": group["capped_hits"]}
        entry.update(spread_stats(group["values"]) if group["values"] else {"n": 0, "verdict": "only 99,999 hits" if group["capped_hits"] else "need more data"})
        entry["attack"] = _attack_sensitivity(group["samples"])
        ws_out.append(entry)

    melee_out = []
    for (player, target, hand), values in sorted(melee_groups.items()):
        entry = {"player": player, "target": target, "hand": "off" if hand == 1 else "main"}
        entry.update(spread_stats(values))
        melee_out.append(entry)

    defense = estimate_defense(rows, level_diff)
    evasion = estimate_evasion(rows, level_diff)
    return {
        "ws": ws_out,
        "melee": melee_out,
        "targets": summarize_targets(defense, evasion),
        "defense": defense,
        "evasion": evasion,
        "level_diff": level_diff,
        "level_fit": fit_level_diff(defense, level_diff),
    }
