import sqlite3
import threading
import time

from .schema import COLUMNS, FLOAT_FIELDS, INT_FIELDS


def _sql_type(column):
    if column in INT_FIELDS:
        return "INTEGER"
    if column in FLOAT_FIELDS:
        return "REAL"
    return "TEXT"


class Store:
    def __init__(self, path):
        self._lock = threading.Lock()
        self._conn = sqlite3.connect(path, check_same_thread=False)
        self._conn.row_factory = sqlite3.Row
        with self._lock:
            self._conn.execute("PRAGMA journal_mode=WAL")
            self._conn.execute("PRAGMA synchronous=NORMAL")
            columns = ", ".join(f'"{c}" {_sql_type(c)}' for c in COLUMNS)
            self._conn.execute(
                f"CREATE TABLE IF NOT EXISTS events (id INTEGER PRIMARY KEY, received REAL, uploader TEXT, {columns})")
            self._conn.execute("CREATE INDEX IF NOT EXISTS events_session ON events(session)")
            self._conn.execute("CREATE INDEX IF NOT EXISTS events_kind_target ON events(kind, target)")
            # Retried uploads resend rows; (uploader, session, seq) identifies a row. NULL seq is never deduped.
            self._conn.execute("CREATE UNIQUE INDEX IF NOT EXISTS events_dedupe ON events(uploader, session, seq)")
            self._conn.commit()
        self.rejected = 0

    def insert(self, rows, uploader):
        rows = [r for r in rows if r.get("kind")]
        if not rows:
            return 0
        names = ", ".join(["received", "uploader"] + [f'"{c}"' for c in COLUMNS])
        placeholders = ", ".join("?" for _ in range(len(COLUMNS) + 2))
        now = time.time()
        values = [[now, uploader] + [r.get(c) for c in COLUMNS] for r in rows]
        with self._lock:
            before = self._conn.total_changes
            self._conn.executemany(f"INSERT OR IGNORE INTO events ({names}) VALUES ({placeholders})", values)
            self._conn.commit()
            return self._conn.total_changes - before

    def query(self, kinds=None, target=None, session=None, since=None, after_id=None, limit=None,
              newest_first=False, uploader=None):
        clauses, params = [], []
        if kinds:
            clauses.append("kind IN (%s)" % ", ".join("?" for _ in kinds))
            params.extend(kinds)
        for column, value in (("target", target), ("session", session), ("uploader", uploader)):
            if value:
                clauses.append(f"{column} = ?")
                params.append(value)
        if since is not None:
            clauses.append("t >= ?")
            params.append(since)
        if after_id is not None:
            clauses.append("id > ?")
            params.append(after_id)
        sql = "SELECT * FROM events"
        if clauses:
            sql += " WHERE " + " AND ".join(clauses)
        sql += " ORDER BY id DESC" if newest_first else " ORDER BY id"
        if limit:
            sql += " LIMIT ?"
            params.append(int(limit))
        with self._lock:
            return [dict(r) for r in self._conn.execute(sql, params).fetchall()]

    def sessions(self, uploader=None):
        sql = ("SELECT session, uploader, COUNT(*) AS events, MIN(t) AS start, MAX(t) AS last, "
               "GROUP_CONCAT(DISTINCT target) AS targets FROM events")
        params = []
        if uploader:
            sql += " WHERE uploader = ?"
            params.append(uploader)
        sql += " GROUP BY session, uploader ORDER BY MAX(t) DESC"
        with self._lock:
            return [dict(r) for r in self._conn.execute(sql, params).fetchall()]

    def distinct(self, column, session=None):
        if column not in ("target", "uploader"):
            raise ValueError(column)
        sql = f"SELECT DISTINCT {column} FROM events WHERE {column} IS NOT NULL"
        params = []
        if session:
            sql += " AND session = ?"
            params.append(session)
        with self._lock:
            return [r[0] for r in self._conn.execute(sql + f" ORDER BY {column}", params).fetchall()]

    def count(self):
        with self._lock:
            return self._conn.execute("SELECT COUNT(*) FROM events").fetchone()[0]

    def close(self):
        with self._lock:
            self._conn.close()
