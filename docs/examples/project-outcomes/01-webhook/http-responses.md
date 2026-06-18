# HTTP responses — webhook receiver

Captured with `curl -i` against [webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab).  
`WEBHOOK_SECRET=capture-demo-secret-32chars-min` · `POST http://127.0.0.1:18080/webhook`

Signature helper:

```bash
SIG=$(printf '%s' "$BODY" | openssl dgst -sha256 -hmac "$SECRET" | awk '{print $2}')
```

---

## Scenario 1 — Happy path (first delivery)

```bash
BODY='{"event":"test.ping","data":{"n":1}}'
curl -i -X POST http://127.0.0.1:18080/webhook \
  -H "Content-Type: application/json" \
  -H "Idempotency-Key: capture-key-happy-1" \
  -H "X-Request-Id: req-capture-happy-001" \
  -H "X-Signature: sha256=${SIG}" \
  -d "$BODY"
```

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=UTF-8
X-Request-Id: req-capture-happy-001

{"result":{"ok":true,"received":{"event":"test.ping","data":{"n":1}}},"request_id":"req-capture-happy-001"}
```

---

## Scenario 2 — Idempotent replay

Same `BODY`, same `Idempotency-Key`, new `X-Request-Id`:

```http
HTTP/1.1 200 OK
X-Request-Id: req-capture-replay-002

{"result":{"ok":true,"received":{"event":"test.ping","data":{"n":1}}},"request_id":"req-capture-happy-001"}
```

Note: response body still contains **`request_id` from the first delivery** — that is the stored replay payload.

---

## Scenario 3 — Invalid signature

```http
HTTP/1.1 401 Unauthorized
X-Request-Id: a05fa30c41b04fe12b9d5ddfc95ff8e5

{"error":"invalid signature","request_id":"a05fa30c41b04fe12b9d5ddfc95ff8e5"}
```

---

## Scenario 4 — Missing idempotency key

Valid signature; no `Idempotency-Key` header:

```http
HTTP/1.1 400 Bad Request
X-Request-Id: 5df8f60f79d6348a663e330ad79f64f3

{"error":"missing_idempotency_key","request_id":"5df8f60f79d6348a663e330ad79f64f3"}
```

---

## Scenario 5 — Poison payload (dead letter)

```bash
BODY='{"event":"test.boom","data":{"fail":true}}'
```

```http
HTTP/1.1 500 Internal Server Error
X-Request-Id: req-capture-boom-005

{"error":"handler_failed","request_id":"req-capture-boom-005"}
```

See [store-snapshots.md](store-snapshots.md) for `dead_letters` row.

---

## Scenario 9 — Retry after dead letter (handler not fixed)

Same key as scenario 5 after `abandon()` — partner **may** retry; handler still throws until you remove `test.boom` path:

```http
HTTP/1.1 500 Internal Server Error
X-Request-Id: req-capture-retry-009

{"error":"handler_failed","request_id":"req-capture-retry-009"}
```

After fixing the handler, the same key should complete with `200` and a new `idemp` `completed` row.

---

## Scenario 7 — Concurrent same key (409)

Not captured in this run. Expected shape when a second request arrives while `status = processing`:

```http
HTTP/1.1 409 Conflict

{"error":"request_in_progress_for_key","request_id":"<uuid>","idempotency_key":"<same-key>"}
```

Log message: `concurrent_or_inflight`.
