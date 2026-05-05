# Focus

## Headline (optimize for this)

**Backend / API + integrations engineer** who ships **reliable, observable** services and can add **LLM features safely** (retrieval, tool calling where appropriate, with **evals**, **guardrails**, and **operational visibility**).

**Credibility anchors:** PHP/Laravel, WordPress plugins, SQL, custom APIs, Boomi-style integrations, Docker, CLI, version control.

**Forward vector:** Python, LangChain (or similar), applied LLM **engineering** (not prompt tricks only).

**Flexible lane (optional but high leverage):** **Node + TypeScript** for one small service ([Project 6](project-specs/06-node-typescript-lab.md))—same reliability patterns as PHP/Python work, broader **SaaS / full-stack-adjacent** job surface. Not “every JS framework”; one HTTP stack + strict habits.

## Industry themes to practice (durable, not hype-chasing)

1. **AI in real products** — Retrieval and tool boundaries, safety basics, regression **evals**, cost/latency awareness, logging around model paths.
2. **Reliability and operability** — Idempotent handlers, retries/backoff patterns, dead-letter handling, structured logs, trace/request IDs, debuggable failures.
3. **Security** — Secrets outside code, webhook signatures, auth boundaries, dependency hygiene, light threat modeling for integrations.
4. **Async and events** — Webhooks, queues, eventual consistency; overlaps with integration work.
5. **Developer experience** — OpenAPI/contract thinking, breaking-change discipline, tests where they protect contracts.

## Polyglot learning apps (PacPal-style and others)

Keep them; make each demo **one** future-facing property (e.g. offline tension, tracing, strict API contract) and note the tradeoff in this playbook’s [PROGRESS.md](PROGRESS.md).

## Non-goals (this year)

- Deep ML research or training custom models.
- Chasing every new JS framework (**intentional exception:** one **Node + TypeScript** service lab is in-scope; see [Project 6](project-specs/06-node-typescript-lab.md)).
- **Rust or Go** as open-ended study—only add when tied to a **shipping artifact** (real repo) or a **concrete job target**; patterns here transfer without a second systems language by default.
- Turning this repo into a second resume (keep resume/CV separate unless you add a dedicated folder later).
