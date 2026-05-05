# Project 1 — Integration webhook receiver (hardened)

## Problem

Practice a **production-shaped** HTTP inbound integration: verify caller, dedupe replays, log usefully, and optionally park poison messages.

## Code repo

| | URL |
|---|-----|
| **GitHub** | [https://github.com/shemaiahCox/webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab) |
| **SSH** | `git@github.com:shemaiahCox/webhook-receiver-lab.git` |
| **Local sibling** | [`../../webhook-receiver-lab`](../../webhook-receiver-lab) |

## Stack

PHP 8.1+, SQLite (file), no framework (readable in one sitting). Swap to Laravel later if you want ORM and queues.

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

## Stretch

- Docker Compose with `php` service and mounted volume for SQLite.
- Replay tool: CLI script to re-drive a dead-letter id.

## Maps to

Boomi / integration patterns, event-driven backends, reliability interviews.
