# Documentation

**Read first:** [Architecture framework](concepts/architecture-framework.md) — five pillars, reference shape, project matrix.

**Your path:** [README.md](../README.md#progression-step-1--22) (Project 1 → 22). Each project spec links what you need under **Architecture pillars**, **languages/**, or **concepts/**.

Entry point: [README.md](../README.md)

---

## How concept docs are written

Concept files under [`concepts/`](concepts/) follow the [learning-first concept template](templates/concept-doc-template.md):

1. **Use this** — plain-English trigger for when to read
2. **Reading order** — numbered path through related docs and labs
3. **Learning body** — terms defined before jargon; tables over acronym dumps
4. **Technical reference** — acronyms, commands, and glossary links at the **bottom**

Start with [Concurrency runtime model (Part 1)](concepts/concurrency-runtime-model.md) as the format example.

---

## Architecture framework

| Doc | Use when |
|-----|----------|
| [concepts/architecture-framework.md](concepts/architecture-framework.md) | **Spine** — read before Project 1; every lab maps here |
| [examples/sample-portfolio/](examples/sample-portfolio/) | Filled diagram, ADR, failure modes tagged by pillar |
| [examples/project-outcomes/01-webhook/](examples/project-outcomes/01-webhook/) | **Read without running** — logs, HTTP, DB snapshots (Project 1) |
| [examples/project-outcomes/02-rag-llm/](examples/project-outcomes/02-rag-llm/) | **Read without running** — `/query` contract, eval runner, logs (Project 2) |
| [templates/project-spec-visuals.md](templates/project-spec-visuals.md) | Spec sections: System diagram + Reference outcomes |
| [concepts/systems-integration-architect.md](concepts/systems-integration-architect.md) | Pillar 1 deep dive — system shape |

---

## Concepts by pillar

Theory and patterns — stack-agnostic. Open when your active spec's **Architecture pillars** section points you here.

### Pillar 1 — System shape

| Doc | Use when |
|-----|----------|
| [concepts/systems-integration-architect.md](concepts/systems-integration-architect.md) | Boundaries, sync vs async, reference architecture |
| [concepts/software-engineering.md § Architectural patterns](concepts/software-engineering.md#architectural-patterns) | Monolith, hexagonal, clean/onion, event-driven, microservices |
| [concepts/clean-architecture-layouts.md](concepts/clean-architecture-layouts.md) | **Mental model + folder layouts** — layers, payment walkthrough, universal + TS/Go/Python/PHP trees; illustrative only |
| [concepts/software-engineering.md § Domain-Driven Design](concepts/software-engineering.md#domain-driven-design-ddd) | Bounded contexts, aggregates, Command Query Responsibility Segregation (CQRS) + event sourcing |

### Pillar 2 — Integration and messaging

| Doc | Use when |
|-----|----------|
| [concepts/messaging-and-rpc.md](concepts/messaging-and-rpc.md) | Apache Kafka vs Redis/NATS; REST vs gRPC; broker ADRs |
| [concepts/software-engineering.md § Integration](concepts/software-engineering.md#integration-sync-async-and-messaging) | Sync HTTP, queues, delivery semantics |
| [concepts/integration-automation.md](concepts/integration-automation.md) | Boomi / n8n workflow patterns |
| [../checklists/integration-hardening.md](../checklists/integration-hardening.md) | Webhook and partner HTTP hardening |

### Pillar 3 — Data architecture

| Doc | Use when |
|-----|----------|
| [concepts/database-design.md](concepts/database-design.md) | Transactions, indexes, N+1, vectors, CAP vocabulary |
| [concepts/algorithms-study-path.md](concepts/algorithms-study-path.md) | Retrieval and index structures (Projects 4, 8) |

### Pillar 4 — Performance and language boundaries

| Doc | Use when |
|-----|----------|
| [concepts/concurrency-runtime-model.md](concepts/concurrency-runtime-model.md) | **Layers first** — CPU, OS thread, goroutine, event loop, concurrency vs parallelism |
| [concepts/concurrency-deep-dives.md](concepts/concurrency-deep-dives.md) | Go M:N scheduler, Node at scale, CPU switching intuition |
| [concepts/memory-and-performance.md](concepts/memory-and-performance.md) | Measure → profile → fix; latency, throughput, memory |
| [templates/performance-p4-sql.md](templates/performance-p4-sql.md) · [performance-p8-go.md](templates/performance-p8-go.md) · [performance-p18-proxy.md](templates/performance-p18-proxy.md) | Copy into lab `docs/portfolio/performance.md` |

### Pillar 5 — Reliability, security, operations

| Doc | Use when |
|-----|----------|
| [concepts/software-engineering.md](concepts/software-engineering.md) | Testing, concurrency, security, observability |
| [concepts/per-project-testing.md](concepts/per-project-testing.md) | How to test each lab |
| [../checklists/production-readiness.md](../checklists/production-readiness.md) | Platform engineering gate per step |
| [templates/portfolio-artifacts.md](templates/portfolio-artifacts.md) | Diagram, ADR, perf, failure modes per lab |

### Cross-cutting reference

[concepts/command-line-tooling.md](concepts/command-line-tooling.md) · [concepts/servers-and-networking.md](concepts/servers-and-networking.md) · [concepts/llms.md](concepts/llms.md) · [concepts/algorithms-and-data-structures.md](concepts/algorithms-and-data-structures.md) · [concepts/software-engineering-glossary.md](concepts/software-engineering-glossary.md) · [concepts/sdlc-playbook-map.md](concepts/sdlc-playbook-map.md) · [concepts/ai-assisted-unfamiliar-stack.md](concepts/ai-assisted-unfamiliar-stack.md) · [concepts/illustrative-snippets.md](concepts/illustrative-snippets.md) · [concepts/engineering-pillars.md](concepts/engineering-pillars.md) (optional topic browse — **superseded for learning order** by [architecture framework](concepts/architecture-framework.md))

---

## Languages (implementation detail — Pillars 1 and 4)

Syntax, ecosystem maps, and plain-language vocabulary. **Read each map top to bottom** (setup → layout → commands); **syntax side-by-side** lives in [language-fundamentals-comparison.md](languages/language-fundamentals-comparison.md).

| Doc | Stack |
|-----|-------|
| [languages/glossary.md](languages/glossary.md) | **Start here** — index to all maps |
| [languages/bash.md](languages/bash.md) | Bash / shell automation (Pillar 5 ops glue) |
| [languages/language-fundamentals-comparison.md](languages/language-fundamentals-comparison.md) | Side-by-side syntax (PHP, Python, Go, TS, Rust, SQL) |
| [languages/language-gotchas-deep-dive.md](languages/language-gotchas-deep-dive.md) | **20 gotchas** — mentor depth + interview prep |
| [languages/php-laravel.md](languages/php-laravel.md) | PHP + Laravel |
| [languages/python.md](languages/python.md) | Python / FastAPI |
| [languages/node-typescript-backend.md](languages/node-typescript-backend.md) | Node + TypeScript |
| [languages/go.md](languages/go.md) | Go workers / gateways |
| [languages/rust.md](languages/rust.md) | Rust (optional after Project 8 Go) |
| [languages/sql.md](languages/sql.md) | SQL / Postgres |

---

## Career (how pillars read in interviews)

| Doc | Use when |
|-----|----------|
| [career/target-alignment.md](career/target-alignment.md) | UK Backend & Systems — £80k milestones by pillar coverage |
| [career/big-tech-benchmark.md](career/big-tech-benchmark.md) | Google/Meta bar — pillar tradeoffs at scale + DSA/SD drills |
| [career/dsa-interview-track.md](career/dsa-interview-track.md) | Parallel LeetCode prep |
| [career/system-design-interview-map.md](career/system-design-interview-map.md) | Classic system design problems ↔ labs (whiteboard layer on pillars) |

---

## Templates and checklists (Pillar 5 + cross-cutting proof)

| Doc | Use when |
|-----|----------|
| [../checklists/architecture-checklist.md](../checklists/architecture-checklist.md) | Full lifecycle questionnaire — feasibility, stack tradeoffs, ops, scale |
| [../checklists/production-readiness.md](../checklists/production-readiness.md) | Platform engineering gate per step |
| [../checklists/integration-hardening.md](../checklists/integration-hardening.md) · [llm-feature-ship.md](../checklists/llm-feature-ship.md) · [application-security-web-owasp.md](../checklists/application-security-web-owasp.md) | Domain-specific ship gates |
| [templates/portfolio-artifacts.md](templates/portfolio-artifacts.md) | Resume-ready diagram, ADR (with **Pillar** tag), perf, failure modes |
| [templates/project-spec-visuals.md](templates/project-spec-visuals.md) | Enrich project specs — diagrams + reference outcomes |
| [templates/performance-p4-sql.md](templates/performance-p4-sql.md) · [performance-p8-go.md](templates/performance-p8-go.md) · [performance-p18-proxy.md](templates/performance-p18-proxy.md) | Pillar 4 evidence in lab repos |
| [concepts/illustrative-snippets.md](concepts/illustrative-snippets.md) | Copy-paste patterns (idempotency, HMAC, SSE, JWT, queues) |

---

## Content quality {#content-quality}

Every playbook page is scored against the **Content Quality Rubric (CQR)**: definitions (**What / Problem it solves**), examples, implementation detail, diagrams, **reference outcome snapshots** (logs, HTTP, DB), alternative comparisons, and pros/cons. **Gold standard:** [Project 1](../career-project-specs/01-integration-webhook-receiver.md) (System diagram + Reference outcomes) · [Illustrative snippets](concepts/illustrative-snippets.md).

| Tier | Action |
|------|--------|
| **Green** | Link fixes only — already meets CQR |
| **Amber** | Targeted blocks (comparison table, one diagram, footgun example) |
| **Red** | Major enrichment — Key concepts + code, alternatives, expanded scenarios |

### Audit matrix (74 files)

| File | CQR | Action |
|------|-----|--------|
| [README.md](../README.md) | Amber | Nav + CQR pointer |
| [PROGRESS.md](../PROGRESS.md) | Green | — |
| [career-projects/README.md](../career-projects/README.md) | Green | — |
| [career-project-specs/01–04](../career-project-specs/01-integration-webhook-receiver.md) | Green | P1–P2 reference outcomes; P3–4 phased per [project-spec-visuals](templates/project-spec-visuals.md) |
| [career-project-specs/05–09](../career-project-specs/05-contract-first-api.md) | Amber | Diagrams, alternatives, more code |
| [career-project-specs/10–25](../career-project-specs/10-automation-bot-lab.md) | Red | Full Key concepts + diagrams |
| [checklists/*](../checklists/) (6) | Amber | Why + pass/fail examples |
| [concepts/architecture-*](concepts/architecture-framework.md), software-engineering, command-line-tooling, database-design, servers-and-networking, memory-and-performance, algorithms-*, glossary | Green | — |
| [concepts/systems-integration-architect.md](concepts/systems-integration-architect.md) | Red | Sync/async diagram, monolith vs split |
| [concepts/integration-automation.md](concepts/integration-automation.md) | Red | n8n skeleton, Boomi vs code table |
| [concepts/messaging-and-rpc.md](concepts/messaging-and-rpc.md), [llms.md](concepts/llms.md) | Amber | Pros/cons tables, streaming notes |
| [concepts/ai-assisted-unfamiliar-stack.md](concepts/ai-assisted-unfamiliar-stack.md) | Red | Worked prompts, anti-patterns |
| [concepts/algorithms-study-path.md](concepts/algorithms-study-path.md), engineering-pillars, per-project-testing, sdlc-playbook-map | Amber | Cross-links + examples |
| [languages/*](languages/glossary.md) (10) | Amber | Footgun examples; glossary one-liners |
| [career/target-alignment.md](career/target-alignment.md), big-tech-benchmark | Green | — |
| [career/dsa-interview-track.md](career/dsa-interview-track.md), system-design-interview-map | Amber | Lab links |
| [templates/portfolio-artifacts.md](templates/portfolio-artifacts.md), language-ecosystem-map | Green | — |
| [templates/performance-p4/p8/p18](templates/performance-p4-sql.md) | Amber | Filled example rows |
| [examples/sample-portfolio/*](examples/sample-portfolio/) (3) | Amber | Detection signals |
| [examples/project-outcomes/01-webhook/*](examples/project-outcomes/01-webhook/) | Green | Project 1 captures |
| [examples/project-outcomes/02-rag-llm/*](examples/project-outcomes/02-rag-llm/) | Green | Project 2 captures |
