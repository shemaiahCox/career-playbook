# Learning journey (easy to follow)

This guide gives **two views** of the same playbook: **dependency order** (what to learn *first* for systems thinking) and an **optional calendar overlay** (how to pace yourself). It does **not** require you to read [Software engineering breadth](../handbook/software-engineering.md) cover-to-cover before building, or to ship a production app in **every** ecosystem each week.

**Companion:** [README — Learning path](../../README.md#learning-path-suggested) · [systems architect across languages](systems-architect-across-languages.md) · [AI-assisted unfamiliar stack](ai-assisted-unfamiliar-stack.md)

---

## Rules of thumb

1. **One active project** — Pick **one** initiative spec ([project-specs/](../../project-specs/)) as the spine. Depth beats parallel half-finished labs.
2. **Concepts on demand** — Use **Key concepts** in the active spec and [term cards](../stacks/README.md); if jargon overwhelms you, open the **[Stacks glossary](../stacks/glossary.md)** or scroll to **Plain language: terms used on this page** in the stack note. Open [software engineering](../handbook/software-engineering.md) for paragraphs when a term is **load-bearing** (idempotency, isolation, etc.).
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
| 4c (optional) | Cybersecurity / OWASP (web) | [P8 — Application security](../../project-specs/08-application-security-lab.md) | SQLi, XSS, auth/sessions, forms/CSRF; shipping-engineer literacy |
| 5 (optional) | Flexible lane | [P6 — Node / TypeScript](../../project-specs/06-node-typescript-lab.md) | Same reliability patterns, broader market signal |

**Stacks in this repo’s specs:** PHP (P1), Python (P4) with orchestration/retrieval behind FastAPI, optional Laravel vs FastAPI (P2), optional Node/TS (P6). TS-heavy API shops often sit beside Python LLM services—**P6** is optional parity, not a replacement spine. **Exploration maps** (no dedicated spec) include **Java/JVM**, **[Node + TypeScript API](../stacks/node-typescript-backend.md)**, and **[Next.js + React](../stacks/nextjs-react-typescript.md)** (full-stack—optional breadth)—see the [ecosystem maps](#ecosystem-maps-orientation-not-required-each-week) table below. You are **not** required to complete a separate “build” in Swift, Kotlin, C#, etc.—use [ecosystem maps](../stacks/README.md#ecosystem-maps-optional-short) when that stack becomes **real** work.

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
| **Parallel optional** | P8 | OWASP web lab (forms + DB + sessions) after or alongside P2/P6/P7—see spec for stack options |
| **When ready** | P6 | One small Node/TS service if breadth matters for your market |

**Weekly recipe (pick one emphasis per week):**

- **Ship** a slice of the **active** spec’s **Success criteria**, *or*
- **Walk** one [checklist](../../checklists/) (integration, LLM, [application-security-web-owasp](../../checklists/application-security-web-owasp.md) for P8, or [unfamiliar-stack](../../checklists/unfamiliar-stack-ship.md) if AI + new stack), *or*
- **Skim** one [ecosystem map](../stacks/README.md#ecosystem-maps-optional-short) (30–45 min) for the stack you are **actually** using that week.

Log tradeoffs and failure modes in [PROGRESS.md](../../PROGRESS.md) when something ships.

---

## Phase → reference skim (build-aligned)

Use this when you want **reading tied to the lab you are in**, not abstract linear study.

### [Software engineering breadth](../handbook/software-engineering.md)

| While you are in… | Skim these sections (anchors) |
|---------------------|-------------------------------|
| **P1** Webhook | [Integration: sync, async, and messaging](../handbook/software-engineering.md#integration-sync-async-and-messaging) · [GraphQL, gRPC, and webhooks](../handbook/software-engineering.md#graphql-grpc-and-webhooks) · [REST](../handbook/software-engineering.md#rest) · [Security for applications](../handbook/software-engineering.md#security-for-applications) |
| **P4** RAG + **P3** Observability | [Observability: logs, metrics, traces](../handbook/software-engineering.md#observability-logs-metrics-traces) · [Debugging (workflow)](../handbook/software-engineering.md#debugging-workflow) · [Testing](../handbook/software-engineering.md#testing) · [Security for applications](../handbook/software-engineering.md#security-for-applications) |
| **P2** Contract API | [REST](../handbook/software-engineering.md#rest) · [Versioning and compatibility](../handbook/software-engineering.md#versioning-and-compatibility) · [Testing](../handbook/software-engineering.md#testing) |
| **P5** Async worker | [Integration: sync, async, and messaging](../handbook/software-engineering.md#integration-sync-async-and-messaging) · [Concurrency basics](../handbook/software-engineering.md#concurrency-basics) |
| **P6** Node / TypeScript | [REST](../handbook/software-engineering.md#rest) · [Cross-language concepts and gotchas](../handbook/software-engineering.md#cross-language-concepts-and-gotchas) |
| **P8** Application security / OWASP | [Security for applications](../handbook/software-engineering.md#security-for-applications) · [Testing](../handbook/software-engineering.md#testing) |

### [Database design](../handbook/database-design.md)

| While you are in… | Skim these sections |
|---------------------|---------------------|
| **P7** SQL lab | [Indexes](../handbook/database-design.md#indexes) · [Transactions and ACID](../handbook/database-design.md#transactions-and-acid) · [Migrations](../handbook/database-design.md#migrations) |
| **P8** OWASP lab (SQLi thread) | [Indexes](../handbook/database-design.md#indexes) · [ORMs and the N+1 query pattern](../handbook/database-design.md#orms-and-the-n1-query-pattern) *(tie unsafe query habits to application code)* |
| **P4** (RAG / embeddings) | [Vector databases and embeddings](../handbook/database-design.md#vector-databases-and-embeddings) *(when retrieval is in scope)* |

### Ecosystem maps (orientation, not required each week)

| Stack you are touching | Map |
|------------------------|-----|
| PHP / Laravel (typical P1/P2) | [php-laravel](../stacks/php-laravel.md) |
| Python / FastAPI (P4) | [python](../stacks/python.md) |
| SQL / Postgres (P7) | [sql](../stacks/sql.md) |
| Node + TypeScript **API only** (Express/Fastify, P6) | [node-typescript-backend](../stacks/node-typescript-backend.md) |
| Next.js + React (full-stack web) | [nextjs-react-typescript](../stacks/nextjs-react-typescript.md) |
| Java / JVM (Spring-shaped exploration) | [java-jvm](../stacks/java-jvm.md) |
| Something else unfamiliar + AI | [AI-assisted unfamiliar stack](ai-assisted-unfamiliar-stack.md) → [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) |

---

## Optional appendix — breadth rotation (not the default path)

If you want **extra** polyglot exposure without derailing the spine:

- Pick **one** stack per **quarter** that is **not** your primary lab (e.g. read [swift-ios](../stacks/swift-ios.md), ship a toy or read a real OSS repo).
- Use AI for velocity; still walk [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) if anything ships beyond a throwaway.

This is **consciously optional** and does **not** replace the default spine (P1→P4/P3→P2→P5) or optional labs P6–P8 for your integration/API/AI narrative.

---

## Related

- [README](../../README.md) — Architectural narrative, learning path table, quick links to practice repos
- [systems architect across languages](systems-architect-across-languages.md) — depth order for design literacy across stacks
