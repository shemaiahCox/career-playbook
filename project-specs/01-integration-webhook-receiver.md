# Project 1 — Integration webhook receiver (hardened)

## Problem

Practice a **production-shaped** HTTP inbound integration: verify caller, dedupe replays, log usefully, and optionally park poison messages.

## Career relevance

**Summary:** You learn to treat inbound webhooks like money-moving, security-sensitive **integrations**—not demos. That means proving who sent the event, making retries safe, and leaving an audit trail when something goes wrong.

### In depth

Inbound webhooks are how **payments, CRMs, shipping, and iPaaS tools** push events into your product. Interviewers and senior engineers expect you to reason about **retries, spoofing, and partial failures**—not just “parse JSON and insert a row.” The same patterns apply when you own **event consumers** behind Kafka or a queue later; HTTP is just the easiest place to drill the habits.

**Why learning this moves the needle**

- **Trust and money:** Duplicate `invoice.paid` or `subscription.updated` events can double-fulfill orders or corrupt billing. Idempotency is a common **staff-level** talking point: you’re separating *transport* (HTTP may arrive twice) from *business* (wallet or inventory must move once). Saying “we use an idempotency key” in an interview is useless unless you can describe **what** is keyed and **what** happens on replay.
- **Security:** Unsigned webhooks are trivial to forge; HMAC (or mTLS in bigger shops) is table stakes for **B2B SaaS and fintech**. You’ll be asked how you’d rotate secrets, handle **timing attacks** on comparisons, and why the raw body matters for signatures.
- **Ops:** When partners open tickets (“we sent event X at 14:02”), **`request_id` + structured logs** are how you answer in minutes instead of days. That’s the difference between looking competent on-call and burning a weekend diffing environments.
- **Reliability:** Poison payloads happen (bad schema, buggy deploy). **Dead letters** let you fix forward without losing evidence or blocking the whole pipeline. They also give you a **replay story**: after a fix, you either re-drive from the DLQ or let the partner retry with the same idempotency key—both need a clear design.

**Real-world situations this project mirrors**

- **Payment and billing providers** (Stripe, PayPal, Adyen, etc.) send the same webhook again after a **`5xx`**, a timeout, or their own redelivery policy. Your side must not double-apply ledger entries.
- **iPaaS** (Boomi, MuleSoft, Workato, Zapier-style connectors) **retry** until they see `200`; your endpoint is their “success” signal, not your internal approval of the payload shape.
- **Forged traffic:** without verification, anyone who knows your URL can POST fake “subscription canceled” events. Signature verification is how you maintain **non-repudiation** at the HTTP boundary.
- **Partial failure:** handler throws after **some** DB writes; without idempotency or compensation, replay might **duplicate** side effects. Dead-letter + abandon (or similar) is how you get back to a known state and retry deliberately.

## Code repo

| | URL |
|---|-----|
| **GitHub** | [https://github.com/shemaiahCox/webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab) |
| **SSH** | `git@github.com:shemaiahCox/webhook-receiver-lab.git` |
| **Local sibling** | [`../projects/webhook-receiver-lab`](../projects/webhook-receiver-lab) |

## Stack

PHP 8.1+, SQLite (file), no framework (readable in one sitting). Swap to Laravel later if you want ORM and queues. **Same behavior in Node + TypeScript:** [Project 6 — track A](06-node-typescript-lab.md).

**Deeper SQL:** For `EXPLAIN`, indexing, transaction isolation, and pagination drills beyond this lab’s SQLite usage, see [Project 7 — SQL performance lab](07-sql-performance-lab.md).

## Key concepts (with definitions and code)

### `Idempotency-Key` (HTTP header)

**What:** A stable identifier chosen by the **sender** (or agreed from payload) that names one **logical** delivery of work—e.g. the partner’s event UUID or `order-123:charge` .

**Problem it solves:** Networks and integration platforms **retry**. Without idempotency, `POST /webhook` twice can **double-charge**, **duplicate rows**, or send two emails. With it, the second POST with the same key must return the **same outcome** as the first (or a clear concurrency signal).

**In this repo:** Header `Idempotency-Key`, with JSON fallback field `idempotency_key` if the header is empty.

```php
// public/index.php — require a key before doing side effects
$idempotencyKey = $_SERVER['HTTP_IDEMPOTENCY_KEY'] ?? '';
// ... optional JSON body fallback ...
if ($idempotencyKey === '') {
    http_response_code(400);
    // ...
}
```

### Idempotency **store** (replay + in-flight)

**What:** Persistent record: “this key already finished with HTTP 200 and this JSON body,” or “this key is currently being processed.”

**Problem it solves:** Separates **transport retries** (same bytes again) from **new work** (new key).

**In this repo:** SQLite table `idemp`; `beginOrResume()` returns whether to replay, wait (`409`), or run the handler.

```php
// src/IdempotencyStore.php — completed deliveries replay the stored body
if ($row['status'] === 'completed') {
    return [
        'kind' => 'completed',
        'status' => (int) $row['http_status'],
        'body' => (string) $row['response_body'],
    ];
}
```

### HMAC webhook signature (`X-Signature`)

**What:** A **Message Authentication Code** (here HMAC-SHA256) over the **raw** request body, using a **shared secret** only you and the partner know. The header carries `sha256=<hex>` so you can recompute and compare.

**Problem it solves:** Proves the caller **knows the secret** (authenticity + integrity). Random clients cannot forge events; tampered bodies fail verification.

**Why it solves:** `hash_equals()` compares in **constant time**, reducing timing side channels vs naive `===`.

```php
// src/SignatureVerifier.php
$expected = 'sha256=' . hash_hmac('sha256', $rawBody, $this->secret);
if (! hash_equals($expected, $header)) {
    throw new HttpException(401, 'invalid signature');
}
```

**Must read raw body once:** Re-encoding JSON changes bytes → signature breaks. This repo uses `file_get_contents('php://input')` before any parsing.

### Dead letter (poison message)

**What:** A **durable log** of a payload that **crashed your handler** (bad schema, bug, downstream timeout), so humans can inspect and replay after a fix.

**Problem it solves:** Blind retries without visibility **spam** errors; dead-letter stores **evidence** (`payload`, stack trace, idempotency key).

**In this repo:** Table `dead_letters`; after logging, `abandon()` **deletes** the `processing` row so the partner can **retry** the same key after you deploy a fix. Successful completions stay cached forever (until you add TTL cleanup).

```php
// public/index.php
$store->recordDeadLetter($idempotencyKey, $rawBody, $e->getMessage() . "\n" . $e->getTraceAsString());
$store->abandon($idempotencyKey);
```

### `X-Request-Id` (correlation)

**What:** An identifier carried **in headers and logs** so one HTTP request trace lines up across load balancers, app logs, and partner support tickets.

**Problem it solves:** “User X failed at 14:02” becomes greppable without guessing internal IDs.

**In this repo:** Accept incoming `X-Request-Id` or generate one; echo on response; include in every `Logger::log` context.

```php
$requestId = $_SERVER['HTTP_X_REQUEST_ID'] ?? null;
if ($requestId === null || $requestId === '') {
    $requestId = bin2hex(random_bytes(16));
}
header('X-Request-Id: ' . $requestId);
```

### HTTP `409` for in-flight / races

**What:** “Same idempotency key, but another request still **owns** the row (`processing`).”

**Problem it solves:** Tells the platform to **back off and retry** instead of assuming success or failure.

**In this repo:** Returned when a row exists with `status = processing` or on SQLite `UNIQUE` race during concurrent inserts.

## Success criteria

- [ ] `POST /webhook` accepts JSON payloads.
- [ ] **`Idempotency-Key`** header (or body field fallback): duplicate deliveries return same response without double-processing.
- [ ] **HMAC-SHA256** signature header (`X-Signature: sha256=<hex>`) keyed by `WEBHOOK_SECRET`; reject missing/invalid with 401.
- [ ] **Structured JSON logs** to stderr (level, message, `request_id`, `idempotency_key`, duration_ms).
- [ ] **`request_id`** from `X-Request-Id` or generated UUID.
- [ ] **Dead-letter**: on handler exception, store payload + error in `dead_letters` table and return 500 (or 202 + async policy—document choice in repo README).

## Exploration scenarios

Hands-on cases to **drive the code paths** and deepen interview vocabulary. Keep commands and exact headers next to runnable code in the **lab README** ([webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab)); use this section as the **menu of outcomes** to verify.

### 1 — Happy path (first delivery)

- **Setup:** `WEBHOOK_SECRET` set; server running.
- **Action:** `POST /webhook` with valid JSON body, correct `X-Signature` over **raw body**, new `Idempotency-Key`, optional `X-Request-Id`.
- **Expected outcome:** `2xx`; response body stable; logs include structured JSON with `request_id`, `idempotency_key`, `duration_ms`.
- **Stretch:** Compare logs with and without inbound `X-Request-Id` (generated vs echoed).

### 2 — Idempotent replay

- **Setup:** Same payload bytes as scenario 1.
- **Action:** Repeat **identical** request (same `Idempotency-Key`, same body, valid signature).
- **Expected outcome:** Same HTTP status and response body as first delivery; **no double side effects** in SQLite (inspect `idemp` / domain tables).

### 3 — Missing or invalid signature

- **Setup:** Valid body and idempotency key.
- **Action:** Omit `X-Signature`, then send wrong `sha256=` hex with otherwise valid request.
- **Expected outcome:** `401` both times; **no** row advanced as “completed” for that key.

### 4 — Missing idempotency key

- **Action:** Valid signature but **no** `Idempotency-Key` header and no body fallback field (if your implementation requires a key).
- **Expected outcome:** `400` with clear error shape; no partial writes.

### 5 — Poison payload → dead letter

- **Setup:** Trigger handler path that **throws** after idempotency begins (e.g. malformed inner field your handler treats as fatal, or temporary `throw` in code).
- **Action:** Signed request with new key that hits that path.
- **Expected outcome:** `500` (or documented async policy); row in `dead_letters` with payload/error; **`abandon`** (or equivalent) so partner **can retry** same key after fix—confirm store behavior in DB.

### 6 — Correlation id propagation

- **Action:** Send fixed `X-Request-Id`; grep stderr/logs for that exact string on success and failure paths.
- **Expected outcome:** Same id on response header and every log line for that request.

### 7 — Concurrent deliveries (same key)

- **Setup:** Two terminals or `curl` in parallel.
- **Action:** Same `Idempotency-Key`, same body, two overlapping requests with valid signatures.
- **Expected outcome:** One completion; other sees **`409`** or defined concurrency behavior per **HTTP `409` for in-flight / races** above—not silent double processing.

### 8 — Invalid JSON or wrong `Content-Type`

- **Action:** Signed raw body that is **not** valid JSON; optionally non-JSON body with signature over those bytes.
- **Expected outcome:** Documented status (`400`/`415`/etc.); signature still verified on raw bytes **before** parse where applicable.

### 9 — Replay after dead letter

- **Setup:** Complete scenario 5; fix handler; redeploy or reload.
- **Action:** Partner-style **retry** with the **same** `Idempotency-Key` as the failed delivery.
- **Expected outcome:** Successful processing **or** documented idempotency semantics (prove you understand recovery vs duplicate).

### 10 — Clock / operational sanity (stretch)

- **Action:** Temporarily wrong `WEBHOOK_SECRET` env; restart; hit endpoint.
- **Expected outcome:** All signed requests `401` until secret matches—rehearses secret rotation and “why prod suddenly rejects.”

## Stretch

- Docker Compose with `php` service and mounted volume for SQLite.
- Replay tool: CLI script to re-drive a dead-letter id.

## Maps to

Boomi / integration patterns, event-driven backends, reliability interviews.
