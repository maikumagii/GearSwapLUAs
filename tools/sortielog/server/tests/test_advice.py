import time

from fastapi.testclient import TestClient

from sortielog.advice import advise, profiles_text

PROFILE = {"target": "Locus Dire Bat", "def": 1322.5, "eva": None, "eva_max": 1051.0, "level_diff": 0,
           "confident": True, "def_effects": {"Box Step lv5": -11.7, "Box Step lv6": -14.6, "Dia II": -15.8},
           "eva_effects": {}, "base_includes": []}


def test_advice_matches_the_addon_below_cap():
    state = {"attack": 1667, "accuracy": 1476, "acc_sub": 1250, "weapon": "Dagger", "mob_status": "Box Step lv5;Dia II"}
    a = advise(PROFILE, state, {"name": "Ruthless Stroke", "attack": 2275})
    assert round(a["def_now"]) == 983
    assert round(a["attack_short"]) == 1897 and round(a["ws_attack_short"]) == 1289   # same as the in-game HUD
    assert a["ws_capped"] is False and a["ws_command"] == "gs c set WeaponskillMode Match"
    assert a["acc_short_main"] < 0 and a["acc_short_off"] < 0 and a["eva_basis"] == "upper bound"


def test_capped_ws_suggests_highbuff_with_usable_pdl():
    state = {"attack": 3000, "accuracy": 1476, "weapon": "Dagger", "mob_status": "Dia II;Box Step lv6"}
    a = advise(PROFILE, state, {"name": "Rudra's Storm", "attack": 4200})
    assert a["ws_capped"] is True and a["ws_mode"] == "HighBuff"
    assert a["ws_pdl_useful"] > 0


def test_accuracy_short_picks_acc_variants_and_modes_can_be_renamed():
    profile = dict(PROFILE, eva=1500.0, eva_max=None)
    state = {"attack": 1667, "accuracy": 1476, "weapon": "Dagger", "mob_status": ""}
    a = advise(profile, state, {"name": "Ruthless Stroke", "attack": 2275}, modes={"below_acc": "SomeAcc"})
    assert a["acc_short_main"] > 0 and a["ws_mode"] == "SomeAcc"


def test_within_the_cap_margin_no_mode_is_suggested():
    state = {"attack": 1667, "weapon": "Dagger", "mob_status": ""}
    a = advise(PROFILE, state, {"name": "Ruthless Stroke", "attack": 3.625 * 1322.5})
    assert a["ws_capped"] is None and "ws_mode" not in a


def test_profiles_text_is_what_the_addon_parses():
    line = profiles_text({"Locus Dire Bat": PROFILE}).splitlines()[0].split("\t")
    assert line[0] == "Locus Dire Bat" and line[1] == "1322.5" and line[2] == "" and line[3] == "1051.0"
    assert line[5] == "1" and "Dia II=-15.80" in line[6]


def test_live_endpoint_advises_each_player(tmp_path):
    from sortielog.app import create_app
    from tests.test_sortielog import wait_for_analysis
    from tests.test_model import hits
    app = create_app(db_path=str(tmp_path / "l.db"), udp_port=0, keys={"k": "kalali"}, tp_bonus={})
    now = time.time()
    rows = hits(300, 1320, [1650, 1760], seed=90, t0=now - 600)
    for i, r in enumerate(rows):
        r.update(session="s", seq=i, target_id=5, main_dmg=130, t=now - 600 + i, accuracy=1476)
    rows.append({"kind": "ws", "is_me": 1, "actor": "Kalali", "target": "Locus Dire Bat", "ws": "Ruthless Stroke",
                 "attack": 2275, "damage": 9000, "session": "s", "seq": 999, "t": now - 5, "target_id": 5})
    with TestClient(app) as client:
        client.post("/ingest", json=rows, headers={"x-token": "k"})
        wait_for_analysis(client)
        deadline = time.time() + 60
        while time.time() < deadline and client.get("/api/profiles").json()["status"] != "ok":
            time.sleep(0.2)
        assert "Locus Dire Bat\t" in client.get("/api/profiles.txt").text
        (player,) = client.get("/api/live").json()["players"]
        assert player["player"] == "Kalali" and player["advice"]["ws_name"] == "Ruthless Stroke"
        assert player["advice"]["ws_command"].startswith("gs c set WeaponskillMode ")
