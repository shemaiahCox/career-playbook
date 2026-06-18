# ADR-001: Fast ack with idempotency store (not sync downstream in webhook handler)

## Status
Accepted

## Pillar
1 — System shape (primary) · 2 — Integration and messaging (secondary)

## Context

Partners (Stripe-style, Boomi, n8n) retry webhooks on timeout or 5xx. Our handler must not run slow downstream work (enrichment, queue publish, billing) **before** returning 2xx, or partner timeouts cause duplicate delivery storms.

Alternative considered: single sync request that completes all business logic before 200.

## Decision

- Verify hash-based message authentication code (HMAC) on **raw body**, then parse JSON.
- **Upsert idempotency key** in a transaction; if already processed, return stored response immediately.
- Return **2xx after durable idempotency record** — enqueue or apply business change in same transaction where possible.
- Park unparseable or repeatedly failing payloads in **dead-letter queue (DLQ)** with evidence.

Rejected: long sync handler that holds partner connection through downstream API calls.

## Consequences

**Positive:** Partner retry budget respected; clear separation of transport vs business semantics.  
**Negative:** Downstream lag not visible to partner; need queue/worker observability (Project 6).  
**Follow-ups:** Add `request_id` to logs (Pillar 5); document replay from DLQ in runbook.
