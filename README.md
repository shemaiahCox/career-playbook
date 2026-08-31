# career-playbook

Practice path for **agentic AI on Azure** — seven sequential phases from a local Deep Agent to AKS.

**Rule:** one active lab at a time. Course work for a phase runs in parallel with that phase's lab.

**Primary stack (80%):** Python (Deep Agents, LangGraph, FastMCP, data) · Go (workers, Azure backends, K8s-adjacent APIs)

**Secondary (20%):** TypeScript/Node — MCP SDK, thin APIs. Stretch only; never required to exit a phase.

## How to read this playbook

Start with the architecture framework, then follow the phase table in order. Each row links to a lab spec (what to build, what to learn, when you are done) and a course. Use PROGRESS.md to log milestones; use checklists when you are close to shipping.

The five architecture pillars are how you *think* about systems. The seven domains plus six **required competence labs** are the *learning order*.

## Start here

1. **[Architecture framework](docs/concepts/architecture-framework.md)** — read first (~15 min): five pillars, reference shape, phase matrix
2. **[Phase 1 — Agentic orchestration](career-project-specs/01-agentic-orchestration.md)** — begin the hands-on path
3. **[PROGRESS.md](PROGRESS.md)** — log what you are working on (include **Pillar(s)**, **Tradeoff**, **Failure mode**)
4. **[Course track](docs/career/course-track.md)** — official URLs; open the matching lab while you study

Finish each spec's success criteria → log in PROGRESS → open **Next**. Linear order: domains **1–5** → labs **08–12** → domain **6** → lab **13** → domain **7**. **Phase 7** is the capstone: the same agent and backends, running on AKS.

## Architecture framework (read first)

Modern backend work is architectural work. Every phase practices decisions under **five pillars**.

| Pillar | One-line focus |
|--------|----------------|
| 1. System shape | Boundaries, sync vs async, who owns what |
| 2. Integration and messaging | Delivery semantics, brokers, idempotency, dead-letter queue (DLQ) |
| 3. Data architecture | Schema, indexes, pipelines that feed agent context |
| 4. Performance and language boundaries | Measure first; Python for AI, Go for throughput |
| 5. Reliability, security, operations | Observability, identity, deploy, failure modes |

**Start:** [Architecture framework](docs/concepts/architecture-framework.md) → [sample portfolio](docs/examples/sample-portfolio/) (quality bar) → [Phase 1](career-project-specs/01-agentic-orchestration.md).

## Progression (Phase 1 → 7)

| Phase | Domain | Focus | Stack | Course | Lab |
|-------|--------|-------|-------|--------|-----|
| 1 | Agentic AI and orchestration | Deep Agents harness, LangGraph state graphs, long-running context, tool execution, MCP | Python: Deep Agents, LangChain, LangGraph, FastMCP. TypeScript MCP/API stretch. | [Deep Agents + LangGraph + FastMCP](docs/career/course-track.md#phase-1) | [01-agentic-orchestration.md](career-project-specs/01-agentic-orchestration.md) |
| 2 | Containerization | Package the Phase 1 Python agent | Docker, Dockerfile, Compose | [KodeKloud Docker](docs/career/course-track.md#phase-2) | [02-containerize-agent.md](career-project-specs/02-containerize-agent.md) |
| 3 | Azure IaC | Provision without the portal | Terraform `azurerm`, App Service, VNet | [KodeKloud Terraform](docs/career/course-track.md#phase-3) | [03-azure-terraform-stack.md](career-project-specs/03-azure-terraform-stack.md) |
| 4 | Azure admin and governance | Networking, Entra ID, policies, resource management | IAM/RBAC, Key Vault, Storage | [KodeKloud AZ-104](docs/career/course-track.md#phase-4) | [04-azure-admin-governance.md](career-project-specs/04-azure-admin-governance.md) |
| 5 | System architecture and Azure backends | High-concurrency services wrapping agent tools | Go workers, Python Functions, Service Bus, Redis. TypeScript API stretch. | [ByteByteGo + DesignGurus](docs/career/course-track.md#phase-5) | [05-azure-backends.md](career-project-specs/05-azure-backends.md) |
| 6 | End-to-end data pipelines | Event streams and transforms that feed agent context | SQL, Kafka / Event Hubs, Spark (Python) | [Data Engineering Zoomcamp](docs/career/course-track.md#phase-6) | [06-data-pipelines.md](career-project-specs/06-data-pipelines.md) |
| 7 | Enterprise orchestration | Run, scale, observe, secure the stack | AKS, CI/CD, Helm | [KodeKloud CKA](docs/career/course-track.md#phase-7) | [07-aks-orchestration.md](career-project-specs/07-aks-orchestration.md) |

Local lab folders live under [`career-projects/`](career-projects/). **Folder prefix = spec number** (e.g. phase 1 → `01-agentic-orchestration-lab`; lab 08 → `08-ops-cli-lab`).

### Required competence labs (08–13)

Azure stays the implementation cloud. These labs are **required practice** for Backend & Systems competence — not optional, not a second product. Compose the Phase 5 worker. Each ADR names Azure plus **one sentence** AWS/GCP analogue ([cloud portability](docs/concepts/cloud-portability.md)).

| Lab | After | Focus | Stack | Next |
|-----|-------|-------|-------|------|
| [08 Ops CLI](career-project-specs/08-ops-cli.md) | Domain 5 | Flags, exit codes, **DLQ replay** | Go · Service Bus DLQ | 09 |
| [09 Edge proxy](career-project-specs/09-edge-proxy.md) | 08 | Timeouts, pooling, graceful shutdown | Go | 10 |
| [10 Rate limiter](career-project-specs/10-rate-limiter.md) | 09 | Token bucket / sliding window, `429` | Go · Redis | 11 |
| [11 Notification fan-out](career-project-specs/11-notification-fanout.md) | 10 | Pub/sub, retries, DLQ | Go · Service Bus topics / Event Grid | 12 |
| [12 Search / autocomplete](career-project-specs/12-search-autocomplete.md) | 11 | Prefix search, indexes, p95 | Go · Postgres · Redis | Domain 6 |
| [13 K8s controller-lite](career-project-specs/13-k8s-controller.md) | Domain 6 | Reconcile loop before Helm | Go · kind | Domain 7 |

v1 22-step specs (webhook, RAG, Rust, IoT, …) live in [`archive/v1-22-step/`](archive/v1-22-step/README.md) — not the learning order. Still out of scope: second-cloud deploys, PHP webhook, Rust/WASM, IoT, v1 capstone.

## Browse by architecture pillar

Not the learning order — use when you want **evidence by architectural decision type**. Full matrix: [architecture framework](docs/concepts/architecture-framework.md#phase--pillar-matrix).

| Pillar | Primary phases / labs | Also practiced in |
|--------|-----------------------|-------------------|
| **1. System shape** | 1, 5, 7, 11, 13 | 2, 3, 09 |
| **2. Integration and messaging** | 5, 6, 08, 11 | 1 (MCP tools), 7, 10 |
| **3. Data architecture** | 6, 12 | 1 (agent context / filesystem) |
| **4. Performance and language boundaries** | 5, 09, 10, 12 | 1, 7 |
| **5. Reliability, security, operations** | 2, 3, 4, 7, 08, 09 | every lab (failure modes) |

**Minimum credible (interview-ready):** Domains **1 + 2 + 3 + 5** plus labs **08 + 09**. **Full differentiation:** labs **10–13** plus domains **4 (AZ-104)**, **6**, **7 (CKA)**.

## Role direction

Build platforms that run **agentic AI** on **Azure**: Python owns the agent and data plane; Go owns high-concurrency backends; TypeScript is a complementary MCP/API skill. Prove contracts, idempotency, identity, observability, and explicit failure modes.

**PHP stays ship-today** (commercial work) — it is not on this path. Rust and IoT are archived with v1.

**Reference docs:** [languages/glossary.md](docs/languages/glossary.md) · [concepts/](docs/README.md#concepts-by-pillar) · [SDLC ↔ playbook map](docs/concepts/sdlc-playbook-map.md) · [target alignment](docs/career/target-alignment.md)

## Non-goals

- Resume-driven repos with no shared patterns
- Tutorial clones without tests or observability
- Multiple half-finished main labs
- Treating TypeScript as a third primary language
- Replacing PHP production work with greenfield here

## How to work through a lab

1. Read [Architecture framework](docs/concepts/architecture-framework.md) once, then open the spec
2. If the spec is a domain (1–7), start the matching course from [course-track.md](docs/career/course-track.md)
3. Read **Architecture pillars**, **What you will learn**, **Before you start**, and **Important concepts**
4. Build in [`career-projects/`](career-projects/) — one active lab (domain or 08–13)
5. Meet success criteria; test per [per-project testing](docs/concepts/per-project-testing.md)
6. Commit [portfolio artifacts](docs/templates/portfolio-artifacts.md) in the lab repo; gate with [production readiness](checklists/production-readiness.md)
7. Log in [PROGRESS.md](PROGRESS.md) → open **Next** in the spec

## Spec shape

Every spec (domain or competence lab) includes: **Progress** (prev/next) · **What you will learn** · **Architecture pillars** · **Stack and why** · **Before you start** · **Important concepts** · Success criteria · Testing · **Portfolio artifacts** · **When you're done**. Domain specs also name a course. Competence-lab ADRs add one AWS/GCP analogue sentence.

## Reference (not the path)

| Doc | Use when |
|-----|----------|
| [docs/concepts/architecture-framework.md](docs/concepts/architecture-framework.md) | **Read first** — five pillars, reference shape, phase matrix |
| [docs/concepts/agentic-orchestration.md](docs/concepts/agentic-orchestration.md) | Deep Agents vs LangGraph vs LangChain |
| [checklists/architecture-checklist.md](checklists/architecture-checklist.md) | Feasibility through scale |
| [docs/examples/sample-portfolio/](docs/examples/sample-portfolio/) | What good `docs/portfolio/` looks like |
| [docs/languages/glossary.md](docs/languages/glossary.md) | New to a language — start here |
| [docs/career/target-alignment.md](docs/career/target-alignment.md) | UK Backend & Systems — £80k, Azure-first |
| [docs/career/azure-certification-track.md](docs/career/azure-certification-track.md) | AZ-104 + CKA in-path |
| [docs/career/course-track.md](docs/career/course-track.md) | Course URLs + which lab to open |
| [docs/career/big-tech-benchmark.md](docs/career/big-tech-benchmark.md) | Optional Google/Meta ceiling |
| [docs/concepts/messaging-and-rpc.md](docs/concepts/messaging-and-rpc.md) | Kafka vs Redis, REST vs gRPC |
| [docs/concepts/cloud-portability.md](docs/concepts/cloud-portability.md) | Pattern → Azure (you build) → AWS → GCP names |
| [docs/concepts/software-engineering.md](docs/concepts/software-engineering.md) | Handbook (testing, IaC, agents, pipelines) |
| [docs/concepts/per-project-testing.md](docs/concepts/per-project-testing.md) | How to test each lab |
| [docs/templates/portfolio-artifacts.md](docs/templates/portfolio-artifacts.md) | Diagram, ADR, perf, failure modes |
| [checklists/production-readiness.md](checklists/production-readiness.md) | Platform engineering gate per phase |

Full index: [docs/README.md](docs/README.md)

**Content quality:** Every doc is scored against the [Content Quality Rubric](docs/README.md#content-quality). Copy-paste patterns: [Illustrative snippets](docs/concepts/illustrative-snippets.md).
