# Career playbook

Single source of truth for **future-facing engineering themes**, a **phased project ladder**, and a **progress log**. **Practice lab workspaces** (**webhook**, **RAG**, **SQL**, …) live under [`career-projects/`](career-projects/README.md) in this repo (each is normally its **own nested git checkout**). Small **language sandboxes** stay in [`exploration-projects/`](exploration-projects/README.md). **[Initiative specs](career-project-specs/)** live in **`career-project-specs/`** (`project-specs/` is deprecated—see stub). Separate **commercial / app** repos can live beside this repo under **`~/Documents/dev/business-projects/`** (PacPal-shaped work, etc.—not required for playbook labs).

**Naming:** Older docs may say **`projects/`**; that folder name is now **`career-projects/`**.

**Positioning (12–18 month headline):** Integrations + automation backend engineer who ships **reliable, observable, event-driven** services—**Boomi/n8n-shaped** patterns, **RAG/LLM** boundaries in Python, **performance-critical** workers and retrieval in **Go**, optional **Rust** hot-path depth after P9, APIs in **PHP/TypeScript**, data correctness in **SQL**.

**Core stack:** JavaScript · TypeScript · PHP · SQL · Go · Python · Rust — see [FOCUS.md](FOCUS.md). **Growth lanes:** Python (AI logic) + Go (throughput/workers); **Rust Tier‑2** after P9 Go; **ship today:** PHP, TypeScript, SQL at integration and data edges — [Growth lanes vs ship today](FOCUS.md#growth-lanes-vs-ship-today).

- **Focus and themes:** [FOCUS.md](FOCUS.md)
- **Shipped work and lessons:** [PROGRESS.md](PROGRESS.md)
- **Initiative specs:** [career-project-specs/](career-project-specs/)
- **Reusable checklists:** [checklists/](checklists/)
- **Docs index:** [docs/README.md](docs/README.md) — maps [paths/](docs/paths/), [handbook/](docs/handbook/), [stacks/](docs/stacks/), [playbook/](docs/playbook/) (per-lab testing + AI prompts) · **SE terms (A–Z):** [Software engineering glossary](docs/handbook/software-engineering-glossary.md)
- **Learning journey (dependency path + optional week overlay):** [docs/paths/learning-journey.md](docs/paths/learning-journey.md) — start with [AI + automation + cloud quick map](docs/paths/learning-journey.md#ai-automation-and-cloud--quick-map) if that is your focus
- **Build A in unfamiliar stack B (with AI):** [docs/paths/ai-assisted-unfamiliar-stack.md](docs/paths/ai-assisted-unfamiliar-stack.md) · ship rubric: [checklists/unfamiliar-stack-ship.md](checklists/unfamiliar-stack-ship.md) · **Ecosystem maps:** [docs/stacks/README.md#ecosystem-maps-optional-short](docs/stacks/README.md#ecosystem-maps-optional-short) · **Plain-language index:** [docs/stacks/glossary.md](docs/stacks/glossary.md)

## Using this playbook

### [career-project-specs/](career-project-specs/)

Follow the [learning path](#learning-path-suggested) for ordering (dependency flow, not necessarily calendar order). For a **pacing / week overlay** that stays aligned with one active project, see [Learning journey](docs/paths/learning-journey.md). For the **active** spec only:

1. Read **Problem** and **Career relevance** before coding—intent and engineering vocabulary first.
2. Build against **Success criteria** in the linked lab repo (create the repo when the spec still says _TBD_). Each spec includes **Testing approach (lab)** plus [Per-project testing (labs + AI)](docs/playbook/per-project-testing.md) for layers and optional AI prompts.
3. Use **Key concepts** as a glossary while designing or debugging—not as a linear tutorial.
4. Run **Exploration scenarios** (hands-on cases after **Success criteria** in each spec) to drive failure modes and deepen understanding; paste exact curls/commands in the **lab README** when helpful.
5. Before you call the milestone done, walk the relevant shared checklist (below); optional **Stretch** when you want extra depth.

Skip reading every spec cover-to-cover up front; depth-read the project you are shipping.

### Exploration sandboxes ([exploration-projects/](exploration-projects/README.md))

**`exploration-projects/`** holds **four** commented probes aligned to your stack—PHP (Laravel slice), Node/TS HTTP, Go CLI, Rust CLI—not playbook lab code. Fundamentals reference: [Language fundamentals comparison](docs/handbook/language-fundamentals-comparison.md). Prefer one active **spec-backed** lab under **`career-projects/`**; use sandboxes for syntax muscle memory only.

### Unfamiliar stack + AI (still accountable)

When you must deliver **product A** in **stack B** you have not shipped before—often with AI drafting code—use the playbook so **concepts** (ownership, threading, leaks, contracts, idempotency) still get applied:

1. Skim [AI-assisted unfamiliar stack](docs/paths/ai-assisted-unfamiliar-stack.md) and name **A**, **B**, and **non-negotiables** before large codegen.
2. Use [term cards](docs/stacks/README.md) for vocabulary; if the tables confuse you first pass, jump to **[Stacks glossary](docs/stacks/glossary.md)** or the **Plain language** section at the bottom of the map you opened. Go deep in the [handbook](docs/handbook/software-engineering.md) when a term is load-bearing.
3. Before calling it done, walk [unfamiliar-stack-ship](checklists/unfamiliar-stack-ship.md) (memory and lifecycle, failure paths, secrets, observability—scoped to what you built).

For **integration-shaped architecture** on your stack, see [Systems integration architect](docs/paths/systems-integration-architect.md).

### Checklists and [PROGRESS.md](PROGRESS.md)

Checklists are **definition-of-done rubrics** for integration-shaped work, LLM paths, and **unfamiliar-stack** deliveries—not daily todos. When you are close to shipping, walk them once with code and config open. **[How to use checklists and this log](PROGRESS.md#how-to-use-checklists-and-this-log)** (deadlines, cadence, optional **Tradeoff** / **Failure mode** lines) lives at the top of `PROGRESS.md`.

## Learning path (suggested)

Phases are **ordered for dependency flow**, not calendar weeks—you can overlap (e.g. observability while building RAG).

| Phase | Projects | Notes |
|-------|----------|--------|
| **1 — Integration spine** | [01](career-project-specs/01-integration-webhook-receiver.md) | Hardened webhooks: signatures, idempotency, logs, dead letters; Boomi-style fast ack. |
| **2 — Applied AI + ops** | [04](career-project-specs/04-rag-llm-service.md), [03](career-project-specs/03-observability-lab.md) | RAG/evals + structured logging; Python LLM boundary. |
| **3 — API contracts** | [02](career-project-specs/02-contract-first-api.md) | OpenAPI + consumer/contract discipline. |
| **4 — Event-driven scale** | [05](career-project-specs/05-async-worker-stretch.md), [09](career-project-specs/09-go-retrieval-worker-lab.md) | Queues, DLQ; **Go** workers + retrieval gateway beside Python RAG. |
| **5 — TypeScript API lane** | [06](career-project-specs/06-node-typescript-lab.md) | Node + TypeScript HTTP service—core stack, same reliability patterns. |
| **4b — SQL depth** | [07](career-project-specs/07-sql-performance-lab.md) | Postgres: plans, indexing, transactions, pagination, vector-adjacent retrieval. |
| **4c — Security foundations** | [08](career-project-specs/08-application-security-lab.md) | OWASP web risks + integration-edge security literacy. |

**Stack reality:** **PHP** (P1), **Python** (P4), **Go** (P9 workers/retrieval), **TypeScript** (P6), **SQL** (P7). P2 may use Laravel or FastAPI; P8 is stack-agnostic within the core set. Study depth: [Algorithms study path](docs/paths/algorithms-study-path.md) for Big-O tied to labs—not optional for P7/P9/RAG chunk paths.

## Architectural narrative

The phased ladder doubles as **systems-thinking** practice: boundaries, failure modes, and tradeoffs—not only feature tutorials.

| Competency | Where you practice it |
|------------|----------------------|
| **Service boundaries** (sync ack vs durable work) | [Project 1](career-project-specs/01-integration-webhook-receiver.md) thin HTTP path → [Project 5](career-project-specs/05-async-worker-stretch.md) queue, worker, DLQ |
| **Contracts and evolution** | [Project 2](career-project-specs/02-contract-first-api.md) OpenAPI, breaking-change discipline |
| **Reliability semantics** | Idempotency, retries, at-least-once, DLQ in P1 and P5; [integration hardening](checklists/integration-hardening.md) |
| **Observability as design** | [Project 3](career-project-specs/03-observability-lab.md); structured logs and correlation IDs |
| **Security at integration edges** | P1 signatures/secrets; [FOCUS.md](FOCUS.md) theme **#3**; integration checklist |
| **Cybersecurity / OWASP foundations (web)** | [Project 8](career-project-specs/08-application-security-lab.md) SQLi, XSS, auth/sessions, forms/CSRF; [application security (web) checklist](checklists/application-security-web-owasp.md)—for shipping engineers, alongside P1 |
| **Data shape under load** | [Project 7](career-project-specs/07-sql-performance-lab.md) plans, indexes, transactions, pagination |
| **AI product boundaries** | [Project 4](career-project-specs/04-rag-llm-service.md); [LLM feature ship](checklists/llm-feature-ship.md) |
| **Event-driven + automation patterns** | P1 → P5 → P9; [integration-automation map](docs/stacks/integration-automation.md) |
| **Go concurrency + retrieval boundary** | [Project 9](career-project-specs/09-go-retrieval-worker-lab.md); [Go stack map](docs/stacks/go.md) |
| **Rust Tier‑2 (after P9 Go)** | [P9 stretch](career-project-specs/09-go-retrieval-worker-lab.md#stretch); [Rust stack map](docs/stacks/rust.md); [rust-cli-http-probe](exploration-projects/rust-cli-http-probe/README.md) |
| **AI + automation + cloud (one spine)** | [Learning journey — quick map](docs/paths/learning-journey.md#ai-automation-and-cloud--quick-map); capstone: P1/P6 → P5 → P9 → P4 → P7 |
| **Performance under load (Big-O)** | [Algorithms study path](docs/paths/algorithms-study-path.md); P7, P9, RAG chunk pipelines |
| **TypeScript API lane** | [Project 6](career-project-specs/06-node-typescript-lab.md) |
| **Unfamiliar stack + AI** | [AI-assisted unfamiliar stack](docs/paths/ai-assisted-unfamiliar-stack.md); [unfamiliar-stack ship](checklists/unfamiliar-stack-ship.md) |

**Habits:** Treat each spec as a *design brief*—especially **Career relevance**, **Real-world situations**, and **Key concepts**. After each shipped milestone, log **one explicit tradeoff** (what you rejected and why) and **one production failure mode** you guarded against in [PROGRESS.md](PROGRESS.md). Before calling integration or LLM work done, walk the checklists above. Optional: in each lab repo README, add one diagram plus three bullets—components, data flow, failure modes.

## Quick links to practice repos

| # | Initiative | Local | GitHub |
|---|------------|-------|--------|
| 1 | Integration webhook receiver | [01-webhook-receiver-lab](career-projects/01-webhook-receiver-lab) | [shemaiahCox/webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab) |
| 2 | Contract-first API | _TBD_ | _TBD — see [career-project-specs/02-contract-first-api.md](career-project-specs/02-contract-first-api.md)_ |
| 4 | RAG / LLM service (FastAPI + eval harness) | [04-rag-llm-lab](career-projects/04-rag-llm-lab) | [shemaiahCox/rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab) |
| 5 | Async worker | _TBD_ | _Often extends P1 — see [P5](career-project-specs/05-async-worker-stretch.md)_ |
| 6 | Node / TypeScript lab | _TBD_ | _TBD — see [P6](career-project-specs/06-node-typescript-lab.md)_ |
| 7 | SQL performance lab | [07-sql-perf-lab](career-projects/07-sql-perf-lab) | [shemaiahCox/sql-perf-lab](https://github.com/shemaiahCox/sql-perf-lab) |
| 8 | OWASP / security foundations | _TBD_ | _TBD — see [P8](career-project-specs/08-application-security-lab.md)_ |
| 9 | Go retrieval + worker lab | _TBD_ | _TBD — see [P9](career-project-specs/09-go-retrieval-worker-lab.md)_ |

**Default layout:** Clone or open playbook-backed labs inside **`career-projects/`** as **`NN-*`** folders (often **nested `.git`** checkouts)—see [**`career-projects/README.md`**](career-projects/README.md). To add a missing lab from the playbook root: `git clone <ssh-url> career-projects/<folder-name>` (for example **`01-webhook-receiver-lab`**). **Separate commercial / product** repos unrelated to playbook labs may live beside this repo under **`~/Documents/dev/business-projects/`** (optional index: [sibling **`business-projects/README.md`**](../business-projects/README.md)).

SSH remotes commonly used here: `git@github.com:shemaiahCox/webhook-receiver-lab.git` · `git@github.com:shemaiahCox/rag-llm-lab.git` · `git@github.com:shemaiahCox/sql-perf-lab.git`.

See [**`exploration-projects/README.md`**](exploration-projects/README.md) for language sandboxes only.

Each spec under [career-project-specs/](career-project-specs/) expands **key terms** (definitions, problems solved) with snippets from these repos where applicable. When you create a new practice repo for P2/P5/P6/P8, add rows here plus SSH hints.
