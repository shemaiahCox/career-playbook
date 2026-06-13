# career-playbook

Practice projects for **AI Systems · Cloud · Automation · IoT** — one linear path, **21 steps** (Projects 1–20 + integrated capstone).

**Rule:** one active project at a time.

## Start here

1. **[Project 1](career-project-specs/01-integration-webhook-receiver.md)** — begin the path below
2. **[PROGRESS.md](PROGRESS.md)** — log what you're working on

Finish each project's success criteria → log in PROGRESS → open **Next** in the spec. **Step 21** composes Projects 1–20 into your flagship portfolio system.

## Progression (Step 1 → 21)

| Step | Project | Stack | You will learn | Lab |
|------|---------|-------|----------------|-----|
| 1 | [Integration webhook receiver](career-project-specs/01-integration-webhook-receiver.md) | PHP | Idempotency, HMAC, fast ack, DLQ | [Lab exists](https://github.com/shemaiahCox/webhook-receiver-lab) |
| 2 | [RAG / LLM service](career-project-specs/02-rag-llm-service.md) | Python | RAG, evals, citations, guardrails | [Lab exists](https://github.com/shemaiahCox/rag-llm-lab) |
| 3 | [Observability lab](career-project-specs/03-observability-lab.md) | Any (on Project 2 lab) | Correlation IDs, structured logs, latency | On Project 2 lab |
| 4 | [SQL performance lab](career-project-specs/04-sql-performance-lab.md) | Postgres | Plans, indexes, vectors, transactions | [Lab exists](https://github.com/shemaiahCox/sql-perf-lab) |
| 5 | [Contract-first API](career-project-specs/05-contract-first-api.md) | Laravel / FastAPI / TS | OpenAPI, versioning, breaking changes | _TBD_ |
| 6 | [Async worker stretch](career-project-specs/06-async-worker-stretch.md) | PHP / Go / TS | Queues, at-least-once, idempotency, DLQ | _TBD_ |
| 7 | [Node / TypeScript lab](career-project-specs/07-node-typescript-lab.md) | TypeScript | Typed HTTP API, webhooks, queue track | _TBD_ |
| 8 | [Go retrieval + worker](career-project-specs/08-go-retrieval-worker-lab.md) | Go | Concurrency, retrieval gateway, workers | _TBD_ |
| 9 | [Application security lab](career-project-specs/09-application-security-lab.md) | Any | OWASP, integration-edge security | _TBD_ |
| 10 | [Automation bot / workflow](career-project-specs/10-automation-bot-lab.md) | TS + Python | Workflow steps, secrets, idempotent side effects | _TBD_ |
| 11 | [LLM web app](career-project-specs/11-llm-web-app-lab.md) | TS + Python | BFF, streaming UX, eval-aware errors | _TBD_ |
| 12 | [Multi-tenant + auth](career-project-specs/12-multi-tenant-auth-lab.md) | TS + SQL | Tenant isolation, JWT/session | _TBD_ |
| 13 | [Real-time dashboard](career-project-specs/13-realtime-dashboard-lab.md) | TypeScript | SSE/WebSocket, reconnect, backpressure | _TBD_ |
| 14 | [DevOps CLI](career-project-specs/14-devops-cli-lab.md) | Go | DLQ replay, ops flags, exit codes | _TBD_ |
| 15 | [Cloud deploy](career-project-specs/15-cloud-deploy-lab.md) | Compose + cloud | Deploy, secrets, health checks | _TBD_ |
| 16 | [K8s controller-lite](career-project-specs/16-k8s-controller-lab.md) | Go | Reconcile loop, idempotent apply | _TBD_ |
| 17 | [Proxy / load balancer](career-project-specs/17-proxy-load-balancer-lab.md) | Go / Rust | Timeouts, pooling, graceful shutdown | _TBD_ |
| 18 | [Rust hot-path](career-project-specs/18-rust-hot-path-lab.md) | Rust | Same Project 8 contract; Go vs Rust ADR | _TBD_ |
| 19 | [WASM secure component](career-project-specs/19-wasm-secure-component-lab.md) | Rust | Sandboxed logic, FFI boundaries | _TBD_ |
| 20 | [IoT / edge ingest](career-project-specs/20-iot-edge-lab.md) | Rust/Go + Py + TS | MQTT, idempotent telemetry, offline buffer | _TBD_ |
| 21 | [Integrated platform capstone](career-project-specs/21-integrated-platform-capstone.md) | All labs | Flagship demo: ingest → AI → workers → dashboard → deploy | _TBD_ |

Local lab folders live under [`career-projects/`](career-projects/). **Folder prefix = step number** (e.g. step 2 → `02-rag-llm-lab`, step 4 → `04-sql-perf-lab`). GitHub repo names may differ — each spec's **Code repo** section is authoritative.

## Browse by topic (optional)

Not the learning order — use when you want every project that practices a concept.

| Concept | Projects |
|---------|----------|
| **Idempotency** | 1, 6, 7, 8, 10, 12, 16, 20 |
| HMAC / webhook trust | 1, 10, 9 |
| Dead letter / replay | 1, 6, 14 |
| RAG + eval regression | 2, 11, 20 |
| OpenAPI / contracts | 5, 2↔8, 7, 11 |
| SQL plans / vectors | 4, 2, 8, 12 |
| Auth + tenant isolation | 12, 11, 9 |
| Real-time push | 13, 8, 20 |
| **Performance (measure and tune)** | 3, 4, 8, 17, 18 |
| **Memory / resource limits** | 2, 8, 13, 18, 19, 20 |
| Rust / systems ADR | 18, 17, 19 |
| **Integrated capstone** | 21 |

Reference: [engineering pillars](docs/concepts/engineering-pillars.md) (optional topic index).

## Role direction

Build platforms that integrate systems, automate workflows, and layer AI — with contracts, idempotency, observability, and explicit failure modes.

**PHP stays ship-today.** This repo is for Python / Go / TypeScript / SQL / Rust depth through numbered projects.

**Reference docs:** [languages/glossary.md](docs/languages/glossary.md) (stack maps) · [concepts/](docs/README.md#concepts-theory-and-patterns) (theory and patterns)

## Non-goals

- Resume-driven repos with no shared patterns
- Tutorial clones without tests or observability
- Multiple half-finished main projects
- Replacing PHP production work with greenfield here

## How to work through a project

1. Open the spec (e.g. [Project 1](career-project-specs/01-integration-webhook-receiver.md))
2. Read **What you will learn**, **Before you start**, and **Important concepts**
3. Build in [`career-projects/`](career-projects/) (nested git clone when a lab exists)
4. Meet success criteria; test per [per-project testing](docs/concepts/per-project-testing.md)
5. Commit [portfolio artifacts](docs/templates/portfolio-artifacts.md) in the lab repo; gate with [production readiness](checklists/production-readiness.md)
6. Log in [PROGRESS.md](PROGRESS.md) → open **Next** in the spec

## Spec shape

Every project spec includes: **Progress** (step, prev/next) · **What you will learn** · **Stack and why** · **Before you start** (glossary + stack maps) · **Important concepts** · Success criteria · Testing · **Portfolio artifacts** · **When you're done**.

## Reference (not the path)

| Doc | Use when |
|-----|----------|
| [docs/languages/glossary.md](docs/languages/glossary.md) | New to a language — start here |
| [docs/concepts/software-engineering.md](docs/concepts/software-engineering.md) | Theory depth (testing, integration, security) |
| [docs/concepts/per-project-testing.md](docs/concepts/per-project-testing.md) | How to test each lab |
| [docs/templates/portfolio-artifacts.md](docs/templates/portfolio-artifacts.md) | Resume-ready diagram, ADR, perf, failure modes |
| [checklists/production-readiness.md](checklists/production-readiness.md) | Platform engineering gate per step |
| [docs/concepts/engineering-pillars.md](docs/concepts/engineering-pillars.md) | Optional topic index |

Full index: [docs/README.md](docs/README.md)
