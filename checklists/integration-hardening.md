# Checklist — integration hardening (webhooks and partners)

Use this checklist before you call an inbound integration **done**. It covers trust, replay safety, and what happens when a partner sends bad data.

## Authentication and integrity

**Why:** Unsigned webhooks allow anyone who knows your URL to forge events—integrity checks establish trust at the HTTP boundary.

**Handbook:** [Project 1](../career-project-specs/01-integration-webhook-receiver.md) · [Software engineering — security](../docs/concepts/software-engineering.md#security-for-applications)

These items make sure only your partner can send valid events, and that the payload was not changed in transit.

- [ ] Shared secret or signing key stored in environment variables or a secret manager — not in the repo.
- [ ] Signature covers the body (raw bytes) or a documented canonical form; clock skew documented if using timestamps.
- [ ] Reject missing or malformed signatures with **401** (avoid leaking “almost right” hints in production if your policy requires that).

**Pass:** HMAC over raw body; invalid signature → 401. **Fail:** signature checked after JSON re-encode breaks valid partner traffic.

## Reliability

**Why:** Partners retry until they see 2xx—your system must survive duplicate delivery and slow handlers without corrupting data.

**Handbook:** [Integration sync/async](../docs/concepts/software-engineering.md#integration-sync-async-and-messaging)

These items keep duplicate or slow partner traffic from corrupting your data or blocking your system.

- [ ] **Idempotency** key from the partner or derived from a stable event id; store the outcome for a replay window (time-to-live or bounded table growth).
- [ ] Timeout budget for partner calls if you callback; circuit breaker or fail-fast behavior documented.
- [ ] **Dead-letter queue (DLQ)** path for poison payloads; alert or dashboard hook defined.

**Pass:** idempotency store returns same outcome on replay. **Fail:** idempotency key only in logs, not in durable store.

## Observability

These items let you trace a single event through logs and see whether traffic is healthy.

- [ ] **request_id** propagated in logs; partner correlation id logged if provided.
- [ ] Metrics or counts: accepted, rejected, sent to DLQ (even a manual log grep documented is fine).

## Security and abuse

These items limit who can hit your endpoint and what they can send.

- [ ] Rate limit or IP allowlist if the product requires it.
- [ ] Payload size limit; content-type validation.
- [ ] No sensitive fields logged (personally identifiable information (PII), tokens).

## Documentation

These items help your team and the partner debug and evolve the integration safely.

- [ ] Partner-facing or internal runbook: example curl, expected headers, error codes.
- [ ] Versioning story if the event schema evolves.
