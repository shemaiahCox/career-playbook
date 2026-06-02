# Learning journey (easy to follow)

Two views of the same playbook: **dependency order** (what to learn first) and an **optional calendar overlay**. Study load-bearing handbook sections—do not skim—especially [Algorithms study path](algorithms-study-path.md) during P7, P9, and RAG retrieval work.

**Companion:** [README — Learning path](../../README.md#learning-path-suggested) · [Systems integration architect](systems-integration-architect.md) · [AI-assisted unfamiliar stack](ai-assisted-unfamiliar-stack.md)

**Core stack:** JavaScript · TypeScript · PHP · SQL · Go · Python — [FOCUS.md](../../FOCUS.md). **Python + Go** = long-term growth lanes; **PHP, TypeScript, SQL** = ship-today ingress and data — [Growth lanes vs ship today](../../FOCUS.md#growth-lanes-vs-ship-today).

---

## Rules of thumb

1. **One active project** — Pick **one** spec as spine. Depth beats parallel half-finished labs.
2. **Concepts on demand** — Use **Key concepts** in the active spec and [stack maps](../stacks/README.md). Open [software engineering](../handbook/software-engineering.md) for **paragraphs** when a term is load-bearing.
3. **Study, don’t skim** — For integration, concurrency, security, and Big-O, follow the paths linked in the phase table below.
4. **Overlap is OK** — Phases can run in parallel calendar time; the table is **dependency** order.

---

## View A — Dependency path (spine)

| Order | Phase theme | Specs | What you are practicing |
|-------|-------------|-------|-------------------------|
| 1 | Integration spine | [P1 — Webhook](../career-project-specs/01-integration-webhook-receiver.md) | Signatures, idempotency, Boomi-style fast ack, dead letters |
| 2 | Applied AI + ops | [P4 — RAG](../career-project-specs/04-rag-llm-service.md), [P3 — Observability](../career-project-specs/03-observability-lab.md) | Python LLM boundary, evals, structured logs |
| 3 | API contracts | [P2 — Contract-first API](../career-project-specs/02-contract-first-api.md) | OpenAPI, breaking-change discipline |
| 4 | Event-driven scale | [P5 — Async worker](../career-project-specs/05-async-worker-stretch.md), [P9 — Go lab](../career-project-specs/09-go-retrieval-worker-lab.md) | Queues, DLQ, Go workers + retrieval gateway |
| 5 | TypeScript API | [P6 — Node / TS](../career-project-specs/06-node-typescript-lab.md) | Core stack HTTP service, optional n8n node stretch |
| 4b | SQL depth | [P7 — SQL performance](../career-project-specs/07-sql-performance-lab.md) | Plans, indexes, transactions, vector-adjacent retrieval |
| 4c | Security | [P8 — Application security](../career-project-specs/08-application-security-lab.md) | OWASP + integration-edge security |

---

## View B — Example calendar overlay (illustrative)

**Assumption:** ~6–10 focused hours/week.

| Notional weeks | Spine focus | Example primary action |
|----------------|-------------|-------------------------|
| **1–2** | Phase 1 (P1) | Ship webhook success criteria; run exploration scenarios |
| **3–5** | Phase 2 (P4 + P3) | RAG slice + structured logging on same service |
| **6–7** | Phase 3 (P2) | Contract-first API milestone |
| **8–10** | Phase 4 (P5 + P9) | Queue + Go worker/retrieval; idempotency under duplicate delivery |
| **11–12** | Phase 5 (P6) | Node/TS service with same integration habits |
| **Parallel** | P7 | Algorithms study path + Postgres exercises |
| **Parallel** | P8 | OWASP lab after or alongside P2/P6 |

Log tradeoffs in [PROGRESS.md](../../PROGRESS.md).

---

## Phase → reference study (build-aligned)

### [Software engineering breadth](../handbook/software-engineering.md)

| While you are in… | Study these sections |
|---------------------|----------------------|
| **P1** Webhook | [Integration](../handbook/software-engineering.md#integration-sync-async-and-messaging) · [Event-driven integration](../handbook/software-engineering.md#event-driven-integration) · [Security](../handbook/software-engineering.md#security-for-applications) |
| **P4** RAG + **P3** Observability | [Observability](../handbook/software-engineering.md#observability-logs-metrics-traces) · [Testing](../handbook/software-engineering.md#testing) · [Algorithms study path](algorithms-study-path.md) (retrieval hot paths) |
| **P2** Contract API | [REST](../handbook/software-engineering.md#rest) · [Versioning](../handbook/software-engineering.md#versioning-and-compatibility) |
| **P5** + **P9** Workers | [Integration](../handbook/software-engineering.md#integration-sync-async-and-messaging) · [Concurrency](../handbook/software-engineering.md#concurrency-basics) · [Algorithms study path](algorithms-study-path.md) |
| **P6** Node / TS | [REST](../handbook/software-engineering.md#rest) · [Language fundamentals](../handbook/language-fundamentals-comparison.md) |
| **P8** Security | [Security](../handbook/software-engineering.md#security-for-applications) |

### Ecosystem maps (core stack)

| Stack | Map |
|-------|-----|
| PHP / Laravel (P1/P2) | [php-laravel](../stacks/php-laravel.md) |
| Python / FastAPI (P4) | [python](../stacks/python.md) |
| Go (P9, P5 worker) | [go](../stacks/go.md) |
| Node + TS (P6) | [node-typescript-backend](../stacks/node-typescript-backend.md) |
| SQL / Postgres (P7) | [sql](../stacks/sql.md) |
| Boomi / n8n patterns | [integration-automation](../stacks/integration-automation.md) |

### Sandboxes (syntax only)

| Sandbox | When |
|---------|------|
| [laravel-route-slice](../../exploration-projects/laravel-route-slice/) | Before/during P1 |
| [node-ts-http-probe](../../exploration-projects/node-ts-http-probe/) | Before/during P6 |
| [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/) | Before/during P9 |

---

## Related

- [README](../../README.md) — Architectural narrative, quick links
- [Systems integration architect](systems-integration-architect.md)
- [Algorithms study path](algorithms-study-path.md)
