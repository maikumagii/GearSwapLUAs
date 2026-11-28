"""SortieLog ingest + live analysis server.

HTTP :8080  POST /ingest/csv (forwarder), POST /ingest (JSON), GET /api/*, dashboard at /
UDP  :5140  optional LAN live push: one JSON object per datagram

Auth: each player gets a key (SORTIELOG_KEYS="kalali:KEY1,friend:KEY2"), sent as an
"X-Token" header, "Authorization: Bearer <key>", or a "token" field in JSON/UDP rows.
The key's name is stored as the row's uploader. With no keys configured, ingest is open
and rows are stored as "anonymous".
"""

import asyncio
import csv
import io
import json
import logging
import os
import time
from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import HTMLResponse

from .analysis import analyze, parse_tp_bonus
from .schema import normalize
from .store import Store

log = logging.getLogger("sortielog")
STATIC = Path(__file__).parent / "static"
ANALYSIS_KINDS = ["ws", "melee", "melee_miss"]
MAX_BODY = 5_000_000


def parse_keys(text, legacy_token=""):
    """'kalali:abc,friend:def' -> {'abc': 'kalali', 'def': 'friend'} (key -> uploader name)."""
    keys = {}
    for part in (text or "").split(","):
        if ":" in part:
            name, key = part.split(":", 1)
            if name.strip() and key.strip():
                keys[key.strip()] = name.strip()
    if legacy_token:
        keys.setdefault(legacy_token, "default")
    return keys


class Auth:
    def __init__(self, keys):
        self.keys = keys
        if not keys:
            log.warning("No SORTIELOG_KEYS set: ingest is open to anyone who can reach it")

    def uploader(self, key):
        """Uploader name for a key, or None if it's rejected."""
        if not self.keys:
            return "anonymous"
        return self.keys.get(key or "")

    def from_request(self, request, body_token=None):
        header = request.headers.get("x-token")
        if not header:
            bearer = request.headers.get("authorization", "")
            header = bearer[7:].strip() if bearer.lower().startswith("bearer ") else None
        name = self.uploader(header or body_token)
        if name is None:
            raise HTTPException(status_code=401, detail="bad or missing key")
        return name


class UdpIngest(asyncio.DatagramProtocol):
    def __init__(self, store, auth):
        self.store = store
        self.auth = auth

    def datagram_received(self, data, addr):
        try:
            obj = json.loads(data.decode("utf-8", errors="replace"))
        except ValueError:
            self.store.rejected += 1
            return
        name = self.auth.uploader(obj.get("token")) if isinstance(obj, dict) else None
        if name is None:
            self.store.rejected += 1
            return
        self.store.insert([normalize(obj)], name)


def create_app(db_path=None, udp_port=None, keys=None, tp_bonus=None, level_diff=None):
    db_path = db_path or os.environ.get("SORTIELOG_DB", "/data/sortielog.db")
    udp_port = int(os.environ.get("SORTIELOG_UDP_PORT", "0")) if udp_port is None else udp_port
    if keys is None:
        keys = parse_keys(os.environ.get("SORTIELOG_KEYS", ""), os.environ.get("SORTIELOG_TOKEN", ""))
    tp_bonus = parse_tp_bonus(os.environ.get("SORTIELOG_TP_BONUS", "")) if tp_bonus is None else tp_bonus
    level_diff = float(os.environ.get("SORTIELOG_LEVEL_DIFF", "0") or 0) if level_diff is None else level_diff
    auth = Auth(keys)

    @asynccontextmanager
    async def lifespan(app):
        app.state.store = Store(db_path)
        transport = None
        if udp_port:
            loop = asyncio.get_running_loop()
            transport, _ = await loop.create_datagram_endpoint(
                lambda: UdpIngest(app.state.store, auth), local_addr=("0.0.0.0", udp_port))
            log.info("UDP ingest listening on %d", udp_port)
        try:
            yield
        finally:
            if transport:
                transport.close()
            app.state.store.close()

    app = FastAPI(title="SortieLog", lifespan=lifespan)

    async def read_body(request):
        body = await request.body()
        if len(body) > MAX_BODY:
            raise HTTPException(status_code=413, detail="batch too large")
        return body

    @app.get("/health")
    def health(request: Request):
        store = request.app.state.store
        return {"ok": True, "events": store.count(), "rejected": store.rejected}

    @app.post("/ingest")
    async def ingest(request: Request):
        try:
            payload = json.loads(await read_body(request))
        except ValueError:
            raise HTTPException(status_code=400, detail="invalid JSON")
        items = payload if isinstance(payload, list) else [payload]
        if not all(isinstance(item, dict) for item in items):
            raise HTTPException(status_code=400, detail="expected an object or a list of objects")
        name = auth.from_request(request, items[0].get("token") if items else None)
        return {"accepted": request.app.state.store.insert([normalize(item) for item in items], name)}

    @app.post("/ingest/csv")
    async def ingest_csv(request: Request):
        name = auth.from_request(request)
        text = (await read_body(request)).decode("utf-8", errors="replace")
        rows = [normalize(row) for row in csv.DictReader(io.StringIO(text))]
        return {"received": len(rows), "accepted": request.app.state.store.insert(rows, name)}

    @app.get("/api/sessions")
    def sessions(request: Request, uploader: str | None = None):
        return request.app.state.store.sessions(uploader)

    @app.get("/api/targets")
    def targets(request: Request, session: str | None = None):
        return request.app.state.store.distinct("target", session)

    @app.get("/api/uploaders")
    def uploaders(request: Request):
        return request.app.state.store.distinct("uploader")

    @app.get("/api/events")
    def events(request: Request, kind: str | None = None, target: str | None = None,
               session: str | None = None, uploader: str | None = None,
               after_id: int | None = None, limit: int = 200):
        kinds = kind.split(",") if kind else None
        return request.app.state.store.query(kinds, target, session, after_id=after_id, limit=min(limit, 5000),
                                             newest_first=after_id is None, uploader=uploader)

    @app.get("/api/analysis")
    def analysis(request: Request, target: str | None = None, session: str | None = None,
                 uploader: str | None = None, minutes: float | None = None):
        since = time.time() - minutes * 60 if minutes else None
        rows = request.app.state.store.query(ANALYSIS_KINDS, target, session, since, uploader=uploader)
        result = analyze(rows, tp_bonus, level_diff)
        result["rows"] = len(rows)
        return result

    @app.get("/", response_class=HTMLResponse)
    def dashboard():
        return (STATIC / "index.html").read_text(encoding="utf-8")

    return app


app = create_app()
