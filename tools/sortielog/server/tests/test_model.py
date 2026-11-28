import random

from sortielog.estimate import pdif_bounds
from sortielog.model import fill_accuracy, fit_defense, fit_evasion, summarize


def hits(n, base_def, attack_values, tags="", effect=1.0, double=0.0, base=150, seed=1, target="Locus Dire Bat",
         hidden_effect=1.0, t0=0):
    rng = random.Random(seed)
    rows = []
    for i in range(n):
        attack = rng.choice(attack_values)
        defense = base_def * effect * hidden_effect
        lower, upper = pdif_bounds(attack / defense)
        damage = int(int(base * rng.uniform(lower, upper)) * rng.uniform(1, 1.05))
        if rng.random() < double:
            damage *= 2
        rows.append({"kind": "melee", "is_me": 1, "actor": "Kalali", "target": target, "crit": 0, "hand": 0,
                     "damage": damage, "attack": attack, "weapon": "Dagger", "mob_status": tags, "t": t0 + i})
    return rows


def test_defense_fit_recovers_base_effect_and_double_damage():
    rows = hits(150, 1120, [1650, 1700, 1760], tags="", double=0.22, seed=1)
    rows += hits(250, 1120, [1650, 1700, 1760], tags="Box Step lv5;Sleep", effect=0.88, double=0.22, seed=2)
    (fit,) = fit_defense(rows)
    assert fit["status"] == "estimate"
    assert abs(fit["base_def"] - 1120) / 1120 < 0.05
    assert abs(fit["double_damage_pct"] - 22) < 7
    (effect,) = fit["effects"]                       # Sleep is ignored: it can't change DEF
    assert effect["tag"] == "Box Step lv5" and abs(effect["pct"] - (-12)) < 4
    assert all(c["check"] == "fits" for c in fit["contexts"])


def test_segment_with_unlogged_debuff_does_not_fit():
    rows = hits(200, 1120, [1650, 1760], seed=3)
    rows += hits(150, 1120, [1650, 1760], tags="Box Step lv5", effect=0.88, seed=4)
    rows += hits(120, 1120, [1650, 1760], tags="Dia III", effect=0.95, hidden_effect=0.7, seed=5)   # unseen DEF down
    rows += hits(120, 1120, [1650, 1760], tags="Dia III;Box Step lv5", effect=0.95 * 0.88, seed=6)
    (fit,) = fit_defense(rows)
    checks = {c["context"]: c["check"] for c in fit["contexts"]}
    assert checks["Dia III"] == "doesn't fit (excluded)"
    assert checks["none"] == "fits" and checks["Box Step lv5"] == "fits"
    assert abs(fit["base_def"] - 1120) / 1120 < 0.05        # base not dragged by the bad segment


def test_defense_needs_enough_hits_and_folds_constant_debuffs():
    assert fit_defense(hits(10, 1120, [1700]))[0]["status"] == "need more hits"
    (fit,) = fit_defense(hits(200, 1120, [1650, 1760], tags="Box Step lv5", effect=0.88, seed=7))
    assert fit["folded"] == ["Box Step lv5"]            # always up: part of the base
    assert abs(fit["base_def"] - 1120 * 0.88) / (1120 * 0.88) < 0.05


def swings(n, eva, acc_main, acc_sub, seed=1, tags="", buffs="Food;Haste", accuracy_known=True, t0=0):
    rng = random.Random(seed)
    rows = []
    for i in range(n):
        hand = i % 2
        acc = acc_main if hand == 0 else acc_sub
        cap = 99 if hand == 0 else 95
        rate = min(max(75 + (acc - eva) / 2, 20), cap) / 100
        rows.append({"kind": "melee" if rng.random() < rate else "melee_miss", "is_me": 1, "actor": "Kalali",
                     "target": "Locus Dire Bat", "hand": hand, "weapon": "Dagger", "damage": 1, "crit": 0,
                     "accuracy": acc_main if accuracy_known else None, "acc_sub": acc_sub if accuracy_known else None,
                     "mob_status": tags, "buffs": buffs, "session": "s", "t": t0 + i})
    return rows


def test_evasion_uses_off_hand_when_main_is_hit_capped():
    rows = swings(800, 1220, acc_main=1476, acc_sub=1250, seed=8)
    (fit,) = fit_evasion(rows)
    assert fit["status"] == "estimate"
    assert abs(fit["base_eva"] - 1220) < 15
    assert fit["hands"] == {"main": 400, "off": 400}


def test_evasion_hit_capped_everywhere_gives_upper_bound():
    (fit,) = fit_evasion(swings(400, 1100, acc_main=1476, acc_sub=1400, seed=9))
    assert fit["status"].startswith("hit-capped") and fit["eva_max"] >= 1100


def test_fill_accuracy_ignores_finishing_moves():
    measured = swings(10, 1220, 1476, 1250, buffs="Food;Finishing Move 2;Haste", t0=0)
    missing = swings(10, 1220, 1476, 1250, buffs="Food;Finishing Move (6+);Haste", accuracy_known=False, t0=20)
    other = swings(10, 1220, 1476, 1250, buffs="Food;Haste;March", accuracy_known=False, t0=40)
    rows, filled = fill_accuracy(measured + missing + other)
    assert filled == 10
    assert all(r["accuracy"] == 1476 for r in rows[10:20])
    assert all(r["accuracy"] is None for r in rows[20:])     # different real buffs: not filled


def test_summary_per_target():
    def_fits = fit_defense(hits(150, 1120, [1650, 1760], seed=10) + hits(150, 1120, [1650, 1760], tags="Box Step lv5",
                                                                        effect=0.88, seed=11))
    eva_fits = fit_evasion(swings(800, 1220, 1476, 1250, seed=12))
    (row,) = summarize(def_fits, eva_fits)
    assert row["target"] == "Locus Dire Bat"
    assert row["def"]["low"] <= row["def"]["value"] <= row["def"]["high"]
    assert row["eva"]["status"] == "estimate" and row["eva"]["swings"] == 800


def test_current_state_and_attack_for_cap():
    rows = hits(200, 1120, [1650, 1760], seed=13)
    rows += hits(200, 1120, [1650, 1760], tags="Box Step lv5", effect=0.88, seed=14, t0=1000)   # latest hits
    (fit,) = fit_defense(rows)
    now = fit["now"]
    assert now["context"] == "Box Step lv5"
    assert abs(now["defense"] - 1120 * 0.88) / (1120 * 0.88) < 0.06
    assert abs(now["ratio"] - now["attack"] / now["defense"]) < 1e-9
    assert now["pdif_low"] < now["pdif_high"] <= now["pdif_cap"] == 3.25
    assert abs(now["attack_for_cap"] - 3.625 * now["defense"]) < 1e-6 and not now["capped"]
    (row,) = summarize([fit], [])
    assert row["now"]["player"] == "Kalali" and row["now"]["context"] == "Box Step lv5"


def test_per_row_weapon_dmg_fits_fstr_across_a_weapon_swap():
    rows = hits(200, 1120, [1650, 1760], base=150, seed=15)                   # 130 DMG + fSTR 20
    rows += hits(200, 1120, [1650, 1760], base=120, seed=16, t0=1000)         # swap to a 100 DMG dagger
    for r in rows[:200]:
        r["main_dmg"] = 130
    for r in rows[200:]:
        r["main_dmg"] = 100
    (fit,) = fit_defense(rows)
    assert fit["dmg_known"] and abs(fit["fstr"] - 20) < 6
    assert abs(fit["base_def"] - 1120) / 1120 < 0.05


def test_rows_with_and_without_dmg_are_fitted_separately():
    rows = hits(150, 1120, [1650, 1760], base=150, seed=17)
    for r in rows[:75]:
        r["main_dmg"] = 130
    fits = fit_defense(rows)
    assert sorted(f["dmg_known"] for f in fits) == [False, True]


def test_type_range_rules_out_impossible_base_damage():
    from sortielog.model import TYPE_BASE_RANGE
    rows = hits(300, 1120, [1650, 1760], base=150, double=0.2, seed=18)
    (fit,) = fit_defense(rows)
    low, high = TYPE_BASE_RANGE["Dagger"]
    assert low <= fit["base_damage"] <= high
    assert all(low <= a["base_damage"] <= high + 1 for a in fit["alternatives"])
