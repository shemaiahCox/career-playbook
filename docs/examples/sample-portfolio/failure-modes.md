# Failure modes — webhook receiver (Project 1 sample)

**Pillar:** 5 — Reliability, security, operations

## Failure modes without this work

1. **Duplicate webhook delivery** → double billing or duplicate orders unless idempotency key is stored and replay returns the same response without re-applying side effects.

2. **Forged POST to public URL** → unauthorized state change unless hash-based message authentication code (HMAC) is verified over the **raw body** before JSON parsing (body mutation breaks signature).

3. **Poison payload retry loop** → partner hammers 5xx forever, ops blind without dead-letter queue (DLQ) + structured logs tying `request_id` to payload hash.

4. **Slow handler timeout** → partner retries while first request still running → race on idempotency unless store is checked at start of every attempt.

## Mitigations shipped in this lab

| Failure mode | Mitigation | Pillar | Detection signal |
|--------------|------------|--------|------------------|
| Duplicate delivery | Idempotency key + stored response | 2 | Same key → two DB rows or double charge |
| Forged POST | HMAC verify, 401 on mismatch | 5 | 200 on unsigned POST in access log |
| Poison loop | DLQ + documented abandon/replay | 2, 5 | Main queue depth stuck; no DLQ entries |
| Slow handler | Fast ack after durable record | 1 | Partner timeout retries; p95 HTTP > SLA |
