"""Target profiles (what's known about a monster) and live advice from them.

A profile holds a target's base DEF, base EVA (or an upper bound when you're hit-capped), the
measured effect of each debuff, and how confident the DEF fit is. Advice combines a profile with
your current state (Attack, Accuracy, weapon, debuffs on the target):

- DEF now = base DEF x the measured effect of each debuff up.
- Below the pDIF cap: how much Attack you're short (PDL can't help yet).
- At the cap: how much total PDL (gear + buffs) could still be used.
- Hit rate per hand against its cap, and the Accuracy needed to reach it.

The addon does the same arithmetic in Lua from /api/profiles.txt, so the in-game display and the
dashboard's live panel agree.
"""

from .estimate import HIT_CAP, HIT_FLOOR, RATIO_CAP, WEAPON_CLASS, pdif_bounds
from .model import PDIF_CAP
from .schema import split_list

CONFIDENT = 90.0   # % chance the DEF estimate is within +/-5%
CAP_MARGIN = 0.03  # stay out of the 3% band around the cap so the suggested mode doesn't flip-flop
DEFAULT_MODES = {"below": "Match", "below_acc": "Acc", "capped": "HighBuff", "capped_acc": "HighBuffAcc"}


def build_profiles(result):
    """Profiles from an analysis result, keyed by target name."""
    profiles = {}
    level_diff = result.get("level_diff") or 0
    fits_def = sorted(result.get("def_fits", []), key=lambda f: not f.get("dmg_known"))
    for row in result.get("targets", []):
        name, d, e = row["target"], row["def"], row["eva"]
        def_effects, folded = {}, []
        for fit in fits_def:
            if fit["target"] == name and fit.get("effects") is not None and fit.get("status", "").startswith(
                    ("estimate", "near cap")):
                def_effects = {x["tag"]: x["pct"] for x in fit["effects"]}
                folded = fit.get("folded", [])
                break
        eva_effects = {}
        for fit in result.get("eva_fits", []):
            if fit["target"] == name and fit.get("effects"):
                eva_effects = {x["tag"]: x["offset"] for x in fit["effects"]}
                break
        profiles[name] = {
            "target": name, "def": d.get("value"), "def_low": d.get("low"), "def_high": d.get("high"),
            "def_confidence": d.get("confidence"), "def_status": d.get("status"),
            "eva": e.get("value"), "eva_max": e.get("upper_bound"), "eva_status": e.get("status"),
            "def_effects": def_effects, "eva_effects": eva_effects, "base_includes": folded,
            "level_diff": level_diff,
            "confident": bool(d.get("value") and (d.get("confidence") or 0) >= CONFIDENT),
        }
    return profiles


def profiles_text(profiles):
    """Tab-separated lines for the addon (no JSON parser needed in Lua):
    target, DEF, EVA, EVA max, level diff, confident, DEF effects, EVA effects, base includes."""
    def num(value):
        return "" if value is None else f"{value:.1f}"

    lines = []
    for p in profiles.values():
        lines.append("\t".join([
            p["target"].replace("\t", " "), num(p["def"]), num(p["eva"]), num(p["eva_max"]),
            num(p["level_diff"]), "1" if p["confident"] else "0",
            ";".join(f"{t}={v:.2f}" for t, v in sorted(p["def_effects"].items())),
            ";".join(f"{t}={v:.1f}" for t, v in sorted(p["eva_effects"].items())),
            ";".join(p["base_includes"]),
        ]))
    return "\n".join(lines) + "\n"


def _matches(tag, effects):
    """Effect for a logged tag: exact match, or the same debuff without its modifiers."""
    if tag in effects:
        return effects[tag]
    plain = tag.split("+")[0]
    return effects.get(plain)


def advise(profile, state, ws=None, modes=None):
    """Advice for one player's current state against a target profile.

    state: attack, accuracy, acc_sub, weapon, mob_status (';'-joined tags).
    ws: {"name", "attack"} from the player's latest weapon skill (WS-set Attack), optional."""
    out = {"target": profile["target"], "messages": [], "unmeasured": []}
    weapon_class = WEAPON_CLASS.get(state.get("weapon") or "", "1h")
    correction = 0.05 * (profile.get("level_diff") or 0)
    tags = split_list(state.get("mob_status"))

    # DEF now and distance to the pDIF cap.
    if profile.get("def") and state.get("attack"):
        defense = profile["def"]
        for tag in tags:
            effect = _matches(tag, profile["def_effects"])
            if effect is not None:
                defense *= 1 + effect / 100
            elif any(tag.startswith(p) for p in ("Dia", "Box Step", "Geo-Frailty", "Indi-Frailty", "Angon",
                                                   "Armor Break", "Defense Down", "Swooping")):
                out["unmeasured"].append(tag)
        attack = state["attack"]
        ratio = attack / defense - correction
        lower, upper = pdif_bounds(max(ratio, 0.05))
        cap = PDIF_CAP.get(weapon_class, 3.25)
        cap_ratio = RATIO_CAP.get(weapon_class, 3.625)
        attack_for_cap = (cap_ratio + correction) * defense
        out.update(def_now=defense, attack=attack, ratio=ratio, pdif_low=min(lower, cap), pdif_high=min(upper, cap),
                   pdif_cap=cap, attack_for_cap=attack_for_cap, attack_short=max(attack_for_cap - attack, 0.0))
        if ratio < cap_ratio:
            out["pdl_useful"] = 0.0
            out["messages"].append(f"{attack_for_cap - attack:,.0f} ATK short of pDIF cap (PDL won't help yet)")
        else:
            # Gear/buff PDL raises the cap to cap x (1 + PDL); the ratio reaches it at that cap + 0.375.
            pdl = max((ratio - 0.375) / cap - 1, 0.0) * 100
            out["pdl_useful"] = pdl
            out["messages"].append(f"pDIF capped: up to {pdl:.0f}% total PDL is useful")

    # Weapon skills: the WS set's Attack decides whether PDL (HighBuff) or WSD/Attack pays off.
    if ws and ws.get("attack") and out.get("def_now"):
        ws_ratio = ws["attack"] / out["def_now"] - correction
        ws_for_cap = out["attack_for_cap"]
        out.update(ws_name=ws.get("name"), ws_attack=ws["attack"], ws_ratio=ws_ratio,
                   ws_attack_short=max(ws_for_cap - ws["attack"], 0.0))
        cap_ratio = RATIO_CAP.get(weapon_class, 3.625)
        if ws_ratio >= cap_ratio * (1 + CAP_MARGIN):
            out["ws_capped"] = True
            out["ws_pdl_useful"] = max((ws_ratio - 0.375) / out["pdif_cap"] - 1, 0.0) * 100
        elif ws_ratio <= cap_ratio * (1 - CAP_MARGIN):
            out["ws_capped"] = False
        else:
            out["ws_capped"] = None   # within the margin: keep whatever mode is set

    # Hit rate per hand.
    evasion, basis = profile.get("eva"), "estimate"
    if evasion is None and profile.get("eva_max") is not None:
        evasion, basis = profile["eva_max"], "upper bound"
    if evasion is not None:
        for tag in tags:
            effect = _matches(tag, profile["eva_effects"])
            if effect is not None:
                evasion += effect
        shift = 2 * (profile.get("level_diff") or 0)
        hands = [("main", state.get("accuracy"), HIT_CAP.get(weapon_class, 95.0))]
        if state.get("acc_sub") is not None and weapon_class != "h2h":
            hands.append(("off", state.get("acc_sub"), 95.0))
        out.update(eva_now=evasion, eva_basis=basis)
        for hand, accuracy, cap in hands:
            if accuracy is None:
                continue
            rate = min(max(75 + (accuracy - evasion) / 2 - shift, HIT_FLOOR), cap)
            needed = evasion + 2 * (cap - 75 + shift)
            short = needed - accuracy
            out[f"hit_{hand}"] = rate
            out[f"acc_short_{hand}"] = short
            if short > 0:
                up_to = "up to " if basis == "upper bound" else ""
                out["messages"].append(f"{hand} hand {rate:.0f}%: {up_to}+{short:,.0f} ACC to cap")
            else:
                spare = " (at most)" if basis == "upper bound" else ""
                out["messages"].append(f"{hand} hand capped, {-short:,.0f} ACC spare{spare}")

    if out.get("ws_capped") is not None:
        modes = dict(DEFAULT_MODES, **(modes or {}))
        acc_short = (out.get("acc_short_main") or 0) > 0   # WS-set Accuracy isn't measured; main hand stands in
        key = ("capped" if out["ws_capped"] else "below") + ("_acc" if acc_short else "")
        out["ws_mode"] = modes[key]
        out["ws_command"] = f"gs c set WeaponskillMode {modes[key]}"
        if out["ws_capped"]:
            out["messages"].append(f"WS ({out['ws_name']}) capped: up to {out['ws_pdl_useful']:.0f}% PDL useful"
                                   f" -> {modes[key]}")
        else:
            out["messages"].append(f"WS ({out['ws_name']}) {out['ws_attack_short']:,.0f} ATK short of cap"
                                   f" -> {modes[key]}")
    return out
