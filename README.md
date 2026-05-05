# Career playbook

Single source of truth for **future-facing engineering themes**, a **phased project ladder**, and a **progress log**. Practice implementations live under [projects/](projects/); this repository is the map, not bundled application code beyond those labs.

**Positioning (12–18 month headline):** Backend / API + integrations engineer who ships reliable, observable services and can add LLM features safely (RAG or tool-using flows with evals and guardrails).

- **Focus and themes:** [FOCUS.md](FOCUS.md)
- **Shipped work and lessons:** [PROGRESS.md](PROGRESS.md)
- **Initiative specs:** [project-specs/](project-specs/)
- **Reusable checklists:** [checklists/](checklists/)

## Learning path (suggested)

Phases are **ordered for dependency flow**, not calendar weeks—you can overlap (e.g. observability while building RAG).

| Phase | Projects | Notes |
|-------|----------|--------|
| **1 — Integration spine** | [01](project-specs/01-integration-webhook-receiver.md) | Hardened webhooks: signatures, idempotency, logs, dead letters. |
| **2 — Applied AI + ops** | [04](project-specs/04-rag-llm-service.md), [03](project-specs/03-observability-lab.md) | RAG/evals + structured logging; P3 can piggyback on P4’s FastAPI or another small service. |
| **3 — API contracts** | [02](project-specs/02-contract-first-api.md) | OpenAPI + consumer/contract discipline; helps every stack you use. |
| **4 — Scale shape** | [05](project-specs/05-async-worker-stretch.md) | Queues, retries, DLQ; natural extension of P1. |
| **5 — Flexible lane (optional)** | [06](project-specs/06-node-typescript-lab.md) | **Node + TypeScript:** one repo, track A/B/C—same patterns, broader market signal. |

**Stack reality:** Specs reference **PHP** (P1), **Python** (P4), and **optional Laravel vs FastAPI** (P2). **P6** closes the gap for **Node/TS** without replacing your anchors—see [FOCUS.md](FOCUS.md).

**SQL and performance:** Relational depth (transactions, indexes, `EXPLAIN`, N+1 awareness) is **practiced inside** P1, P2, and P5 implementations plus observability timings in P3—no separate SQL-only initiative required unless you are targeting data-heavy interviews.

## Quick links to practice repos

| # | Initiative | Local | GitHub |
|---|------------|-------|--------|
| 1 | Integration webhook receiver | [webhook-receiver-lab](projects/webhook-receiver-lab) | [shemaiahCox/webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab) |
| 2 | Contract-first API | _TBD_ | _TBD — see [project-specs/02-contract-first-api.md](project-specs/02-contract-first-api.md)_ |
| 4 | RAG / LLM service (FastAPI + eval harness) | [rag-llm-lab](projects/rag-llm-lab) | [shemaiahCox/rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab) |
| 5 | Async worker (stretch) | _TBD_ | _Often extends P1/P6 — see [project-specs/05-async-worker-stretch.md](project-specs/05-async-worker-stretch.md)_ |
| 6 | Node / TypeScript lab (optional) | _TBD_ | _TBD — see [project-specs/06-node-typescript-lab.md](project-specs/06-node-typescript-lab.md)_ |

**Clone (SSH):** `git@github.com:shemaiahCox/webhook-receiver-lab.git` · `git@github.com:shemaiahCox/rag-llm-lab.git`

Each spec under [project-specs/](project-specs/) expands **key terms** (definitions, problems solved) with snippets from these repos where applicable. When you create a new practice repo for P2/P5/P6, add links here and SSH clone hints as needed.
