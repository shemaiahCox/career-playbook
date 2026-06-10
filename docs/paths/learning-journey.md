# Learning journey (easy to follow)

Two views of the same playbook: **dependency order** (what to learn first) and an **optional calendar overlay**. Study load-bearing handbook sections—do not skim—especially [Algorithms study path](algorithms-study-path.md) during P7, P9, and RAG retrieval work.

**Companion:** [README — Learning path](../../README.md#learning-path-suggested) · [Systems integration architect](systems-integration-architect.md) · [AI-assisted unfamiliar stack](ai-assisted-unfamiliar-stack.md)

**Core stack:** JavaScript · TypeScript · PHP · SQL · Go · Python · Rust (Tier‑2) — [FOCUS.md](../../FOCUS.md). **Python + Go** = long-term growth lanes; **Rust** after P9 Go; **PHP, TypeScript, SQL** = ship-today ingress and data — [Growth lanes vs ship today](../../FOCUS.md#growth-lanes-vs-ship-today).

---

## AI, automation, and cloud — quick map

If your goal is **AI features + integration/automation + cloud-shaped ops**, use this table first—then follow **View A** below for order.

| Theme | What you are proving | Primary specs | Stack lane |
|-------|----------------------|---------------|------------|
| **AI (product)** | Grounded RAG, evals, citations, guardrails | [P4](../career-project-specs/04-rag-llm-service.md), [P3](../career-project-specs/03-observability-lab.md) | **Python** |
| **Automation** | Fast ack, idempotent steps, queues, DLQ (Boomi/n8n mental model) | [P1](../career-project-specs/01-integration-webhook-receiver.md), [P5](../career-project-specs/05-async-worker-stretch.md), [integration-automation](../stacks/integration-automation.md) | **PHP** or **TypeScript** ingress |
| **Throughput / scale** | Workers, retrieval fan-out, bounded concurrency | [P9](../career-project-specs/09-go-retrieval-worker-lab.md) (with P5) | **Go** (Rust Tier‑2 after P9 — [below](#rust-tier-2-after-p9-go)) |
| **Data / vectors** | Correct indexes, plans, chunk storage | [P7](../career-project-specs/07-sql-performance-lab.md) | **SQL** (Postgres) |
| **Cloud (practice)** | Containers, durable queues, optional single deploy | P7 Docker Compose; P5/P6/P9 queue + `docker compose` in lab README | Ops discipline—not a separate cert track |

**Who owns what (avoid duplicate repos):**

| Job | Owner | Not this |
|-----|--------|----------|
| LLM calls, eval JSONL, prompt boundaries | **Python (P4)** | A second “AI bot” repo in Go |
| Webhooks, partner HTTP, n8n nodes | **PHP (P1)** or **TS (P6)** | Rebuilding the same ingress in Go first |
| Queue drain, ingest jobs, `/retrieve` fan-out | **Go (P5/P9)** | Full REST monolith in Go; **Rust worker spine in parallel with unfinished P9** |
| Hot-path reimplementation (optional) | **Rust (Tier‑2)** after P9 Go green | Rust before any Go P9 artifact |
| Embeddings storage, vector indexes | **SQL (P7)** | Operating a separate vector DB product on day one |

**Start retrieval in Python (P4).** Move hot-path retrieval to **Go (P9)** only when profiling shows I/O concurrency is the bottleneck—see [P4 architecture split](../career-project-specs/04-rag-llm-service.md#architecture-split-python--go).

### Integrated capstone (one system, not five Go repos)

After P4 has a minimal `/query` + eval path and P9 core is green, wire **one** story (diagram in P9 README; contract in OpenAPI):

1. **Ingress** — P1 or P6 track C: webhook validates → enqueue.
2. **Durable work** — P5/P9 Go worker: ingest/normalize documents (optional stretch).
3. **Data** — P7 Postgres: chunks/embeddings; plans under load.
4. **AI path** — P4 calls P9 `POST /retrieve` → LLM + citations.
5. **Optional** — Event bus or WebSocket notify (P9 stretch) for “ingest complete.”

Log one ADR in [PROGRESS.md](../../PROGRESS.md) (e.g. Python-only retrieval vs Go gateway). Full architecture lens: [Systems integration architect](systems-integration-architect.md).

**Out of scope this year:** Full IoT/robotics/embedded curriculum; Milvus/Weaviate operator tracks; cloning Boomi/n8n; deep ML training; **Rust as a second active worker spine** — [FOCUS non-goals](../../FOCUS.md#non-goals-this-year).

### Rust Tier‑2 (after P9 Go)

**When:** After [P9](../career-project-specs/09-go-retrieval-worker-lab.md) success criteria are green—not in parallel as a second spine.

| Step | Action |
|------|--------|
| 1 | Optional anytime: [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/README.md) for ownership, `Result`, Cargo |
| 2 | Read [Rust ecosystem map](../stacks/rust.md) — when Rust vs Go vs Python |
| 3 | **P9 stretch:** reimplement retrieval gateway or worker in Rust; **same** HTTP/queue contract as Go |
| 4 | Log ADR in [PROGRESS.md](../../PROGRESS.md): Go vs Rust for this boundary (latency, ops, team, safety) |
| 5 | Optional IoT/edge stretch: MQTT ingest side demo—tie to one load-bearing property only |

**LinkedIn alignment:** AI Systems · Cloud · Automation · **Go · Python · Rust · TypeScript · SQL · PHP** — playbook spine matches; Rust is depth after Go, not breadth on day one.

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
| 4d | Rust Tier‑2 (optional) | [P9 stretch](../career-project-specs/09-go-retrieval-worker-lab.md#stretch), [rust map](../stacks/rust.md) | After P9 Go green: sandbox + optional reimplementation |

---

## View B — Example calendar overlay (illustrative)

**Assumption:** ~6–10 focused hours/week.

| Notional weeks | Spine focus | Example primary action |
|----------------|-------------|-------------------------|
| **1–2** | Phase 1 (P1) | Ship webhook success criteria; run exploration scenarios |
| **3–5** | Phase 2 (P4 + P3) | RAG slice + structured logging on same service |
| **6–7** | Phase 3 (P2) | Contract-first API milestone |
| **7–8** | Go prep (sandbox) | [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/README.md) — CLI/HTTP only, not a lab milestone |
| **8–10** | Phase 4 (P5 + P9) | Queue + Go worker/retrieval; optional [integrated capstone](#integrated-capstone-one-system-not-five-go-repos) wiring |
| **11–12** | Phase 5 (P6) | Node/TS service with same integration habits |
| **13+** | Rust Tier‑2 (optional) | [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/README.md) → P9 Rust stretch after Go core green |
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
| Rust (Tier‑2, after P9) | [rust](../stacks/rust.md) |
| Node + TS (P6) | [node-typescript-backend](../stacks/node-typescript-backend.md) |
| SQL / Postgres (P7) | [sql](../stacks/sql.md) |
| Boomi / n8n patterns | [integration-automation](../stacks/integration-automation.md) |

### Sandboxes (syntax only)

| Sandbox | When |
|---------|------|
| [laravel-route-slice](../../exploration-projects/laravel-route-slice/) | Before/during P1 |
| [node-ts-http-probe](../../exploration-projects/node-ts-http-probe/) | Before/during P6 |
| [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/) | Before/during P9 |
| [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/) | Before P9 (syntax) or after P9 Go (Tier‑2 stretch prep) |

---

## Related

- [README](../../README.md) — Architectural narrative, quick links
- [Systems integration architect](systems-integration-architect.md)
- [Algorithms study path](algorithms-study-path.md)
