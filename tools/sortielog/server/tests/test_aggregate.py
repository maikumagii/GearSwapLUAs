import random

from sortielog.aggregate import chi2_p, fit_level_diff, summarize_targets
from sortielog.estimate import estimate_defense, estimate_evasion, pdif_bounds


def melee(true_def, attack, n=500, seed=1, level_diff=0, status="Dia", target="Aminon"):
    rng = random.Random(seed)
    lower, upper = pdif_bounds(attack / true_def - 0.05 * level_diff)
    return [{"kind": "melee", "is_me": 1, "actor": "Kalali", "target": target, "crit": 0, "hand": 0,
             "damage": int(int(600 * min(rng.uniform(lower, upper), 3.25)) * rng.uniform(1, 1.05)),
             "attack": attack, "weapon": "Club", "mob_status": status} for _ in range(n)]


def swings(accuracy, eva, n=600, seed=2, status="Dia"):
    rng = random.Random(seed)
    rate = min(max(75 + (accuracy - eva) / 2, 20), 99) / 100
    return [{"kind": "melee" if rng.random() < rate else "melee_miss", "is_me": 1, "actor": "Kalali",
             "target": "Aminon", "hand": 0, "accuracy": accuracy, "weapon": "Club", "damage": 1,
             "mob_status": status} for _ in range(n)]


def test_chi2_p_reasonable():
    assert 0.33 < chi2_p(2.0, 2) < 0.42   # exact 0.368; approximation is close enough
    assert chi2_p(20.0, 2) < 0.01


def test_targets_combine_groups_with_confidence():
    rows = melee(1600, 3600, seed=1) + melee(1600, 4000, seed=2) + melee(1600, 4400, seed=3)
    rows += swings(1500, 1480, seed=4) + swings(1520, 1480, seed=5)
    defense, evasion = estimate_defense(rows), estimate_evasion(rows)
    (summary,) = summarize_targets(defense, evasion)
    assert summary["target"] == "Aminon" and summary["context"] == "Dia"
    assert summary["def"]["groups"] == 3 and summary["def"]["status"] == "consistent"
    assert abs(summary["def"]["value"] - 1600) < 60
    assert summary["def"]["confidence"] > 80
    assert abs(summary["eva"]["value"] - 1480) < 10 and summary["eva"]["groups"] == 2
    assert all(e["check"] == "consistent" for e in defense)


def test_outlier_group_is_flagged():
    rows = melee(1600, 3600, seed=1) + melee(1600, 4000, seed=2) + melee(1600, 4400, seed=3)
    rows += melee(1300, 3500, seed=9)   # e.g. an unlogged DEF-down debuff in this group
    defense = estimate_defense(rows)
    summary = summarize_targets(defense, estimate_evasion(rows))[0]
    checks = {e["attack"]: e["check"] for e in defense}
    assert checks == {3500: "outlier", 3600: "consistent", 4000: "consistent", 4400: "consistent"}
    assert summary["def"]["status"] == "consistent (1 outlier excluded)"
    assert summary["def"]["groups"] == 3 and abs(summary["def"]["value"] - 1600) < 60


def test_capped_groups_become_bounds():
    rows = melee(1600, 4000, seed=1) + melee(1000, 4600, seed=2)   # second group pDIF-capped
    summary = summarize_targets(estimate_defense(rows), [])[0]
    assert summary["def"]["groups"] == 1
    assert summary["def"]["upper_bound"] is not None


def test_level_fit_recovers_true_correction():
    rows = []
    for i, attack in enumerate((4400, 4800, 5200, 5600)):   # ratios 1.75-2.5 after correction
        rows += melee(1600, attack, n=800, seed=10 + i, level_diff=20)
    fit = fit_level_diff(estimate_defense(rows), current=0)
    low, high = fit["range"]
    assert low <= 20 <= high
    assert "clearly better" in fit["verdict"]


def test_level_fit_needs_attack_spread():
    rows = melee(1600, 4000, seed=1) + melee(1600, 4010, seed=2)
    assert fit_level_diff(estimate_defense(rows))["best_level_diff"] is None
