# Learning journey (easy to follow)

This guide gives **two views** of the same playbook: **dependency order** (what to learn *first* for systems thinking) and an **optional calendar overlay** (how to pace yourself). It does **not** require you to read [Software engineering breadth](../reference/software-engineering.md) cover-to-cover before building, or to ship a production app in **every** ecosystem each week.

**Companion:** [README — Learning path](../../README.md#learning-path-suggested) · [systems architect across languages](systems-architect-across-languages.md) · [AI-assisted unfamiliar stack](ai-assisted-unfamiliar-stack.md)

---

## Rules of thumb

1. **One active project** — Pick **one** initiative spec ([project-specs/](../../project-specs/)) as the spine. Depth beats parallel half-finished labs.
2. **Concepts on demand** — Use **Key concepts** in the active spec and [term cards](../concepts/README.md). Open [software engineering](../reference/software-engineering.md) for definitions when a term is **load-bearing** (idempotency, isolation, etc.).
3. **Overlap is OK** — Phases can run in parallel calendar time (e.g. observability while building RAG); the table below is **dependency** order, not a ban on overlap.
4. **Code examples** — Prefer **specs + lab repos** + reference **TOC sections** (see mapping below), not a second linear syllabus.

---

## View A — Dependency path (spine)

Ship and study in this **idea** order (aligned with [README Learning path](../../README.md#learning-path-suggested)):

| Order | Phase theme | Specs | What you are practicing |
|-------|-------------|-------|-------------------------|
| 1 | Integration spine | [P1 — Webhook receiver](../../project-specs/01-integration-webhook-receiver.md) | Signatures, idempotency, thin HTTP path, dead letters |
| 2 | Applied AI + ops | [P4 — RAG / LLM](../../project-specs/04-rag-llm-service.md), [P3 — Observability](../../project-specs/03-observability-lab.md) | Model boundaries, evals mindset, structured logs, correlation |
| 3 | API contracts | [P2 — Contract-first API](../../project-specs/02-contract-first-api.md) | OpenAPI, breaking-change discipline |
| 4 | Scale shape | [P5 — Async worker](../../project-specs/05-async-worker-stretch.md) | Queues, retries, DLQ, durable work |
| 4b (optional) | SQL depth | [P7 — SQL performance](../../project-specs/07-sql-performance-lab.md) | Plans, indexes, transactions, pagination |
| 5 (optional) | Flexible lane | [P6 — Node / TypeScript](../../project-specs/06-node-typescript-lab.md) | Same reliability patterns, broader market signal |

**Stacks in this repo’s specs:** PHP (P1), Python (P4), optional Laravel vs FastAPI (P2), optional Node/TS (P6). You are **not** required to complete a separate “build” in Swift, Kotlin, C#, etc.—use [ecosystem maps](../concepts/ecosystems/README.md) when that stack becomes **real** work.

---

## View B — Example calendar overlay (illustrative)

**Not prescriptive.** Adjust hours and weeks to your life. Treat each **week** as having **one primary outcome** (not three projects at once).

**Assumption:** ~6–10 focused hours/week on the playbook (reading + coding + checklists).

| Notional weeks | Spine focus | Example primary action |
|----------------|-------------|-------------------------|
| **1–2** | Phase 1 (P1) | Ship or extend webhook lab success criteria; run **Exploration scenarios** in the spec |
| **3–5** | Phase 2 (P4 + P3) | Run RAG service slice + add structured logging / trace IDs on the same or adjacent service |
| **6–7** | Phase 3 (P2) | Contract-first API milestone; consumer-smoke path |
| **8–9** | Phase 4 (P5) | Worker + queue + retry/DLQ story (often extends P1 or P6) |
| **Parallel optional** | P7 | Run Postgres lab exercises alongside phase 3–4 if data depth is a gap |
| **When ready** | P6 | One small Node/TS service if breadth matters for your market |

**Weekly recipe (pick one emphasis per week):**

- **Ship** a slice of the **active** spec’s **Success criteria**, *or*
- **Walk** one [checklist](../../checklists/) (integration, LLM, or [unfamiliar-stack](../../checklists/unfamiliar-stack-ship.md) if AI + new stack), *or*
- **Skim** one [ecosystem map](../concepts/ecosystems/README.md) (30–45 min) for the stack you are **actually** using that week.

Log tradeoffs and failure modes in [PROGRESS.md](../../PROGRESS.md) when something ships.

---

## Phase → reference skim (build-aligned)

Use this when you want **reading tied to the lab you are in**, not abstract linear study.

### [Software engineering breadth](../reference/software-engineering.md)

| While you are in… | Skim these sections (anchors) |
|---------------------|-------------------------------|
| **P1** Webhook | [Integration: sync, async, and messaging](../reference/software-engineering.md#integration-sync-async-and-messaging) · [GraphQL, gRPC, and webhooks](../reference/software-engineering.md#graphql-grpc-and-webhooks) · [REST](../reference/software-engineering.md#rest) · [Security for applications](../reference/software-engineering.md#security-for-applications) |
| **P4** RAG + **P3** Observability | [Observability: logs, metrics, traces](../reference/software-engineering.md#observability-logs-metrics-traces) · [Security for applications](../reference/software-engineering.md#security-for-applications) · [Testing](../reference/software-engineering.md#testing) |
| **P2** Contract API | [REST](../reference/software-engineering.md#rest) · [Versioning and compatibility](../reference/software-engineering.md#versioning-and-compatibility) · [Testing](../reference/software-engineering.md#testing) |
| **P5** Async worker | [Integration: sync, async, and messaging](../reference/software-engineering.md#integration-sync-async-and-messaging) · [Concurrency basics](../reference/software-engineering.md#concurrency-basics) |
| **P6** Node / TypeScript | [REST](../reference/software-engineering.md#rest) · [Cross-language concepts and gotchas](../reference/software-engineering.md#cross-language-concepts-and-gotchas) |

### [Database design](../reference/database-design.md)

| While you are in… | Skim these sections |
|---------------------|---------------------|
| **P7** SQL lab | [Indexes](../reference/database-design.md#indexes) · [Transactions and ACID](../reference/database-design.md#transactions-and-acid) · [Migrations](../reference/database-design.md#migrations) |
| **P4** (RAG / embeddings) | [Vector databases and embeddings](../reference/database-design.md#vector-databases-and-embeddings) *(when retrieval is in scope)* |

### Ecosystem maps (orientation, not required each week)

| Stack you are touching | Map |
|------------------------|-----|
| PHP / Laravel (typical P1/P2) | [php-laravel](../concepts/ecosystems/php-laravel.md) |
| Python / FastAPI (P4) | [python](../concepts/ecosystems/python.md) |
| SQL / Postgres (P7) | [sql](../concepts/ecosystems/sql.md) |
| Node / Next (P6) | [nextjs-react-typescript](../concepts/ecosystems/nextjs-react-typescript.md) |
| Something else unfamiliar + AI | [AI-assisted unfamiliar stack](ai-assisted-unfamiliar-stack.md) → [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) |

---

## Optional appendix — breadth rotation (not the default path)

If you want **extra** polyglot exposure without derailing the spine:

- Pick **one** stack per **quarter** that is **not** your primary lab (e.g. read [swift-ios](../concepts/ecosystems/swift-ios.md), ship a toy or read a real OSS repo).
- Use AI for velocity; still walk [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) if anything ships beyond a throwaway.

This is **consciously optional** and does **not** replace P1–P7 for your integration/API/AI narrative.

---

## Related

- [README](../../README.md) — Architectural narrative, learning path table, quick links to practice repos
- [systems architect across languages](systems-architect-across-languages.md) — depth order for design literacy across stacks
