# Career playbook

Single source of truth for **future-facing engineering themes**, a **phased project ladder**, and a **progress log**. Practice implementations live under [projects/](projects/); this repository is the map, not bundled application code beyond those labs.

**Positioning (12–18 month headline):** Backend / API + integrations engineer who ships reliable, observable services and can add LLM features safely (RAG or tool-using flows with evals and guardrails). The same habits extend toward **systems-style thinking across stacks**—depth in **concepts** and **tradeoffs**, not in memorizing every language.

- **Focus and themes:** [FOCUS.md](FOCUS.md)
- **Shipped work and lessons:** [PROGRESS.md](PROGRESS.md)
- **Initiative specs:** [project-specs/](project-specs/)
- **Reusable checklists:** [checklists/](checklists/)
- **Docs index:** [docs/README.md](docs/README.md) — maps [paths/](docs/paths/), [handbook/](docs/handbook/), and [stacks/](docs/stacks/)
- **Learning journey (dependency path + optional week overlay):** [docs/paths/learning-journey.md](docs/paths/learning-journey.md)
- **Build A in unfamiliar stack B (with AI):** [docs/paths/ai-assisted-unfamiliar-stack.md](docs/paths/ai-assisted-unfamiliar-stack.md) · ship rubric: [checklists/unfamiliar-stack-ship.md](checklists/unfamiliar-stack-ship.md) · **Ecosystem maps:** [docs/stacks/README.md#ecosystem-maps-optional-short](docs/stacks/README.md#ecosystem-maps-optional-short) · **Plain-language index:** [docs/stacks/glossary.md](docs/stacks/glossary.md)

## Using this playbook

### [project-specs/](project-specs/)

Follow the [learning path](#learning-path-suggested) for ordering (dependency flow, not necessarily calendar order). For a **pacing / week overlay** that stays aligned with one active project, see [Learning journey](docs/paths/learning-journey.md). For the **active** spec only:

1. Read **Problem** and **Career relevance** before coding—intent and engineering vocabulary first.
2. Build against **Success criteria** in the linked lab repo (create the repo when the spec still says _TBD_).
3. Use **Key concepts** as a glossary while designing or debugging—not as a linear tutorial.
4. Run **Exploration scenarios** (hands-on cases after **Success criteria** in each spec) to drive failure modes and deepen understanding; paste exact curls/commands in the **lab README** when helpful.
5. Before you call the milestone done, walk the relevant shared checklist (below); optional **Stretch** when you want extra depth.

Skip reading every spec cover-to-cover up front; depth-read the project you are shipping.

### Unfamiliar stack + AI (still accountable)

When you must deliver **product A** in **stack B** you have not shipped before—often with AI drafting code—use the playbook so **concepts** (ownership, threading, leaks, contracts, idempotency) still get applied:

1. Skim [AI-assisted unfamiliar stack](docs/paths/ai-assisted-unfamiliar-stack.md) and name **A**, **B**, and **non-negotiables** before large codegen.
2. Use [term cards](docs/stacks/README.md) for vocabulary; if the tables confuse you first pass, jump to **[Stacks glossary](docs/stacks/glossary.md)** or the **Plain language** section at the bottom of the map you opened. Go deep in the [handbook](docs/handbook/software-engineering.md) when a term is load-bearing.
3. Before calling it done, walk [unfamiliar-stack-ship](checklists/unfamiliar-stack-ship.md) (memory and lifecycle, failure paths, secrets, observability—scoped to what you built).

For long-term polyglot **architecture** literacy (not six parallel syntax courses), see [Systems architect across languages](docs/paths/systems-architect-across-languages.md).

### Checklists and [PROGRESS.md](PROGRESS.md)

Checklists are **definition-of-done rubrics** for integration-shaped work, LLM paths, and **unfamiliar-stack** deliveries—not daily todos. When you are close to shipping, walk them once with code and config open. **[How to use checklists and this log](PROGRESS.md#how-to-use-checklists-and-this-log)** (deadlines, cadence, optional **Tradeoff** / **Failure mode** lines) lives at the top of `PROGRESS.md`.

## Learning path (suggested)

Phases are **ordered for dependency flow**, not calendar weeks—you can overlap (e.g. observability while building RAG).

| Phase | Projects | Notes |
|-------|----------|--------|
| **1 — Integration spine** | [01](project-specs/01-integration-webhook-receiver.md) | Hardened webhooks: signatures, idempotency, logs, dead letters. |
| **2 — Applied AI + ops** | [04](project-specs/04-rag-llm-service.md), [03](project-specs/03-observability-lab.md) | RAG/evals + structured logging; P3 can piggyback on P4’s FastAPI or another small service. |
| **3 — API contracts** | [02](project-specs/02-contract-first-api.md) | OpenAPI + consumer/contract discipline; helps every stack you use. |
| **4 — Scale shape** | [05](project-specs/05-async-worker-stretch.md) | Queues, retries, DLQ; natural extension of P1. |
| **4b — SQL depth (optional)** | [07](project-specs/07-sql-performance-lab.md) | Postgres lab: plans, indexing, transactions, pagination; complements P1/P2/P5. Can run alongside phase 3–4. |
| **5 — Flexible lane (optional)** | [06](project-specs/06-node-typescript-lab.md) | **Node + TypeScript:** one repo, track A/B/C—same patterns, broader market signal. |

**Stack reality:** Specs reference **PHP** (P1), **Python** (P4), and **optional Laravel vs FastAPI** (P2). **P6** closes the gap for **Node/TS** without replacing your anchors—see [FOCUS.md](FOCUS.md).

**SQL and performance:** You still touch SQL in P1, P2, P5, and timings in P3. For a **shipping artifact** and hands-on plan/index literacy you can show from real runs, the optional **[Project 7](project-specs/07-sql-performance-lab.md)** Postgres lab is the dedicated lane—skip it only if your roadmap is already data-limited.

## Architectural narrative

The phased ladder doubles as **systems-thinking** practice: boundaries, failure modes, and tradeoffs—not only feature tutorials.

| Competency | Where you practice it |
|------------|----------------------|
| **Service boundaries** (sync ack vs durable work) | [Project 1](project-specs/01-integration-webhook-receiver.md) thin HTTP path → [Project 5](project-specs/05-async-worker-stretch.md) queue, worker, DLQ |
| **Contracts and evolution** | [Project 2](project-specs/02-contract-first-api.md) OpenAPI, breaking-change discipline |
| **Reliability semantics** | Idempotency, retries, at-least-once, DLQ in P1 and P5; [integration hardening](checklists/integration-hardening.md) |
| **Observability as design** | [Project 3](project-specs/03-observability-lab.md); structured logs and correlation IDs |
| **Security at integration edges** | P1 signatures/secrets; [FOCUS.md](FOCUS.md) theme **#3**; integration checklist |
| **Data shape under load** | [Project 7](project-specs/07-sql-performance-lab.md) plans, indexes, transactions, pagination |
| **AI product boundaries** | [Project 4](project-specs/04-rag-llm-service.md); [LLM feature ship](checklists/llm-feature-ship.md) |
| **Unfamiliar stack + AI** | [AI-assisted unfamiliar stack](docs/paths/ai-assisted-unfamiliar-stack.md); [unfamiliar-stack ship](checklists/unfamiliar-stack-ship.md) |

**Habits:** Treat each spec as a *design brief*—especially **Career relevance**, **Real-world situations**, and **Key concepts**. After each shipped milestone, log **one explicit tradeoff** (what you rejected and why) and **one production failure mode** you guarded against in [PROGRESS.md](PROGRESS.md). Before calling integration or LLM work done, walk the checklists above. Optional: in each lab repo README, add one diagram plus three bullets—components, data flow, failure modes.

## Quick links to practice repos

| # | Initiative | Local | GitHub |
|---|------------|-------|--------|
| 1 | Integration webhook receiver | [webhook-receiver-lab](projects/webhook-receiver-lab) | [shemaiahCox/webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab) |
| 2 | Contract-first API | _TBD_ | _TBD — see [project-specs/02-contract-first-api.md](project-specs/02-contract-first-api.md)_ |
| 4 | RAG / LLM service (FastAPI + eval harness) | [rag-llm-lab](projects/rag-llm-lab) | [shemaiahCox/rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab) |
| 5 | Async worker (stretch) | _TBD_ | _Often extends P1/P6 — see [project-specs/05-async-worker-stretch.md](project-specs/05-async-worker-stretch.md)_ |
| 6 | Node / TypeScript lab (optional) | _TBD_ | _TBD — see [project-specs/06-node-typescript-lab.md](project-specs/06-node-typescript-lab.md)_ |
| 7 | SQL performance / correctness lab | [sql-perf-lab](projects/sql-perf-lab) | [shemaiahCox/sql-perf-lab](https://github.com/shemaiahCox/sql-perf-lab) |

**Clone (SSH):** `git@github.com:shemaiahCox/webhook-receiver-lab.git` · `git@github.com:shemaiahCox/rag-llm-lab.git` · `git@github.com:shemaiahCox/sql-perf-lab.git`

Each spec under [project-specs/](project-specs/) expands **key terms** (definitions, problems solved) with snippets from these repos where applicable. When you create a new practice repo for P2/P5/P6, add links here and SSH clone hints as needed.
