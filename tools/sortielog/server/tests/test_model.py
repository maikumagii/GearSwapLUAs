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
    rows = hits(150, 1120, [1650, 1760], seed=10) + hits(150, 1120, [1650, 1760], tags="Box Step lv5",
                                                         effect=0.88, seed=11)
    for r in rows:
        r["main_dmg"] = 130   # base 150 = 130 DMG + fSTR 20; without DMG this data is ambiguous
    def_fits = fit_defense(rows)
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


def test_dia_rebuilt_from_casts_and_fitted_as_its_own_effect():
    from sortielog.model import infer_cast_debuffs
    rows = [{"kind": "party_action", "detail": "Dia II", "target_id": 7, "t": 100, "msg": 2},
            {"kind": "melee", "target_id": 7, "t": 150, "mob_status": "Box Step lv5"},
            {"kind": "melee", "target_id": 7, "t": 230, "mob_status": ""},            # 130 s later: expired
            {"kind": "melee", "target_id": 8, "t": 150, "mob_status": ""},            # different bat
            {"kind": "melee", "target_id": 7, "t": 160, "mob_status": "Dia III"}]     # already tagged
    out, tagged = infer_cast_debuffs(rows)
    assert tagged == 1
    assert [r.get("mob_status") for r in out[1:]] == ["Box Step lv5;Dia II", "", "", "Dia III"]

    # A fit where Dia II was up but untagged reads low; with the casts it recovers the clean DEF.
    hits_rows, t = [], 0
    for i, (tags, effect, dia) in enumerate([("", 1.0, False), ("", 0.85, True),
                                             ("Box Step lv5", 0.88, False), ("Box Step lv5", 0.88 * 0.85, True)]):
        block = hits(220, 1320, [1650, 1760], tags=tags, effect=effect, seed=40 + i, t0=t)
        for r in block:
            r.update(target_id=i, main_dmg=130)
        if dia:
            hits_rows.append({"kind": "party_action", "detail": "Dia II", "target_id": i, "t": t - 1})
        hits_rows += block
        t += 1000
    for r in hits_rows:
        if r["kind"] == "melee":
            r["t"] = r["t"] % 1000 / 10 + (r["t"] // 1000) * 1000   # keep every hit within 100 s of the cast
    rebuilt, _ = infer_cast_debuffs(hits_rows)
    (fit,) = fit_defense([r for r in rebuilt if r["kind"] == "melee"])
    assert abs(fit["base_def"] - 1320) / 1320 < 0.05
    dia = next(e for e in fit["effects"] if e["tag"] == "Dia II")
    assert abs(dia["pct"] - (-15)) < 4


def _fight(dia_effect=0.85, dia_tracked=True, seed=70, kills=12):
    """Kills of ~60 s, each Dia II'd at the start; hits run 0-200 s after the cast."""
    import random
    from sortielog.model import infer_cast_debuffs
    rng = random.Random(seed)
    rows = []
    for k in range(kills):
        t0 = k * 1000
        rows.append({"kind": "party_action", "detail": "Dia II", "target_id": k, "t": t0, "msg": 2})
        for i in range(40):
            t = t0 + 2 + i * 5
            effect = dia_effect if t - t0 < 120 else 1.0
            (hit,) = hits(1, 1320, [1650, 1760], effect=effect, seed=rng.randrange(10**6), t0=t)
            hit.update(target_id=k, main_dmg=130, target_hpp=max(5, 100 - i * 2))
            rows.append(hit)
    if dia_tracked:
        rows, _ = infer_cast_debuffs(rows)
    return rows


def test_anomaly_scan_points_at_untracked_dia_and_stays_quiet_when_tracked():
    from sortielog.model import batch_anomalies, cast_timelines
    for tracked in (False, True):
        rows = _fight(dia_tracked=tracked)
        fits = fit_defense([r for r in rows if r["kind"] == "melee"])
        found = batch_anomalies(fits, [], cast_timelines(rows))
        if tracked:
            assert found == []                                   # no false alarms
        else:
            late = [a for a in found if a["factor"] == "since Dia II" and a["size"] > 10]
            assert late and "Dia II likely lowers DEF and isn't tracked" in late[0]["cause"]
