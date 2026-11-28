"""Per-target DEF/EVA summaries, data-consistency checks and a best-fit level correction.

Each group estimate (from estimate.py) is one measurement with an uncertainty taken from its
90% range. Measurements for the same target and debuff state are combined by inverse-variance
weighting. "Confidence" is the chance the true value is within +/-5% of the combined estimate.
Groups are also checked against the combined value of all the *other* groups (leave-one-out),
so a group that disagrees beyond chance is flagged: usually an unlogged debuff, a stale
Accuracy, or the wrong level-correction setting.
"""

from collections import defaultdict
from math import erf, sqrt

Z90 = 1.645
TOLERANCE = 0.05
SUSPICIOUS_Z, OUTLIER_Z = 2.0, 3.0
AGREEMENT_P = 0.05
MAX_LEVEL_DIFF = 60


def _sigma(low, high):
    if low is None or high is None or high <= low:
        return None
    return (high - low) / (2 * Z90)


def _combine(items):
    weights = [1 / s ** 2 for _, s in items]
    total = sum(weights)
    mean = sum(w * v for w, (v, _) in zip(weights, items)) / total
    chi2 = sum(((v - mean) / s) ** 2 for v, s in items)
    return mean, sqrt(1 / total), chi2


def chi2_p(chi2, dof):
    """Upper-tail p-value of a chi-square statistic (Wilson-Hilferty approximation)."""
    if dof <= 0:
        return None
    term = 2 / (9 * dof)
    z = ((chi2 / dof) ** (1 / 3) - (1 - term)) / sqrt(term)
    return 0.5 * (1 - erf(z / sqrt(2)))


def _confidence(mean, sigma):
    return erf(TOLERANCE * abs(mean) / (sigma * sqrt(2))) * 100 if sigma else None


def _summarize(estimates, upper_bounds, lower_bounds):
    """estimates: [(value, sigma)]; bounds: [value]. Returns the summary dict."""
    upper = min(upper_bounds) if upper_bounds else None
    lower = max(lower_bounds) if lower_bounds else None
    out = {"groups": len(estimates), "value": None, "low": None, "high": None, "confidence": None,
           "agreement": None, "upper_bound": upper, "lower_bound": lower}
    if not estimates:
        out["status"] = "bounds only" if (upper or lower) else "no data"
        return out
    mean, sigma, chi2 = _combine(estimates)
    dof = len(estimates) - 1
    p = chi2_p(chi2, dof)
    if p is not None and p < AGREEMENT_P:
        sigma *= sqrt(chi2 / dof)   # groups disagree more than chance: widen the uncertainty
    out.update(value=mean, low=mean - Z90 * sigma, high=mean + Z90 * sigma,
               confidence=_confidence(mean, sigma), agreement=None if p is None else p * 100)
    if upper is not None and mean - 2 * sigma > upper:
        out["status"] = "conflict: above a capped bound"
    elif lower is not None and mean + 2 * sigma < lower:
        out["status"] = "conflict: below a lower bound"
    elif p is not None and p < AGREEMENT_P:
        out["status"] = "groups disagree"
    elif len(estimates) == 1:
        out["status"] = "single group"
    else:
        out["status"] = "consistent"
    return out


def _loo_z(entry, pool):
    others = [(e["_value"], e["_sigma"]) for e in pool if e is not entry]
    if not others:
        return None, None
    mean, sigma, _ = _combine(others)
    return (entry["_value"] - mean) / sqrt(entry["_sigma"] ** 2 + sigma ** 2), (mean, sigma)


def _check(entries, key_of):
    """Leave-one-out check of each entry against the others for the same key.

    Outliers are removed one at a time (worst first) so that a bad group can't drag the
    reference value and get good groups flagged too. Removed groups are excluded from the
    per-target summary.
    """
    by_key = defaultdict(list)
    for entry in entries:
        if entry.get("_value") is not None:
            by_key[key_of(entry)].append(entry)
    trusted = {}
    for key, pool in by_key.items():
        pool = list(pool)
        while len(pool) >= 3:
            scored = [(abs(_loo_z(e, pool)[0]), e) for e in pool]
            worst_z, worst = max(scored, key=lambda item: item[0])
            if worst_z < OUTLIER_Z:
                break
            worst["_outlier"] = True
            pool.remove(worst)
        trusted[key] = pool

    for entry in entries:
        pool = trusted.get(key_of(entry), [])
        if entry.get("_value") is not None:
            z, _ = _loo_z(entry, pool)
            if z is None:
                entry["check"] = "first data"
                continue
            entry["check_z"] = z
            entry["check"] = ("outlier" if entry.get("_outlier") or abs(z) >= OUTLIER_Z else
                              "suspicious" if abs(z) >= SUSPICIOUS_Z else "consistent")
        elif entry.get("_bound") is not None:
            if not pool:
                entry["check"] = "first data"
                continue
            mean, sigma, _ = _combine([(e["_value"], e["_sigma"]) for e in pool])
            if entry["_bound_type"] == "upper":
                entry["check"] = "conflict" if mean - 2 * sigma > entry["_bound"] else "consistent"
            else:
                entry["check"] = "conflict" if mean + 2 * sigma < entry["_bound"] else "consistent"


def _prepare_defense(entries):
    for e in entries:
        e["_value"] = e["_sigma"] = e["_bound"] = e["_bound_type"] = None
        if e.get("verdict") == "estimate" and _sigma(e.get("def_low"), e.get("def_high")):
            e["_value"], e["_sigma"] = e["def"], _sigma(e["def_low"], e["def_high"])
        elif e.get("verdict", "").startswith("close to cap") and e.get("def") is not None:
            e["_bound"], e["_bound_type"] = e["def"], "lower"      # true DEF is likely higher
        elif e.get("def_max") is not None:
            e["_bound"], e["_bound_type"] = e["def_max"], "upper"


def _prepare_evasion(entries):
    for e in entries:
        e["_value"] = e["_sigma"] = e["_bound"] = e["_bound_type"] = None
        if e.get("verdict") == "estimate" and _sigma(e.get("eva_low"), e.get("eva_high")):
            e["_value"], e["_sigma"] = e["eva"], _sigma(e["eva_low"], e["eva_high"])
        elif e.get("eva_max") is not None:
            e["_bound"], e["_bound_type"] = e["eva_max"], "upper"
        elif e.get("eva_min") is not None:
            e["_bound"], e["_bound_type"] = e["eva_min"], "lower"


def _key(entry):
    return (entry["target"], entry["context"])


def summarize_targets(defense, evasion):
    """Adds check/check_z to each entry and returns one summary row per (target, debuff state)."""
    _prepare_defense(defense)
    _prepare_evasion(evasion)
    _check(defense, _key)
    _check(evasion, _key)

    keys = sorted({_key(e) for e in defense} | {_key(e) for e in evasion})
    out = []
    for key in keys:
        row = {"target": key[0], "context": key[1]}
        for name, entries in (("def", defense), ("eva", evasion)):
            mine = [e for e in entries if _key(e) == key]
            row[name] = _summarize(
                [(e["_value"], e["_sigma"]) for e in mine if e["_value"] is not None and not e.get("_outlier")],
                [e["_bound"] for e in mine if e["_bound_type"] == "upper"],
                [e["_bound"] for e in mine if e["_bound_type"] == "lower"])
            row[name]["samples"] = sum(e.get("n") or e.get("swings") or 0 for e in mine)
            row[name]["excluded"] = sum(1 for e in mine if e.get("_outlier"))
            if row[name]["excluded"] and row[name]["status"] in ("consistent", "single group"):
                row[name]["status"] = f"consistent ({row[name]['excluded']} outlier excluded)"
        out.append(row)

    for entries in (defense, evasion):
        for e in entries:
            for field in ("_value", "_sigma", "_bound", "_bound_type", "_outlier"):
                e.pop(field, None)
    return out


def fit_level_diff(defense, current=0):
    """Level difference that makes DEF estimates agree across different Attack values.

    Level correction subtracts 0.05 x levels from the attack/defense ratio. That shifts DEF
    by a different amount at each Attack value, so groups at different Attack only agree under
    the right setting. (EVA's correction is a constant offset, so it can't be fitted this way.)
    """
    by_key = defaultdict(list)
    for e in defense:
        if e.get("verdict") == "estimate" and e.get("ratio_low") and e.get("ratio_high"):
            by_key[_key(e)].append(e)
    usable = {k: v for k, v in by_key.items()
              if len(v) >= 2 and max(e["attack"] for e in v) >= 1.05 * min(e["attack"] for e in v)}
    dof = sum(len(v) - 1 for v in usable.values())
    if dof < 2:
        return {"best_level_diff": None, "dof": dof, "verdict": "needs groups at clearly different Attack values"}

    def total_chi2(levels):
        c = 0.05 * levels
        chi2 = 0.0
        for group in usable.values():
            items = []
            for e in group:
                value = e["attack"] / (e["ratio_raw"] + c)
                sigma = _sigma(e["attack"] / (e["ratio_high"] + c), e["attack"] / (e["ratio_low"] + c))
                items.append((value, sigma))
            chi2 += _combine(items)[2]
        return chi2

    scores = [(total_chi2(level), level) for level in range(0, MAX_LEVEL_DIFF + 1)]
    best_chi2, best = min(scores)
    plausible = [level for chi2, level in scores if chi2 <= best_chi2 + 2.71]   # 90% range
    current_chi2 = total_chi2(current)
    better = current_chi2 - best_chi2 >= 4 and not min(plausible) <= current <= max(plausible)
    return {
        "best_level_diff": best, "range": [min(plausible), max(plausible)], "dof": dof,
        "chi2_best": best_chi2, "chi2_current": current_chi2,
        "agreement_best": chi2_p(best_chi2, dof) * 100, "agreement_current": chi2_p(current_chi2, dof) * 100,
        "verdict": (f"data fits level correction {min(plausible)}-{max(plausible)} (best {best}) "
                    f"clearly better than the current {current:g}"
                    if better and best != current else "current setting fits the data"),
    }
