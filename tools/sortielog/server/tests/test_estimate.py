import random

from sortielog.estimate import estimate_defense, estimate_evasion, pdif_bounds

CAP_1H = 3.25


def melee_rows(true_def, attack, n=400, base=600, seed=3, weapon="Club", target="Aminon", status=""):
    rng = random.Random(seed)
    lower, upper = pdif_bounds(attack / true_def)
    rows = []
    for _ in range(n):
        pdif = min(rng.uniform(lower, upper), CAP_1H)
        damage = int(int(base * pdif) * rng.uniform(1.0, 1.05))
        rows.append({"kind": "melee", "is_me": 1, "actor": "Kalali", "target": target, "crit": 0,
                     "hand": 0, "damage": damage, "attack": attack, "weapon": weapon, "mob_status": status})
    return rows


def test_def_estimate_recovers_true_defense_below_cap():
    (entry,) = estimate_defense(melee_rows(true_def=1600, attack=4000))   # ratio 2.5, well below cap
    assert entry["verdict"] == "estimate"
    assert abs(entry["def"] - 1600) < 80
    assert entry["def_low"] < 1600 < entry["def_high"]


def test_def_capped_gives_upper_bound_only():
    (entry,) = estimate_defense(melee_rows(true_def=1000, attack=4500))   # ratio 4.5, capped
    assert entry["def"] is None
    assert entry["verdict"].startswith("pDIF-capped")
    assert 1000 <= entry["def_max"] <= 4500 / 3.625 + 1


def test_def_groups_by_debuffs_and_ignores_crits_offhand_and_small_groups():
    rows = melee_rows(1600, 4000, status="Dia") + melee_rows(1400, 4000, seed=4, status="Dia;Defense Down")
    rows += [dict(rows[0], crit=1, damage=99999), dict(rows[0], hand=1, damage=1)]
    rows += melee_rows(1600, 4000, n=10, target="Ghatjot")
    entries = {(e["target"], e["context"]): e for e in estimate_defense(rows)}
    assert abs(entries[("Aminon", "Dia")]["def"] - 1600) < 80
    assert abs(entries[("Aminon", "Defense Down;Dia")]["def"] - 1400) < 80
    assert entries[("Ghatjot", "none")]["verdict"] == "need more hits"


def test_level_correction_shifts_defense_down():
    plain = estimate_defense(melee_rows(1600, 4000))[0]["def"]
    corrected = estimate_defense(melee_rows(1600, 4000), level_diff=10)[0]["def"]
    assert corrected < plain


def swing_rows(accuracy, eva, n=600, seed=5, cap=99.0, weapon="Club"):
    rng = random.Random(seed)
    rate = min(max(75 + (accuracy - eva) / 2, 20), cap) / 100
    return [{"kind": "melee" if rng.random() < rate else "melee_miss", "is_me": 1, "actor": "Kalali",
             "target": "Aminon", "hand": 0, "accuracy": accuracy, "weapon": weapon, "damage": 1}
            for _ in range(n)]


def test_eva_estimate_when_not_hit_capped():
    (entry,) = estimate_evasion(swing_rows(accuracy=1500, eva=1480))   # 85% hit rate
    assert entry["verdict"] == "estimate"
    assert entry["eva_low"] < 1480 < entry["eva_high"]


def test_eva_hit_capped_gives_upper_bound_only():
    (entry,) = estimate_evasion(swing_rows(accuracy=1700, eva=1500))   # would be 175%, capped at 99%
    assert entry["eva"] is None
    assert entry["verdict"].startswith("hit-capped")
    assert entry["eva_max"] >= 1500


def test_two_handed_hit_cap_is_95():
    (entry,) = estimate_evasion(swing_rows(accuracy=1700, eva=1500, cap=95.0, weapon="Great Sword"))
    assert entry["hit_cap"] == 95.0
    assert entry["verdict"].startswith("hit-capped")
