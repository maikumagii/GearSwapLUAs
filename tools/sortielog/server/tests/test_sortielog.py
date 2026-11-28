import json
import random
import socket
import time

from fastapi.testclient import TestClient

from sortielog.analysis import analyze, ftp_at, parse_tp_bonus
from sortielog.app import create_app, parse_keys
from sortielog.schema import COLUMNS, normalize


def ws_rows(n, low, high, ws="Black Halo", tp=3000, target="Aminon", buffs="", seed=1):
    rng = random.Random(seed)
    base = 5000
    return [normalize({
        "kind": "ws", "is_me": 1, "target": target, "ws": ws, "tp": tp, "wall_same": 0,
        "damage": int(base * (ftp_at(ws, tp) or 10.0) * rng.uniform(low, high)), "buffs": buffs,
    }) for _ in range(n)]


def test_ftp_interpolation_and_bonus():
    assert ftp_at("Black Halo", 1000) == 3.0 + 1.0
    assert abs(ftp_at("Black Halo", 2500) - (7.25 + 1.25 + 1.0)) < 1e-9
    assert ftp_at("Black Halo", 2900, tp_bonus=250) == 9.75 + 1.0
    assert ftp_at("Unknown WS", 3000) is None
    assert parse_tp_bonus("Black Halo=250, Savage Blade=500,bad") == {"Black Halo": 250, "Savage Blade": 500}


def test_capped_spread_reads_capped():
    result = analyze(ws_rows(40, 1.00, 1.05))
    group = result["ws"][0]
    assert group["n"] == 40
    assert group["verdict"] == "likely capped"


def test_uncapped_spread_reads_below_cap():
    result = analyze(ws_rows(40, 0.90, 1.20))
    assert result["ws"][0]["verdict"] == "likely below cap"


def test_damage_cap_hits_excluded_and_counted():
    rows = ws_rows(10, 1.0, 1.05)
    rows += [normalize({"kind": "ws", "is_me": 1, "target": "Aminon", "ws": "Black Halo",
                        "tp": 3000, "wall_same": 0, "damage": 99999})] * 3
    group = analyze(rows)["ws"][0]
    assert group["damage_capped"] == 3
    assert group["n"] == 10


def test_attack_sensitivity():
    low = ws_rows(10, 1.0, 1.05, buffs="Haste", seed=2)
    high = [dict(r, damage=int(r["damage"] * 1.10), buffs="Minuet;Minuet;Attack Boost") for r in ws_rows(10, 1.0, 1.05, seed=3)]
    attack = analyze(low + high)["ws"][0]["attack"]
    assert attack["gain"] > 0.05
    assert attack["verdict"].startswith("attack-sensitive")


def test_unknown_ws_uses_tp_bands_and_party_rows_ignored():
    rows = ws_rows(9, 1.0, 1.05, ws="Ruthless Stroke", tp=2600)
    rows.append(normalize({"kind": "ws", "is_me": 0, "target": "Aminon", "ws": "Ruthless Stroke", "damage": 50000}))
    group = analyze(rows)["ws"][0]
    assert group["basis"] == "TP 2500-2749"
    assert group["n"] == 9


def test_melee_groups_by_hand_and_skips_crits():
    rows = [normalize({"kind": "melee", "is_me": 1, "target": "Aminon", "damage": d, "crit": c, "hand": h})
            for d, c, h in [(1000, 0, 0), (1010, 0, 0), (3000, 1, 0), (700, 0, 1)]]
    melee = analyze(rows)["melee"]
    assert [(g["hand"], g["n"]) for g in melee] == [("main", 2), ("off", 1)]


def free_udp_port():
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]


def test_players_are_grouped_separately():
    rows = ws_rows(10, 1.0, 1.05)
    rows += [dict(r, actor="Friend") for r in ws_rows(10, 0.9, 1.2, seed=9)]
    rows = [dict(r, actor=r.get("actor") or "Kalali") for r in rows]
    groups = {g["player"]: g["verdict"] for g in analyze(rows)["ws"]}
    assert groups == {"Kalali": "likely capped", "Friend": "likely below cap"}


def test_parse_keys():
    assert parse_keys("kalali:abc, friend:def,bad,:x", "legacy") == {"abc": "kalali", "def": "friend", "legacy": "default"}


def csv_body(rows):
    lines = [",".join(COLUMNS)]
    for row in rows:
        lines.append(",".join(str(row.get(c, "")) for c in COLUMNS))
    return "\n".join(lines) + "\n"


def test_http_csv_json_udp_keys_and_dedupe(tmp_path):
    port = free_udp_port()
    app = create_app(db_path=str(tmp_path / "t.db"), udp_port=port, keys={"k1": "kalali", "k2": "friend"}, tp_bonus={})
    with TestClient(app) as client:
        rows = [{"kind": "ws", "is_me": 1, "actor": "Kalali", "target": "Aminon", "ws": "Black Halo", "tp": 3000,
                 "wall_same": 0, "damage": 60000 + i * 100, "session": "s1", "seq": i + 1} for i in range(5)]
        body = csv_body(rows)
        assert client.post("/ingest/csv", content=body).status_code == 401
        assert client.post("/ingest/csv", content=body, headers={"x-token": "nope"}).status_code == 401
        assert client.post("/ingest/csv", content=body, headers={"x-token": "k1"}).json() == {"received": 5, "accepted": 5}
        # Forwarder retry of the same batch is ignored; a different player's identical seq numbers are kept.
        assert client.post("/ingest/csv", content=body, headers={"authorization": "Bearer k1"}).json()["accepted"] == 0
        assert client.post("/ingest/csv", content=body, headers={"x-token": "k2"}).json()["accepted"] == 5

        json_rows = [dict(rows[0], seq=100, damage=61000)]
        assert client.post("/ingest", json=json_rows, headers={"x-token": "k1"}).json() == {"accepted": 1}
        assert client.post("/ingest", content=b"{bad", headers={"x-token": "k1"}).status_code == 400

        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
            good = dict(rows[0], seq=200, damage=62000, token="k1")
            sock.sendto(json.dumps(good).encode(), ("127.0.0.1", port))
            sock.sendto(json.dumps(dict(good, seq=201, token="wrong")).encode(), ("127.0.0.1", port))
            sock.sendto(b"not json", ("127.0.0.1", port))
        deadline = time.time() + 3
        while time.time() < deadline and client.get("/health").json()["rejected"] < 2:
            time.sleep(0.05)
        health = client.get("/health").json()
        assert health == {"ok": True, "events": 12, "rejected": 2}

        assert client.get("/api/uploaders").json() == ["friend", "kalali"]
        mine = client.get("/api/analysis", params={"uploader": "kalali"}).json()
        assert mine["rows"] == 7 and mine["ws"][0]["n"] == 7
        assert {s["uploader"] for s in client.get("/api/sessions").json()} == {"kalali", "friend"}
        assert client.get("/api/targets").json() == ["Aminon"]
        assert len(client.get("/api/events", params={"kind": "ws", "limit": 3}).json()) == 3
        assert "SortieLog Live" in client.get("/").text


def test_open_ingest_without_keys(tmp_path):
    app = create_app(db_path=str(tmp_path / "o.db"), udp_port=0, keys={}, tp_bonus={})
    with TestClient(app) as client:
        assert client.post("/ingest", json={"kind": "note", "session": "s"}).json() == {"accepted": 1}
        assert client.get("/api/uploaders").json() == ["anonymous"]


def test_store_migrates_old_database(tmp_path):
    import sqlite3
    from sortielog.store import Store
    path = str(tmp_path / "old.db")
    old = sqlite3.connect(path)
    old.execute('CREATE TABLE events (id INTEGER PRIMARY KEY, received REAL, uploader TEXT, "kind" TEXT, "session" TEXT, "seq" INTEGER)')
    old.execute("INSERT INTO events (kind, session, seq) VALUES ('note', 's', 1)")
    old.commit()
    old.close()
    store = Store(path)
    assert store.insert([normalize({"kind": "melee", "session": "s", "seq": 2, "attack": 3456, "weapon": "Club"})], "kalali") == 1
    rows = store.query(kinds=["melee"])
    assert rows[0]["attack"] == 3456 and rows[0]["weapon"] == "Club"
    assert store.count() == 2
