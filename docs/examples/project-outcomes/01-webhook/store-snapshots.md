# Store snapshots — webhook receiver

SQLite database after exploration scenarios 1, 2, and 5.  
Query: `sqlite3 storage/capture-test.sqlite`

---

## `idemp` after scenario 2 (replay)

One `completed` row for the happy-path key:

```text
          key = capture-key-happy-1
       status = completed
  http_status = 200
response_body = {"result":{"ok":true,"received":{"event":"test.ping","data":{"n":1}}},"request_id":"req-capture-happy-001"}
   created_at = 2026-06-18 21:22:19
```

No second row for replay — the same key maps to one completed outcome.

---

## `dead_letters` after scenario 5 (and 9 retry)

Handler failure stores evidence; `idemp` row for `capture-key-boom-1` is **abandoned** (deleted) so retry is allowed:

```text
             id = 1
idempotency_key = capture-key-boom-1
        payload = {"event":"test.boom","data":{"fail":true}}
          error = simulated_handler_failure
                #0 ... stack trace continues ...
     created_at = 2026-06-18 21:22:19
```

A second retry without fixing the handler appends another `dead_letters` row (id = 2) with the same payload.

---

## Schema reference

```sql
CREATE TABLE idemp (
    key TEXT PRIMARY KEY,
    status TEXT NOT NULL,          -- processing | completed
    http_status INTEGER,
    response_body TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dead_letters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    idempotency_key TEXT,
    payload TEXT NOT NULL,
    error TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```
