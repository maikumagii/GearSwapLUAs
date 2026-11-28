"""Per-target likelihood fits for effective DEF and evasion, using every hit and swing.

DEF: each non-crit main-hand hit is modeled as
    damage = M x B x U(LL(w), UL(w)) x U(1.00, 1.05),  w = Attack / DEF - 0.05 x levels
where M is 1, 2 or 3 (weapons that "occasionally deal double/triple damage", e.g. relics)
with frequencies fitted from the data
with LL/UL from BG-Wiki's pDIF bounds, B the hit's base damage (weapon + fSTR, constant for
a player, weapon and target), and DEF = baseDEF x product of each DEF-relevant debuff's
multiplier for the debuffs up at that hit. Each hit's own Attack is used, so Attack changes
help the fit instead of splitting the data into small groups.

EVA: each main- or off-hand swing hits with probability
    clamp(75 + (ACC - EVA) / 2 - 2 x levels, 20, cap)
with ACC the hand's measured Accuracy and EVA = baseEVA + each EVA-relevant debuff's offset.

Debuffs that can't change DEF (or EVA) are ignored by that fit; debuffs up for nearly every
hit are folded into the base; rare ones are left out (with their hits) until there's data.
Each fight segment is checked against the fit, so data that doesn't match stands out.
"""

import math
import re
from collections import Counter, defaultdict

from .estimate import HIT_CAP, HIT_FLOOR, RATIO_CAP, WEAPON_CLASS, pdif_bounds
from .schema import split_list

Z90 = 1.645
NLL_90 = 1.35            # profile-likelihood drop for a 90% interval
OUTLIER_SHARE = 0.02     # hits allowed to come from something else (procs, odd swings)
MIN_DEF_HITS = 30
MIN_EVA_SWINGS = 40
MIN_TAG_HITS = 10
FOLD_SHARE = 0.95
R_LO, R_HI = 1.0, 1.05

DEF_PATTERNS = [r"^Dia", r"^Box Step", r"Frailty", r"Defense Down", r"Armor Break", r"Angon",
                r"Swooping", r"Light Shot", r"Shell Crusher", r"Corrosive", r"Acid Mist"]
EVA_PATTERNS = [r"^Distract", r"^Quick Step", r"Torpor", r"Evasion Down", r"Feint"]


def relevant_tags(row, patterns):
    tags = split_list(row.get("mob_status")) + ["flag:" + f for f in split_list(row.get("flags"))]
    return frozenset(t for t in tags if any(re.search(p, t.replace("flag:", ""), re.I) for p in patterns))


def _label(tags):
    return ";".join(sorted(tags)) or "none"


# ---------------------------------------------------------------- numerical helpers

def nelder_mead(f, start, step, iters=500, tol=1e-6):
    n = len(start)
    simplex = [list(start)]
    for i in range(n):
        point = list(start)
        point[i] += step[i]
        simplex.append(point)
    values = [f(p) for p in simplex]
    for _ in range(iters):
        order = sorted(range(n + 1), key=values.__getitem__)
        simplex = [simplex[i] for i in order]
        values = [values[i] for i in order]
        if abs(values[-1] - values[0]) < tol:
            break
        centroid = [sum(p[j] for p in simplex[:-1]) / n for j in range(n)]
        worst = simplex[-1]
        reflected = [c + (c - w) for c, w in zip(centroid, worst)]
        fr = f(reflected)
        if fr < values[0]:
            expanded = [c + 2 * (c - w) for c, w in zip(centroid, worst)]
            fe = f(expanded)
            simplex[-1], values[-1] = (expanded, fe) if fe < fr else (reflected, fr)
        elif fr < values[-2]:
            simplex[-1], values[-1] = reflected, fr
        else:
            contracted = [c + 0.5 * (w - c) for c, w in zip(centroid, worst)]
            fc = f(contracted)
            if fc < values[-1]:
                simplex[-1], values[-1] = contracted, fc
            else:
                best = simplex[0]
                simplex = [best] + [[b + 0.5 * (p - b) for b, p in zip(best, point)] for point in simplex[1:]]
                values = [values[0]] + [f(p) for p in simplex[1:]]
    i = min(range(n + 1), key=values.__getitem__)
    return simplex[i], values[i]


def _invert(matrix):
    n = len(matrix)
    a = [list(row) + [1.0 if i == j else 0.0 for j in range(n)] for i, row in enumerate(matrix)]
    for col in range(n):
        pivot = max(range(col, n), key=lambda r: abs(a[r][col]))
        if abs(a[pivot][col]) < 1e-12:
            return None
        a[col], a[pivot] = a[pivot], a[col]
        scale = a[col][col]
        a[col] = [v / scale for v in a[col]]
        for r in range(n):
            if r != col and a[r][col]:
                factor = a[r][col]
                a[r] = [v - factor * w for v, w in zip(a[r], a[col])]
    return [row[n:] for row in a]


def standard_errors(f, point, steps):
    """SEs from a finite-difference Hessian of the negative log-likelihood (None if not identifiable)."""
    n = len(point)
    f0 = f(point)
    hessian = [[0.0] * n for _ in range(n)]
    for i in range(n):
        for j in range(i, n):
            hi, hj = steps[i], steps[j]
            def at(di, dj):
                p = list(point)
                p[i] += di
                p[j] += dj
                return f(p)
            if i == j:
                value = (at(hi, 0) - 2 * f0 + at(-hi, 0)) / (hi * hi)
            else:
                value = (at(hi, hj) - at(hi, -hj) - at(-hi, hj) + at(-hi, -hj)) / (4 * hi * hj)
            hessian[i][j] = hessian[j][i] = value
    inverse = _invert(hessian)
    if inverse is None:
        return [None] * n
    return [math.sqrt(inverse[i][i]) if inverse[i][i] > 0 else None for i in range(n)]


def ks_p(values):
    """p-value that values look uniform on [0, 1] (Kolmogorov-Smirnov, asymptotic)."""
    n = len(values)
    if n < 5:
        return None
    ordered = sorted(values)
    d = max(max((i + 1) / n - v, v - i / n) for i, v in enumerate(ordered))
    lam = (math.sqrt(n) + 0.12 + 0.11 / math.sqrt(n)) * d
    p = 2 * sum((-1) ** (k - 1) * math.exp(-2 * k * k * lam * lam) for k in range(1, 101))
    return min(max(p, 0.0), 1.0)


def _within_5pct(se_log):
    return math.erf(math.log(1.05) / (se_log * math.sqrt(2))) * 100 if se_log else None


# ---------------------------------------------------------------- shared tag handling

def _select_tags(samples, tag_of):
    """Folds near-universal tags into the base and drops rare ones (with their samples)."""
    counts = Counter(t for s in samples for t in tag_of(s))
    n = len(samples)
    folded = sorted(t for t, c in counts.items() if c >= FOLD_SHARE * n)
    rare = {t for t, c in counts.items() if c < MIN_TAG_HITS}
    kept = [s for s in samples if not (tag_of(s) & rare)]
    params = sorted({t for s in kept for t in tag_of(s)} - set(folded))
    return kept, folded, params, n - len(kept)


# ---------------------------------------------------------------- DEF

def _pdif_density(x, lower, upper):
    if upper <= lower or x <= 0:
        return 0.0
    r_lo = max(R_LO, x / upper)
    r_hi = min(R_HI, x / lower) if lower > 0 else R_HI
    if r_hi <= r_lo:
        return 0.0
    return math.log(r_hi / r_lo) / ((upper - lower) * (R_HI - R_LO))


def _pdif_cdf(x, lower, upper, steps=24):
    total = 0.0
    for k in range(steps):
        r = R_LO + (R_HI - R_LO) * (k + 0.5) / steps
        total += min(max((x / r - lower) / (upper - lower), 0.0), 1.0)
    return total / steps


def _bounds(w):
    lower, upper = pdif_bounds(max(w, 0.05))
    return lower, max(upper, lower + 1e-6)


MULTIPLIERS = (1.0, 2.0, 3.0)


def _mix(theta_a2, theta_a3):
    weights = (1.0, math.exp(theta_a2), math.exp(theta_a3))
    total = sum(weights)
    return [w / total for w in weights]


MAX_EXCLUDED_SEGMENTS = 3
BAD_FIT_P = 0.01


PDIF_CAP = {"1h": 3.25, "h2h": 3.5, "gkt": 3.5, "2h": 3.75, "scythe": 4.0}   # non-crit, no PDL gear

# Plausible base damage (weapon DMG + fSTR) per weapon type, used when rows don't say which
# weapon was equipped. Deliberately generous; it only rules out impossible readings (like a
# dagger hitting for base 225), which is what makes some damage spreads ambiguous.
TYPE_BASE_RANGE = {
    "Dagger": (60, 190), "Sword": (80, 240), "Club": (80, 240), "Axe": (90, 250), "Katana": (80, 230),
    "Hand-to-Hand": (20, 260), "Great Katana": (120, 330), "Great Sword": (140, 400),
    "Great Axe": (140, 420), "Polearm": (140, 400), "Scythe": (140, 420), "Staff": (90, 330),
}
# fSTR range allowed when each hit's weapon DMG is known (base damage = DMG + fSTR).
FSTR_RANGE = (-20.0, 40.0)


def fit_defense_one(samples, level_diff=0, weapon=None):
    """Fits, then refits without the worst segment that doesn't fit (up to 3 times), so one
    segment with an unseen debuff can't drag the base and make good segments look bad."""
    excluded = []
    fit = _fit_defense_core(samples, level_diff, weapon)
    for _ in range(MAX_EXCLUDED_SEGMENTS):
        if fit.get("status") != "estimate":
            break
        bad = [c for c in fit["contexts"] if c["fit_p"] is not None and c["fit_p"] < BAD_FIT_P]
        if not bad:
            break
        if len(bad) < len(fit["contexts"]):
            candidates = [min(bad, key=lambda c: c["fit_p"])]
        elif len(fit["contexts"]) >= 3:
            # Everything misfits: one bad segment may have pulled the whole fit off. Try leaving
            # each segment out and keep the refit where the most remaining segments fit.
            candidates = [c for c in fit["contexts"] if c["n"] >= 15]
        else:
            break
        best = None
        for candidate in candidates:
            remaining = [s for s in samples if _label(s["tags"] - set(fit["folded"])) != candidate["context"]]
            refit = _fit_defense_core(remaining, level_diff, weapon)
            if refit.get("status") != "estimate":
                continue
            good = sum(1 for c in refit["contexts"] if c["fit_p"] is not None and c["fit_p"] >= BAD_FIT_P)
            score = (good, -candidate["n"], -refit["nll"] / refit["n"])   # most fitting, then keep the most data
            if best is None or score > best[0]:
                best = (score, candidate, remaining, refit)
        if best is None:
            break
        _, candidate, remaining, refit = best
        excluded.append(dict(candidate, check="doesn't fit (excluded)"))
        samples, fit = remaining, refit
    if fit.get("status") == "estimate":
        fit["contexts"] = fit["contexts"] + excluded
        fit["excluded_hits"] = sum(c["n"] for c in excluded)
    return fit


def _fit_defense_core(samples, level_diff=0, weapon=None):
    """samples: dicts with damage, attack, tags (frozenset) and dmg (weapon DMG or None).

    With every hit's weapon DMG known, base damage per hit is DMG + fSTR (one fitted fSTR), so
    weapon swaps are handled. Otherwise one base damage is fitted, held to the weapon type's
    plausible range."""
    kept, folded, params, dropped = _select_tags(samples, lambda s: s["tags"])
    if len(kept) < MIN_DEF_HITS:
        return {"status": "need more hits", "n": len(kept), "dropped": dropped, "folded": folded}
    use_dmg = all(s.get("dmg") for s in kept)
    b_range = None if use_dmg else TYPE_BASE_RANGE.get(weapon)
    correction = 0.05 * level_diff
    index = {t: i for i, t in enumerate(params)}
    data = [(s["damage"], s["attack"], [index[t] for t in s["tags"] if t in index], s.get("dmg") or 0.0)
            for s in kept]
    uniform = OUTLIER_SHARE / (max(d[0] for d in data) * 1.3)
    min_dmg = min(d[3] for d in data)
    dmgs = sorted(d[3] for d in data)
    typical_dmg = dmgs[len(dmgs) // 2]
    n_tags = len(params)

    def base_of(theta, dmg):
        return dmg + theta[0] if use_dmg else math.exp(theta[0])

    def nll(theta):
        log_def = theta[1]
        mix = _mix(theta[2 + n_tags], theta[3 + n_tags])
        total = 0.0
        if use_dmg:
            if min_dmg + theta[0] <= 1:
                return 1e12
            if theta[0] < FSTR_RANGE[0]:
                total += 1e3 * ((FSTR_RANGE[0] - theta[0]) / 5) ** 2
            elif theta[0] > FSTR_RANGE[1]:
                total += 1e3 * ((theta[0] - FSTR_RANGE[1]) / 5) ** 2
        elif b_range:
            log_b = theta[0]
            if log_b < math.log(b_range[0]):
                total += 1e4 * (math.log(b_range[0]) - log_b) ** 2
            elif log_b > math.log(b_range[1]):
                total += 1e4 * (log_b - math.log(b_range[1])) ** 2
        for damage, attack, tag_ids, dmg in data:
            base = base_of(theta, dmg)
            defense = math.exp(log_def + sum(theta[2 + k] for k in tag_ids))
            lower, upper = _bounds(attack / defense - correction)
            density = sum(q * _pdif_density(damage / (m * base), lower, upper) / (m * base)
                          for q, m in zip(mix, MULTIPLIERS))
            total -= math.log((1 - OUTLIER_SHARE) * density + uniform)
        return total

    damages = sorted(d[0] for d in data)
    low_damage = damages[len(damages) // 4]   # lower quartile: mostly x1 hits
    median_attack = sorted(d[1] for d in data)[len(data) // 2]
    step0 = (8.0, 3.0, 1.0) if use_dmg else (0.15, 0.05, 0.02)
    # The likelihood has local dips (the damage spread can fit two different ratios), so search
    # from many ratios and both a low and a high double-damage share, then polish the best three.
    candidates = []
    for ratio in (0.55, 0.75, 0.95, 1.15, 1.35, 1.6, 1.9, 2.3, 2.8, 3.4):
        lower, upper = _bounds(ratio)
        base_start = low_damage / ((lower + upper) / 2 * 1.025)
        if use_dmg:
            first = min(max(base_start - typical_dmg, FSTR_RANGE[0]), FSTR_RANGE[1])
        else:
            if b_range:
                base_start = min(max(base_start, b_range[0]), b_range[1])
            first = math.log(base_start)
        for double in (-2.0, -0.8):
            start = [first, math.log(median_attack / (ratio + correction))] + [0.0] * n_tags + [double, -4.0]
            candidates.append(nelder_mead(nll, start, [step0[0], 0.15] + [0.1] * n_tags + [0.5, 0.5], iters=250))
    candidates.sort(key=lambda c: c[1])
    polished = [nelder_mead(nll, point, [step0[1], 0.05] + [0.05] * n_tags + [0.3, 0.3], iters=700)
                for point, _ in candidates[:3]]
    point, value = min(polished, key=lambda c: c[1])
    point, value = nelder_mead(nll, point, [step0[2], 0.02] + [0.02] * n_tags + [0.1, 0.1], iters=400)
    # A clearly different DEF that fits about as well means the spread alone can't decide.
    alternatives = []
    for other, other_value in sorted(polished + candidates[3:8], key=lambda c: c[1]):
        if other_value - value < 2.0 and abs(other[1] - point[1]) > math.log(1.15):
            if all(abs(other[1] - math.log(a["def"])) > math.log(1.05) for a in alternatives):
                alternatives.append({"def": math.exp(other[1]), "base_damage": base_of(other, typical_dmg),
                                     "nll_gap": other_value - value})
    mix = _mix(point[2 + n_tags], point[3 + n_tags])
    # Uncertainties with the x2/x3 frequencies held at their fit (a share fitted to ~0 sits on
    # a boundary and would make the full Hessian singular).
    fixed_tail = point[2 + n_tags:]
    ses = standard_errors(lambda core: nll(list(core) + fixed_tail), point[:2 + n_tags],
                          [0.5 if use_dmg else 2e-2] + [2e-2] * (1 + n_tags))

    log_def, se = point[1], ses[1]
    base_def = math.exp(log_def)
    ratios = sorted(d[1] / math.exp(log_def + sum(point[2 + k] for k in d[2])) - correction for d in data)
    median_ratio = ratios[len(ratios) // 2]

    effects = []
    for tag, k in index.items():
        theta, se_k = point[2 + k], ses[2 + k]
        effects.append({
            "tag": tag, "hits": sum(1 for d in data if k in d[2]),
            "pct": (math.exp(theta) - 1) * 100,
            "low": (math.exp(theta - Z90 * se_k) - 1) * 100 if se_k else None,
            "high": (math.exp(theta + Z90 * se_k) - 1) * 100 if se_k else None,
        })

    contexts = []
    by_context = defaultdict(list)
    for item, s in zip(data, kept):
        by_context[_label(s["tags"] - set(folded))].append(item)
    for label, items in sorted(by_context.items(), key=lambda kv: -len(kv[1])):
        defense = math.exp(log_def + sum(point[2 + k] for k in items[0][2]))
        pits = []
        for damage, attack, _, dmg in items:
            base = base_of(point, dmg)
            lower, upper = _bounds(attack / defense - correction)
            pits.append(sum(q * _pdif_cdf(damage / (m * base), lower, upper) for q, m in zip(mix, MULTIPLIERS)))
        p = ks_p(pits)
        contexts.append({
            "context": label, "n": len(items), "predicted_def": defense,
            "attack": sorted(d[1] for d in items)[len(items) // 2],
            "fit_p": p, "check": None if p is None else ("fits" if p >= 0.01 else "doesn't fit"),
        })

    return {
        "status": "estimate", "n": len(kept), "dropped": dropped, "folded": folded,
        "base_def": base_def,
        "low": math.exp(log_def - Z90 * se) if se else None,
        "high": math.exp(log_def + Z90 * se) if se else None,
        "se_log": se, "confidence": _within_5pct(se),
        "base_damage": base_of(point, typical_dmg), "median_ratio": median_ratio,
        "weapon_dmg": typical_dmg if use_dmg else None, "fstr": point[0] if use_dmg else None,
        "base_range": b_range,
        "double_damage_pct": mix[1] * 100, "triple_damage_pct": mix[2] * 100,
        "effects": effects, "contexts": contexts, "nll": value, "alternatives": alternatives,
    }


def current_state(fit, samples, level_diff, weapon_class):
    """DEF under the debuffs up at your most recent hit, with your Attack then, the resulting
    Attack/DEF ratio and pDIF range, and the Attack you'd need to reach the pDIF cap."""
    latest = max(samples, key=lambda s: s["t"])
    tags = latest["tags"] - set(fit.get("folded", []))
    effects = {e["tag"]: e["pct"] for e in fit.get("effects", [])}
    unknown = sorted(t for t in tags if t not in effects)
    state = {"context": _label(latest["tags"]), "attack": latest["attack"], "t": latest["t"], "unknown": unknown}
    if unknown:
        return state   # a debuff with no measured effect yet: DEF unknown
    defense = fit["base_def"]
    for tag in tags:
        defense *= 1 + effects[tag] / 100
    correction = 0.05 * level_diff
    ratio = latest["attack"] / defense - correction
    lower, upper = pdif_bounds(max(ratio, 0.05))
    cap = PDIF_CAP.get(weapon_class, 3.25)
    cap_ratio = RATIO_CAP.get(weapon_class, 3.625)
    state.update(defense=defense, ratio=ratio, pdif_low=min(lower, cap), pdif_high=min(upper, cap),
                 pdif_cap=cap, capped=ratio >= cap_ratio, attack_for_cap=(cap_ratio + correction) * defense)
    return state


def fit_defense(rows, level_diff=0):
    """One fit per player, target and weapon type. Hits with and without weapon DMG on the row
    are fitted separately (the DMG ones as DMG + fSTR, the others within the type's range)."""
    groups = defaultdict(list)
    for row in rows:
        if (row.get("kind") != "melee" or not row.get("is_me") or row.get("crit")
                or not row.get("damage") or not row.get("attack")):
            continue
        weapon = row.get("weapon") or "?"
        hand = row.get("hand") or 0
        if not (hand == 0 or (weapon == "Hand-to-Hand" and hand == 1)):
            continue
        dmg = row.get("main_dmg")
        key = (row.get("actor") or row.get("uploader") or "?", row.get("target") or "?", weapon, bool(dmg))
        groups[key].append({"damage": float(row["damage"]), "attack": float(row["attack"]),
                            "tags": relevant_tags(row, DEF_PATTERNS), "t": row.get("t") or 0,
                            "dmg": float(dmg) if dmg else None})
    out = []
    for (player, target, weapon, has_dmg), samples in sorted(groups.items()):
        fit = fit_defense_one(samples, level_diff, weapon) or {}
        fit.update(player=player, target=target, weapon=weapon, dmg_known=has_dmg)
        weapon_class = WEAPON_CLASS.get(weapon, "1h")
        cap = RATIO_CAP.get(weapon_class, 3.625)
        if fit.get("status") == "estimate" and fit.get("alternatives"):
            others = ", ".join(f"{a['def']:,.0f}" for a in fit["alternatives"])
            fit["status"] = (f"ambiguous: DEF {others} fits about as well; "
                             "record weapon DMG (sortielog.admin set-weapon) to decide")
        if fit.get("status") == "estimate" or (fit.get("status", "").startswith("ambiguous")):
            fit["now"] = current_state(fit, samples, level_diff, weapon_class)
            if fit["median_ratio"] >= cap:
                attack = sorted(s["attack"] for s in samples)[len(samples) // 2]
                fit.update(status="pDIF-capped: upper bound only", def_max=attack / (cap + 0.05 * level_diff))
            elif fit["median_ratio"] > cap - 0.75:
                fit["status"] = "near cap: DEF may read low"
        out.append(fit)
    return out


# ---------------------------------------------------------------- Accuracy fill-in

# Buffs that come and go constantly but can't change Accuracy (same list as the addon's).
VOLATILE_BUFFS = [r"^Finishing Move", r"^Copy Image", r"Samba", r"Saber Dance", r"Fan Dance", r"^Haste",
                  r"^Flurry", r"^Refresh", r"^Regen", r"^Protect", r"^Shell", r"^Phalanx", r"^Stoneskin",
                  r"^Blink", r"^Aquaveil", r"^Reraise", r"^Sneak", r"^Invisible", r"^Deodorize", r"Spikes$",
                  r"^Third Eye", r"^Seigan", r"^Sublimation", r"^Presto", r"^Contradance", r"^Grand Pas",
                  r"^Climactic", r"^Striking", r"^Ternary", r"^Building", r"^Wild Flourish", r"^Healing",
                  r"^Dedication", r"^Commitment", r"^Weakness"]
FILL_WINDOW = 600


def accuracy_state(buffs):
    return tuple(sorted(b for b in split_list(buffs) if not any(re.search(p, b) for p in VOLATILE_BUFFS)))


def fill_accuracy(rows):
    """Copies Accuracy onto rows that lack it from the nearest row (same session and player,
    within 10 minutes) whose Accuracy-relevant buffs match. Older addons re-measure on every
    Finishing Move change, so most of their rows arrive without Accuracy.
    Returns (rows, filled_count); input rows are not modified."""
    known = defaultdict(list)
    for row in rows:
        if row.get("is_me") and row.get("accuracy") is not None and row.get("t") is not None:
            key = (row.get("session"), row.get("actor"), accuracy_state(row.get("buffs")))
            known[key].append((row["t"], row["accuracy"], row.get("acc_sub")))
    out, filled = [], 0
    for row in rows:
        if (row.get("is_me") and row.get("accuracy") is None and row.get("t") is not None
                and row.get("kind") in ("melee", "melee_miss")):
            options = known.get((row.get("session"), row.get("actor"), accuracy_state(row.get("buffs"))))
            if options:
                t, acc, sub = min(options, key=lambda o: abs(o[0] - row["t"]))
                if abs(t - row["t"]) <= FILL_WINDOW:
                    row = dict(row, accuracy=acc, acc_sub=sub, acc_filled=1)
                    filled += 1
        out.append(row)
    return out, filled


# ---------------------------------------------------------------- EVA

def fit_evasion_one(samples, level_diff=0):
    kept, folded, params, dropped = _select_tags(samples, lambda s: s["tags"])
    if len(kept) < MIN_EVA_SWINGS:
        return {"status": "need more swings", "swings": len(kept), "dropped": dropped, "folded": folded}
    index = {t: i for i, t in enumerate(params)}
    data = [(s["hit"], s["acc"], s["cap"], [index[t] for t in s["tags"] if t in index]) for s in kept]
    shift = 2 * level_diff

    def nll(theta):
        total = 0.0
        for hit, acc, cap, tag_ids in data:
            evasion = theta[0] + sum(theta[1 + k] for k in tag_ids)
            rate = min(max(75 + (acc - evasion) / 2 - shift, HIT_FLOOR), cap) / 100
            total -= math.log(rate if hit else 1 - rate)
        return total

    accs = [a for _, a, _, _ in data]
    grid = range(int(min(accs)) - 400, int(max(accs)) + 400, 4)
    start = min(grid, key=lambda e: nll([e] + [0.0] * len(params)))
    point, value = nelder_mead(nll, [float(start)] + [0.0] * len(params), [20.0] + [15.0] * len(params), iters=600)

    # Profile scan for the base: hit-capped (or floored) data only bounds it on one side.
    others = point[1:]
    scan = [(e, nll([float(e)] + others)) for e in range(int(point[0]) - 500, int(point[0]) + 501, 2)]
    inside = [e for e, v in scan if v <= value + NLL_90]
    low, high = min(inside), max(inside)
    open_low, open_high = low <= scan[0][0], high >= scan[-1][0]
    ses = standard_errors(nll, point, [4.0] * len(point)) if len(point) > 1 else [None]

    effects = []
    for tag, k in index.items():
        se_k = ses[1 + k] if len(ses) > 1 + k else None
        effects.append({"tag": tag, "hits": sum(1 for *_, t in data if k in t), "offset": point[1 + k],
                        "low": point[1 + k] - Z90 * se_k if se_k else None,
                        "high": point[1 + k] + Z90 * se_k if se_k else None})

    contexts = []
    by_context = defaultdict(list)
    for item, s in zip(data, kept):
        by_context[_label(s["tags"] - set(folded))].append(item)
    for label, items in sorted(by_context.items(), key=lambda kv: -len(kv[1])):
        rates = [min(max(75 + (acc - (point[0] + sum(point[1 + k] for k in t))) / 2 - shift, HIT_FLOOR), cap) / 100
                 for _, acc, cap, t in items]
        expected = sum(rates)
        variance = sum(r * (1 - r) for r in rates)
        observed = sum(1 for hit, *_ in items if hit)
        z = (observed - expected) / math.sqrt(variance) if variance > 0 else None
        contexts.append({"context": label, "swings": len(items), "expected_hits": expected, "hits": observed,
                         "z": z, "check": None if z is None else ("fits" if abs(z) < 2.5 else "doesn't fit")})

    result = {"swings": len(kept), "dropped": dropped, "folded": folded, "effects": effects,
              "contexts": contexts, "hit_rate": sum(1 for d in data if d[0]) / len(data) * 100}
    if open_low and open_high:
        result.update(status="not identifiable", base_eva=None)
    elif open_low:
        result.update(status="hit-capped: upper bound only", base_eva=None, eva_max=high)
    elif open_high:
        result.update(status="at hit floor: lower bound only", base_eva=None, eva_min=low)
    else:
        half = (high - low) / 2
        result.update(status="estimate", base_eva=point[0], low=low, high=high,
                      confidence=math.erf(0.05 * abs(point[0]) / (half / Z90 * math.sqrt(2))) * 100 if half else None)
    return result


def fit_evasion(rows, level_diff=0):
    groups = defaultdict(list)
    for row in rows:
        kind = row.get("kind")
        if kind not in ("melee", "melee_miss") or not row.get("is_me"):
            continue
        weapon = row.get("weapon") or "?"
        hand = row.get("hand") or 0
        if weapon == "Hand-to-Hand" and hand in (0, 1):
            acc, cap = row.get("accuracy"), HIT_CAP["h2h"]
        elif hand == 0:
            acc, cap = row.get("accuracy"), HIT_CAP.get(WEAPON_CLASS.get(weapon, "1h"), 95.0)
        elif hand == 1:
            acc, cap = row.get("acc_sub"), 95.0
        else:
            continue
        if acc is None:
            continue
        key = (row.get("actor") or row.get("uploader") or "?", row.get("target") or "?")
        groups[key].append({"hit": kind == "melee", "acc": float(acc), "cap": cap, "hand": hand,
                            "tags": relevant_tags(row, EVA_PATTERNS)})
    out = []
    for (player, target), samples in sorted(groups.items()):
        fit = fit_evasion_one(samples, level_diff)
        fit.update(player=player, target=target,
                   hands={"main": sum(1 for s in samples if s["hand"] == 0),
                          "off": sum(1 for s in samples if s["hand"] == 1)})
        out.append(fit)
    return out


# ---------------------------------------------------------------- per-target summary

def summarize(def_fits, eva_fits):
    """Combines players per target (inverse-variance on log DEF / on EVA)."""
    targets = defaultdict(lambda: {"def": [], "eva": [], "def_bounds": [], "eva_bounds": [], "def_ambiguous": []})
    for fit in def_fits:
        t = targets[fit["target"]]
        if fit.get("status", "").startswith(("estimate", "near cap")) and fit.get("se_log"):
            t["def"].append((math.log(fit["base_def"]), fit["se_log"], fit))
        elif fit.get("def_max"):
            t["def_bounds"].append(fit["def_max"])
        elif fit.get("status", "").startswith("ambiguous"):
            t["def_ambiguous"].append(fit)
    for fit in eva_fits:
        t = targets[fit["target"]]
        if fit.get("status") == "estimate" and fit.get("low") is not None:
            t["eva"].append((fit["base_eva"], (fit["high"] - fit["low"]) / (2 * Z90) or 1.0, fit))
        elif fit.get("eva_max") is not None:
            t["eva_bounds"].append(fit["eva_max"])

    out = []
    for target, t in sorted(targets.items()):
        row = {"target": target}
        nows = [fit["now"] for *_, fit in t["def"] if fit.get("now")]
        row["now"] = dict(max(nows, key=lambda n: n["t"])) if nows else None
        if row["now"]:
            row["now"]["player"] = next(fit["player"] for *_, fit in t["def"] if fit.get("now") is not None
                                        and fit["now"]["t"] == row["now"]["t"])
        if t["def"]:
            weights = [1 / se ** 2 for _, se, _ in t["def"]]
            mean = sum(w * v for w, (v, _, _) in zip(weights, t["def"])) / sum(weights)
            se = math.sqrt(1 / sum(weights))
            folded = sorted({f for *_, fit in t["def"] for f in fit.get("folded", [])})
            row["def"] = {"value": math.exp(mean), "low": math.exp(mean - Z90 * se), "high": math.exp(mean + Z90 * se),
                          "confidence": _within_5pct(se), "hits": sum(fit["n"] for *_, fit in t["def"]),
                          "base_includes": folded, "status": "estimate"}
        elif t["def_bounds"]:
            row["def"] = {"value": None, "upper_bound": min(t["def_bounds"]), "status": "pDIF-capped: upper bound only"}
        elif t["def_ambiguous"]:
            fit = t["def_ambiguous"][0]
            row["def"] = {"value": None, "status": fit["status"],
                          "candidates": [fit["base_def"]] + [a["def"] for a in fit["alternatives"]]}
        else:
            row["def"] = {"value": None, "status": "need more hits"}
        if t["eva"]:
            weights = [1 / se ** 2 for _, se, _ in t["eva"]]
            mean = sum(w * v for w, (v, _, _) in zip(weights, t["eva"])) / sum(weights)
            se = math.sqrt(1 / sum(weights))
            folded = sorted({f for *_, fit in t["eva"] for f in fit.get("folded", [])})
            row["eva"] = {"value": mean, "low": mean - Z90 * se, "high": mean + Z90 * se,
                          "confidence": math.erf(0.05 * abs(mean) / (se * math.sqrt(2))) * 100,
                          "swings": sum(fit["swings"] for *_, fit in t["eva"]),
                          "base_includes": folded, "status": "estimate"}
        elif t["eva_bounds"]:
            row["eva"] = {"value": None, "upper_bound": min(t["eva_bounds"]), "status": "hit-capped: upper bound only"}
        else:
            row["eva"] = {"value": None, "status": "need more swings"}
        out.append(row)
    return out
