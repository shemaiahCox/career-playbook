# Career playbook

Single source of truth for **future-facing engineering themes**, a **phased project ladder**, and a **progress log**. Implementation lives in sibling repos under `dev/`; this repository is the map, not the application code.

**Positioning (12–18 month headline):** Backend / API + integrations engineer who ships reliable, observable services and can add LLM features safely (RAG or tool-using flows with evals and guardrails).

- **Focus and themes:** [FOCUS.md](FOCUS.md)
- **Shipped work and lessons:** [PROGRESS.md](PROGRESS.md)
- **Initiative specs:** [projects/](projects/)
- **Reusable checklists:** [checklists/](checklists/)

## Learning path (suggested)

Phases are **ordered for dependency flow**, not calendar weeks—you can overlap (e.g. observability while building RAG).

| Phase | Projects | Notes |
|-------|----------|--------|
| **1 — Integration spine** | [01](projects/01-integration-webhook-receiver.md) | Hardened webhooks: signatures, idempotency, logs, dead letters. |
| **2 — Applied AI + ops** | [04](projects/04-rag-llm-service.md), [03](projects/03-observability-lab.md) | RAG/evals + structured logging; P3 can piggyback on P4’s FastAPI or another small service. |
| **3 — API contracts** | [02](projects/02-contract-first-api.md) | OpenAPI + consumer/contract discipline; helps every stack you use. |
| **4 — Scale shape** | [05](projects/05-async-worker-stretch.md) | Queues, retries, DLQ; natural extension of P1. |
| **5 — Flexible lane (optional)** | [06](projects/06-node-typescript-lab.md) | **Node + TypeScript:** one repo, track A/B/C—same patterns, broader market signal. |

**Stack reality:** Specs reference **PHP** (P1), **Python** (P4), and **optional Laravel vs FastAPI** (P2). **P6** closes the gap for **Node/TS** without replacing your anchors—see [FOCUS.md](FOCUS.md).

## Quick links to practice repos

| # | Initiative | Local | GitHub |
|---|------------|-------|--------|
| 1 | Integration webhook receiver | [webhook-receiver-lab](../webhook-receiver-lab) | [shemaiahCox/webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab) |
| 4 | RAG / LLM service (FastAPI + eval harness) | [rag-llm-lab](../rag-llm-lab) | [shemaiahCox/rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab) |
| 6 | Node / TypeScript lab (optional) | _TBD_ | _TBD — see [projects/06-node-typescript-lab.md](projects/06-node-typescript-lab.md)_ |

**Clone (SSH):** `git@github.com:shemaiahCox/webhook-receiver-lab.git` · `git@github.com:shemaiahCox/rag-llm-lab.git`

Each project page under [projects/](projects/) expands **key terms** (definitions, problems solved) with snippets from these repos where applicable.
