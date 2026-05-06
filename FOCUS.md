# Focus

## Purpose

This playbook is for **deliberate practice**: phased labs in [project-specs/](project-specs/), shared [checklists](checklists/), and a [progress log](PROGRESS.md) so understanding and shipping discipline come first. **Career direction** below is context for what to practice—not the primary lens. Conversation-ready narratives are an optional downstream benefit of work you can actually run and explain.

## Role direction

**Backend / API + integrations engineer** who ships **reliable, observable** services and can add **LLM features safely** (retrieval, tool calling where appropriate, with **evals**, **guardrails**, and **operational visibility**).

**Credibility anchors:** PHP/Laravel, WordPress plugins, SQL, custom APIs, Boomi-style integrations, Docker, CLI, version control.

**Forward vector:** Python, LangChain (or similar), applied LLM **engineering** (not prompt tricks only).

**Flexible lane (optional but high leverage):** **Node + TypeScript** for one small service ([Project 6](project-specs/06-node-typescript-lab.md))—same reliability patterns as PHP/Python work, broader **SaaS / full-stack-adjacent** job surface. Not “every JS framework”; one HTTP stack + strict habits.

**SQL / data depth (optional):** A dedicated Postgres lab ([Project 7](project-specs/07-sql-performance-lab.md)) for **plans, indexing, transactions, and pagination**—so everyday SQL use becomes **correctness and performance you can reason about under load**, not only incidental queries in other repos.

## Industry themes to practice (durable, not hype-chasing)

1. **AI in real products** — Retrieval and tool boundaries, safety basics, regression **evals**, cost/latency awareness, logging around model paths.
2. **Reliability and operability** — Idempotent handlers, retries/backoff patterns, dead-letter handling, structured logs, trace/request IDs, debuggable failures.
3. **Security** — Secrets outside code, webhook signatures, auth boundaries, dependency hygiene, light threat modeling for integrations.
4. **Async and events** — Webhooks, queues, eventual consistency; overlaps with integration work.
5. **Developer experience** — OpenAPI/contract thinking, breaking-change discipline, tests where they protect contracts.
6. **SQL correctness and performance** — Reason about **plans**, **index tradeoffs**, **isolation**, and **pagination** without ORM blind spots ([Project 7](project-specs/07-sql-performance-lab.md)).

## Architectural thinking through practice

Those themes are the vocabulary of **systems work**: draw boundaries, name failure modes, defend tradeoffs with operational consequences—that is **core backend craft**, practiced here via specs and labs. The playbook maps each theme to projects and checklists in [README.md — Architectural narrative](README.md#architectural-narrative); use [PROGRESS.md](PROGRESS.md) to capture tradeoffs and failure modes per milestone.

## Polyglot learning apps (PacPal-style and others)

Keep them; make each demo **one** future-facing property (e.g. offline tension, tracing, strict API contract) and note the tradeoff in this playbook’s [PROGRESS.md](PROGRESS.md).

## Non-goals (this year)

- Deep ML research or training custom models.
- Chasing every new JS framework (**intentional exception:** one **Node + TypeScript** service lab is in-scope; see [Project 6](project-specs/06-node-typescript-lab.md)).
- **Rust or Go** as open-ended study—only add when tied to a **shipping artifact** (real repo) or a **concrete job target**; patterns here transfer without a second systems language by default.
- Turning this repo into a second resume (keep resume/CV separate unless you add a dedicated folder later).
