# Checklist — production readiness (platform engineering gate)

Use this before calling **any** lab milestone **done**. It is the universal gate senior engineers expect — from rate limits through security notes — not a replacement for domain deep dives.

**How to use:** Walk sections **top to bottom** for your active step. Skip rows marked **N/A** in the [applicability matrix](#applicability-by-step-1-22) for that step. If you defer a required row, note one line in [PROGRESS.md](../PROGRESS.md) (“Deferred: … because …”).

**Also run when applicable:**

- Inbound webhooks / partner HTTP: [integration-hardening.md](integration-hardening.md)
- User-facing retrieval-augmented generation (RAG) / large language model (LLM) paths: [llm-feature-ship.md](llm-feature-ship.md)
- Browser, forms, sessions (Project 9): [application-security-web-owasp.md](application-security-web-owasp.md)

---

## Rate limits

**Why:** Unbounded traffic exhausts CPU, database connections, and upstream quotas—rate limits are the first edge defense.

**Handbook:** [Servers and networking](../docs/concepts/servers-and-networking.md) · [Project 23 rate limiter](../career-project-specs/23-rate-limiter-gateway-lab.md) (optional)

These items keep public or partner traffic from overwhelming your service.

- [ ] Public or partner-facing endpoints have documented limits (per IP, per tenant, or per API key).
- [ ] Limit exceeded returns a consistent error shape (429 + retry guidance where appropriate).
- [ ] Background workers respect upstream rate limits (bounded concurrency, backoff).

**Pass:** `429` with `Retry-After` after N requests in window. **Fail:** unlimited `/query` accepts 10k req/s until OOM with no metric.

## Retries

These items make sure failed work is retried safely without double side effects.

- [ ] Retry policy documented: which errors retry, max attempts, backoff (exponential + jitter where relevant).
- [ ] Retries are **safe** with idempotency (see below) — no double side effects on replay.
- [ ] Timeouts nest: client ≤ upstream ≤ job deadline.

## Idempotency

**Why:** Retries are guaranteed in integrations—without idempotency, duplicates become double charges, duplicate rows, or duplicate emails.

**Handbook:** [Project 1](../career-project-specs/01-integration-webhook-receiver.md) · [Illustrative snippets](../docs/concepts/illustrative-snippets.md)

These items ensure duplicate requests do not apply the same change twice.

- [ ] Stable idempotency key (header, body field, or business key) for side-effecting operations.
- [ ] Stored outcome or constraint prevents duplicate apply within replay window.
- [ ] Replay behavior documented (same response vs conflict).

**Pass:** second POST with same `Idempotency-Key` returns stored response, one DB row. **Fail:** key logged but not persisted—replay creates duplicate side effect.

## Dead letter queue (DLQ)

**Why:** Poison messages block entire queues without a DLQ—one bad payload should not stop all processing.

**Handbook:** [Project 6](../career-project-specs/06-async-worker-stretch.md) · [Messaging and RPC](../docs/concepts/messaging-and-rpc.md)

These items park poison messages instead of retrying them forever.

- [ ] Poison messages park with evidence (payload hash, error, timestamp) — not infinite retry loops.
- [ ] Replay or abandon path documented; ops can find DLQ depth.
- [ ] DLQ tied to alerting or dashboard hook when in scope for the step.

**Pass:** after N failures message in DLQ with payload ref. **Fail:** infinite retry loop on same poison JSON.

## Metrics

These items give you numbers beyond “it works on my machine.”

- [ ] At least one operational metric beyond “it works” (accepted/rejected, queue depth, p95 latency, error rate).
- [ ] Metric source documented (log grep, Prometheus stub, cloud dashboard) — perfection not required early.
- [ ] Baseline captured for comparison after changes.

## Logs

These items make production debugging possible without reproducing blindly.

- [ ] Structured logs (JSON or key=value); no secrets or full PII in production logs.
- [ ] **request_id** (or trace id) on every request path entry.
- [ ] Error logs include enough context to debug without reproducing blindly.

## Tracing

These items let you follow one request across the services you own.

- [ ] **request_id** propagated across service boundaries you own (header or log field).
- [ ] Optional: OpenTelemetry or vendor trace — required for multi-service steps (8, 11, 13, 16, 22).
- [ ] One documented “follow this id across services” example in lab README.

## Health checks

These items tell deploy tools and load balancers whether your service is ready to receive traffic.

- [ ] Liveness/readiness or `/health` endpoint where the step ships a long-running service.
- [ ] Health check fails fast on missing critical dependencies (database, queue URL).
- [ ] Deploy docs reference health URL for smoke tests.

## Versioning

These items document how APIs and event schemas evolve without breaking consumers.

- [ ] API or event schema versioning story documented (URL prefix, header, or event `version` field).
- [ ] Breaking-change ritual named (OpenAPI diff, consumer notice, deprecation window) — even if “N/A, internal only.”
- [ ] Dependencies pinned (lockfile, image tag, or compose digest) for reproducible deploys.

## Security notes

These items cover secrets, input validation, and what threats you did and did not address.

- [ ] Secrets in environment variables / secret manager only; `.env.example` lists keys, not values.
- [ ] Input validation at boundary; auth on non-public routes when step includes auth.
- [ ] Threat notes in README: what you mitigated and what remains out of scope.

---

## Applicability by step (1–22)

**Legend:** **Req** = required for milestone done · **Opt** = apply if the lab exposes that surface · **N/A** = skip unless you added that surface as stretch · **Logs** = request_id + structured logs sufficient (full tracing optional)

| Step | Rate limits | Retries | Idempotency | DLQ | Metrics | Logs | Tracing | Health | Versioning | Security |
|------|-------------|---------|-------------|-----|---------|------|---------|--------|------------|----------|
| 1 Integration webhook | Opt | Req | Req | Req | Opt | Req | Logs | Opt | Req | Req |
| 2 RAG / LLM | Opt | Req | Opt | Opt | Req | Req | Logs | Req | Req | Req |
| 3 Observability | N/A | N/A | N/A | N/A | Req | Req | Req | Opt | N/A | Opt |
| 4 SQL performance | N/A | N/A | Opt | N/A | Opt | Opt | N/A | N/A | N/A | Opt |
| 5 Contract-first API | Opt | Opt | Opt | Opt | Opt | Req | Logs | Req | Req | Req |
| 6 Async worker | Opt | Req | Req | Req | Req | Req | Logs | Opt | Req | Req |
| 7 Node / TS service | Opt | Req | Req | Opt | Opt | Req | Logs | Req | Req | Req |
| 8 Go retrieval/worker | Opt | Req | Req | Req | Req | Req | Req | Req | Req | Req |
| 9 Application security | Opt | Opt | Opt | Opt | Opt | Req | Logs | Opt | Opt | Req |
| 10 Automation bot | Opt | Req | Req | Opt | Opt | Req | Logs | N/A | Opt | Req |
| 11 LLM web app | Req | Req | Opt | Opt | Req | Req | Req | Req | Opt | Req |
| 12 Multi-tenant auth | Req | Opt | Req | Opt | Opt | Req | Req | Req | Req | Req |
| 13 Real-time dashboard | Opt | Opt | Opt | N/A | Req | Req | Req | Req | Opt | Opt |
| 14 Shell automation | N/A | Opt | Opt | Opt | Opt | Req | Logs | Opt | Opt | Req |
| 15 DevOps CLI | N/A | Opt | Opt | Req | Opt | Req | Logs | N/A | Opt | Opt |
| 16 Cloud deploy | Req | Req | Req | Req | Req | Req | Req | Req | Req | Req |
| 17 K8s controller-lite | Opt | Req | Req | Opt | Req | Req | Req | Req | Opt | Req |
| 18 Proxy / load balancer | Req | Req | Opt | N/A | Req | Req | Req | Req | Opt | Req |
| 19 Rust hot-path | Opt | Req | Req | Opt | Req | Req | Req | Req | Opt | Opt |
| 20 WASM component | Opt | Opt | Opt | N/A | Opt | Req | Logs | Opt | Opt | Req |
| 21 IoT / edge ingest | Opt | Req | Req | Opt | Req | Req | Req | Opt | Opt | Req |
| 22 Integrated capstone | Req | Req | Req | Req | Req | Req | Req | Req | Req | Req |
