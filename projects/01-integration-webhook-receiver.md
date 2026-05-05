# Project 1 — Integration webhook receiver (hardened)

## Problem

Practice a **production-shaped** HTTP inbound integration: verify caller, dedupe replays, log usefully, and optionally park poison messages.

## Code repo

**Local:** [`../../webhook-receiver-lab`](../../webhook-receiver-lab) (sibling of `career-playbook` under `dev/`).

**Remote (optional):** Add your GitHub URL after `git init` / push, e.g. `https://github.com/shemaiahCox/webhook-receiver-lab`.

## Stack

PHP 8.1+, SQLite (file), no framework (readable in one sitting). Swap to Laravel later if you want ORM and queues.

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
