# Focus

## Purpose

This playbook is for **deliberate practice**: phased labs in [career-project-specs/](career-project-specs/), shared [checklists](checklists/), and a [progress log](PROGRESS.md) so understanding and shipping discipline come first. **Career direction** below is context for what to practice—not the primary lens. Conversation-ready narratives are an optional downstream benefit of work you can actually run and explain.

## Core stack

**JavaScript · TypeScript · PHP · SQL · Go · Python · Rust** — no parallel breadth tracks in Java, C#, Kotlin, Swift, or mobile/game stacks.

| Layer | Stack | Role in this playbook |
|-------|--------|------------------------|
| Integration ingress | PHP, Node/TS | Webhooks, HTTP APIs, Boomi-adjacent fast ack paths |
| AI product logic | Python | RAG, evals, orchestration behind stable HTTP contracts |
| Performance + concurrency | Go | Retrieval gateways, queue workers, connectors, event-driven microservices |
| Performance (Tier‑2, optional) | Rust | After P9 Go: compare hot-path reimplementation; edge/IoT-adjacent stretches—see [rust map](docs/stacks/rust.md) |
| Data correctness | SQL (Postgres) | Transactions, plans, indexes, vector retrieval storage |
| Automation (future) | n8n, Boomi patterns | Connectors, workflows, idempotent steps—see [integration-automation map](docs/stacks/integration-automation.md) |

### Growth lanes vs ship today

Languages are **in scope** at different time horizons:

| Horizon | Stack | Why |
|---------|--------|-----|
| **Ship and get paid today** | PHP, TypeScript, SQL | Credibility anchors (Laravel, WordPress, Boomi-adjacent integrations, APIs); data correctness under real load |
| **Long-term growth (backend + AI-augmented products)** | **Python**, **Go** | Python owns model-backed logic (RAG, evals, orchestration); Go owns throughput (workers, retrieval fan-out, event-driven services) |
| **Tier‑2 growth (after P9 Go core)** | **Rust** | Optional reimplementation of P9 boundaries with explicit Go-vs-Rust ADR; IoT/edge as **stretch**, not spine—aligns with AI systems + cloud + automation positioning without two active worker spines |

**Python + Go are first-class growth lanes**, not optional breadth. **Rust is intentional depth**, not a parallel ladder—ship Go P9 first, then sandbox or reimplement.

**PHP and TypeScript stay first-class for ingress**—webhooks, HTTP APIs, automation extensions—not “legacy only.” **SQL stays load-bearing** for every lane (P7 is not optional for RAG or Go retrieval paths).

Practice order still follows the [learning path](README.md#learning-path-suggested): integration spine first (P1), then AI + ops (P4), then scale (P5/P9)—so growth lanes sit on proven integration discipline, not hype.

## Role direction

**Integrations + automation backend engineer** who ships **reliable, observable, event-driven** services and can add **LLM features safely** (retrieval, tool calling where appropriate, with **evals**, **guardrails**, and **operational visibility**).

**Credibility anchors:** PHP/Laravel, WordPress plugins, SQL, custom APIs, **Boomi-style integrations**, Docker, CLI, version control.

**Forward vector:** **Python** and **Go** as co-primary backend growth lanes—Python for model-backed services (retrieval, orchestration, vendor APIs under explicit boundaries); Go for throughput-critical paths (workers, retrieval fan-out, integration runtimes). **Rust** as Tier‑2 after P9 Go (hot-path comparison, systems literacy, optional IoT/edge stretch). **PHP** and **TypeScript** for integration ingress and APIs you ship today; **TypeScript** also for automation extensions (e.g. n8n custom nodes).

**SQL / data depth:** Postgres lab ([Project 7](career-project-specs/07-sql-performance-lab.md)) for **plans, indexing, transactions, pagination, and vector-adjacent retrieval**—correctness and performance under load, not incidental queries.

## Industry themes to practice (durable, not hype-chasing)

1. **AI in real products** — Retrieval and tool boundaries, safety basics, regression **evals**, cost/latency awareness; **Python for logic, Go for performance-critical retrieval/work**; Rust optional for same boundary after Go ships.
2. **Reliability and operability** — Idempotent handlers, retries/backoff, DLQ, structured logs, trace/request IDs, debuggable failures.
3. **Security** — Secrets outside code, webhook signatures, auth boundaries, dependency hygiene, integration-edge threat modeling; [Project 8](career-project-specs/08-application-security-lab.md) for OWASP foundations alongside P1.
4. **Event-driven design** — Webhooks, queues, eventual consistency, automation workflows (Boomi/n8n mental model); overlaps P1, P5, P9.
5. **Performance and concurrency** — Goroutines, worker pools, backpressure, Big-O under load ([Algorithms study path](docs/paths/algorithms-study-path.md)); Rust ownership/async as Tier‑2 comparison.
6. **Developer experience** — OpenAPI/contract thinking, breaking-change discipline, tests that protect contracts.
7. **SQL correctness and performance** — Plans, index tradeoffs, isolation, pagination ([Project 7](career-project-specs/07-sql-performance-lab.md)).
8. **Cloud-shaped ops** — Docker Compose, durable queues, optional deploy stretches in lab READMEs—not a separate certification track.

## Architectural thinking through practice

Those themes are **systems work**: boundaries, failure modes, tradeoffs with operational consequences. The playbook maps each theme to projects in [README.md — Architectural narrative](README.md#architectural-narrative); log tradeoffs in [PROGRESS.md](PROGRESS.md).

For **integration-shaped architecture** on your stack (not six-language syntax tours), use [Systems integration architect](docs/paths/systems-integration-architect.md). When AI drafts code in a stack you have not shipped before, use [AI-assisted unfamiliar stack](docs/paths/ai-assisted-unfamiliar-stack.md) and [unfamiliar-stack-ship](checklists/unfamiliar-stack-ship.md).

## Side projects (PacPal-style and others)

Keep them; tie each demo to **one** load-bearing property (tracing, offline tension, strict contract) and note the tradeoff in [PROGRESS.md](PROGRESS.md). **Playbook labs** live under [`career-projects/`](career-projects/README.md). **Small sandboxes** (PHP, Node/TS, Go, Rust probes) under [`exploration-projects/`](exploration-projects/README.md).

## Non-goals (this year)

- Deep ML research or training custom models.
- Chasing every JS framework—**one Node + TypeScript API lane** ([Project 6](career-project-specs/06-node-typescript-lab.md)) is in scope; not a frontend curriculum.
- **Java, C#, Kotlin, Swift, Unity, Next.js** as playbook study tracks.
- **Rust or Go as parallel active spines**—one throughput lane on the calendar (Go P9 first; Rust reimplementation only after).
- **Full IoT/robotics/embedded curriculum**—optional Rust edge stretch or side demo only.
- Turning this repo into a second resume (keep resume/CV separate unless you add a dedicated folder later).
