# Checklist — integration hardening (webhooks & partners)

Use before calling an inbound integration “done”.

## Authentication & integrity

- [ ] Shared secret or signing key stored in env / secret manager, not in repo.
- [ ] Signature covers body (raw bytes) or documented canonical form; clock skew documented if using timestamps.
- [ ] Reject missing or malformed signatures with **401** (avoid leaking “almost right” hints in prod if policy requires).

## Reliability

- [ ] **Idempotency** key from partner or derived from stable event id; store outcome for replay window (TTL or bounded table growth).
- [ ] Timeout budget for partner calls if you callback; circuit breaker or fail-fast documented.
- [ ] **Dead-letter** path for poison payloads; alert or dashboard hook defined.

## Observability

- [ ] **request_id** propagated in logs; partner correlation id logged if provided.
- [ ] Metrics or counts: accepted, rejected, DLQ’d (even manual log grep documented).

## Security & abuse

- [ ] Rate limit or IP allowlist if product requires it.
- [ ] Payload size limit; content-type validation.
- [ ] No sensitive fields logged (PII, tokens).

## Documentation

- [ ] Partner-facing or internal runbook: example curl, expected headers, error codes.
- [ ] Versioning story if event schema evolves.
