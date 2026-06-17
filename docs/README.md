# Documentation

**Read first:** [Architecture framework](concepts/architecture-framework.md) — five pillars, reference shape, project matrix.

**Your path:** [README.md](../README.md#progression-step-1--22) (Project 1 → 22). Each project spec links what you need under **Architecture pillars**, **languages/**, or **concepts/**.

Entry point: [README.md](../README.md)

---

## Architecture framework

| Doc | Use when |
|-----|----------|
| [concepts/architecture-framework.md](concepts/architecture-framework.md) | **Spine** — read before Project 1; every lab maps here |
| [examples/sample-portfolio/](examples/sample-portfolio/) | Filled diagram, ADR, failure modes tagged by pillar |
| [concepts/systems-integration-architect.md](concepts/systems-integration-architect.md) | Pillar 1 deep dive — system shape |

---

## Concepts by pillar

Theory and patterns — stack-agnostic. Open when your active spec's **Architecture pillars** section points you here.

### Pillar 1 — System shape

| Doc | Use when |
|-----|----------|
| [concepts/systems-integration-architect.md](concepts/systems-integration-architect.md) | Boundaries, sync vs async, reference architecture |
| [concepts/software-engineering.md § Architectural patterns](concepts/software-engineering.md#architectural-patterns) | Monolith, hexagonal, event-driven, microservices |

### Pillar 2 — Integration and messaging

| Doc | Use when |
|-----|----------|
| [concepts/messaging-and-rpc.md](concepts/messaging-and-rpc.md) | Kafka vs Redis/NATS; REST vs gRPC; broker ADRs |
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

[concepts/command-line-tooling.md](concepts/command-line-tooling.md) · [concepts/servers-and-networking.md](concepts/servers-and-networking.md) · [concepts/llms.md](concepts/llms.md) · [concepts/algorithms-and-data-structures.md](concepts/algorithms-and-data-structures.md) · [concepts/software-engineering-glossary.md](concepts/software-engineering-glossary.md) · [concepts/sdlc-playbook-map.md](concepts/sdlc-playbook-map.md) · [concepts/ai-assisted-unfamiliar-stack.md](concepts/ai-assisted-unfamiliar-stack.md) · [concepts/engineering-pillars.md](concepts/engineering-pillars.md) (optional topic browse — **superseded for learning order** by [architecture framework](concepts/architecture-framework.md))

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
| [career/system-design-interview-map.md](career/system-design-interview-map.md) | Classic SD problems ↔ labs (whiteboard layer on pillars) |

---

## Templates and checklists (Pillar 5 + cross-cutting proof)

| Doc | Use when |
|-----|----------|
| [templates/portfolio-artifacts.md](templates/portfolio-artifacts.md) | Resume-ready diagram, ADR (with **Pillar** tag), perf, failure modes |
| [templates/performance-p4-sql.md](templates/performance-p4-sql.md) · [performance-p8-go.md](templates/performance-p8-go.md) · [performance-p18-proxy.md](templates/performance-p18-proxy.md) | Pillar 4 evidence in lab repos |
| [../checklists/production-readiness.md](../checklists/production-readiness.md) | Platform engineering gate per step |
