# career-playbook

Practice projects for **AI Systems · Cloud · Automation · IoT** — one linear path, **22 steps** (Projects 1–21 + integrated capstone).

**Rule:** one active project at a time.

## Start here

1. **[Project 1](career-project-specs/01-integration-webhook-receiver.md)** — begin the path below
2. **[PROGRESS.md](PROGRESS.md)** — log what you're working on

Finish each project's success criteria → log in PROGRESS → open **Next** in the spec. **Step 22** composes your labs into one flagship portfolio system.

**Core stack (Go-first track):** PHP · Python · SQL · Go · Bash — ship production patterns without Rust. Steps **19–20** stay in the path as **optional future track**; defer them in [PROGRESS.md](PROGRESS.md) when Rust is paused.

## Progression (Step 1 → 22)

| Step | Project | Primary category | Stack | You will learn | Lab |
|------|---------|------------------|-------|----------------|-----|
| 1 | [Integration webhook receiver](career-project-specs/01-integration-webhook-receiver.md) | Reliability | PHP | Idempotency, HMAC, fast ack, DLQ | [Lab exists](https://github.com/shemaiahCox/webhook-receiver-lab) |
| 2 | [RAG / LLM service](career-project-specs/02-rag-llm-service.md) | Reliability | Python | RAG, evals, citations, guardrails | [Lab exists](https://github.com/shemaiahCox/rag-llm-lab) |
| 3 | [Observability lab](career-project-specs/03-observability-lab.md) | Reliability | Any (on Project 2 lab) | Correlation IDs, structured logs, latency | On Project 2 lab |
| 4 | [SQL performance lab](career-project-specs/04-sql-performance-lab.md) | Performance | Postgres | Plans, indexes, vectors, transactions | [Lab exists](https://github.com/shemaiahCox/sql-perf-lab) |
| 5 | [Contract-first API](career-project-specs/05-contract-first-api.md) | Reliability | Laravel / FastAPI / TS | OpenAPI, versioning, breaking changes | _TBD_ |
| 6 | [Async worker stretch](career-project-specs/06-async-worker-stretch.md) | Concurrency | PHP / Go / TS | Queues, at-least-once, idempotency, DLQ | _TBD_ |
| 7 | [Node / TypeScript lab](career-project-specs/07-node-typescript-lab.md) | Concurrency | TypeScript | Typed HTTP API, webhooks, queue track | _TBD_ |
| 8 | [Go retrieval + worker](career-project-specs/08-go-retrieval-worker-lab.md) | Concurrency | Go | Concurrency, retrieval gateway, workers | _TBD_ |
| 9 | [Application security lab](career-project-specs/09-application-security-lab.md) | Reliability | Any | OWASP, integration-edge security | _TBD_ |
| 10 | [Automation bot / workflow](career-project-specs/10-automation-bot-lab.md) | Concurrency | TS + Python | Workflow steps, secrets, idempotent side effects | _TBD_ |
| 11 | [LLM web app](career-project-specs/11-llm-web-app-lab.md) | Reliability | TS + Python | BFF, streaming UX, eval-aware errors | _TBD_ |
| 12 | [Multi-tenant + auth](career-project-specs/12-multi-tenant-auth-lab.md) | Reliability | TS + SQL | Tenant isolation, JWT/session | _TBD_ |
| 13 | [Real-time dashboard](career-project-specs/13-realtime-dashboard-lab.md) | Networking | TypeScript | SSE/WebSocket, reconnect, backpressure | _TBD_ |
| 14 | [Shell automation lab](career-project-specs/14-shell-automation-lab.md) | Deploy | Bash | Strict mode, smoke scripts, shellcheck, bats | _TBD_ |
| 15 | [DevOps CLI](career-project-specs/15-devops-cli-lab.md) | Deploy | Go | DLQ replay, ops flags, exit codes | _TBD_ |
| 16 | [Cloud deploy](career-project-specs/16-cloud-deploy-lab.md) | Deploy | Compose + cloud | Deploy, secrets, health checks | _TBD_ |
| 17 | [K8s controller-lite](career-project-specs/17-k8s-controller-lab.md) | Concurrency | Go | Reconcile loop, idempotent apply | _TBD_ |
| 18 | [Proxy / load balancer](career-project-specs/18-proxy-load-balancer-lab.md) | Networking | Go | Timeouts, pooling, graceful shutdown | _TBD_ |
| 19 | [Rust hot-path](career-project-specs/19-rust-hot-path-lab.md) | Performance | Rust | Same Project 8 contract; Go vs Rust ADR | _Optional_ |
| 20 | [WASM secure component](career-project-specs/20-wasm-secure-component-lab.md) | Performance | Rust | Sandboxed logic, FFI boundaries | _Optional_ |
| 21 | [IoT / edge ingest](career-project-specs/21-iot-edge-lab.md) | Concurrency | Go + Py + TS | MQTT, idempotent telemetry, offline buffer | _TBD_ |
| 22 | [Integrated platform capstone](career-project-specs/22-integrated-platform-capstone.md) | Capstone | All labs | Flagship demo: ingest → AI → workers → dashboard → deploy | _TBD_ |

**Primary category** = the main systems skill each step proves. Many projects also touch other categories — see [Browse by systems skill](#browse-by-systems-skill).

**Go-first skip path:** After step **18**, open [Project 21](career-project-specs/21-iot-edge-lab.md) (Go ingest) or [Project 22](career-project-specs/22-integrated-platform-capstone.md). Log deferrals for steps 19–20 in [PROGRESS.md](PROGRESS.md).

Local lab folders live under [`career-projects/`](career-projects/). **Folder prefix = step number** (e.g. step 2 → `02-rag-llm-lab`, step 4 → `04-sql-perf-lab`). GitHub repo names may differ — each spec's **Code repo** section is authoritative.

### Optional projects (Big Tech benchmark — not in linear order)

After [Project 8](career-project-specs/08-go-retrieval-worker-lab.md) or [Project 22](career-project-specs/22-integrated-platform-capstone.md). See [big-tech-benchmark.md](docs/career/big-tech-benchmark.md).

| ID | Project | Spec |
|----|---------|------|
| P23 | Distributed rate limiter + API gateway | [23-rate-limiter-gateway-lab.md](career-project-specs/23-rate-limiter-gateway-lab.md) |
| P24 | Notification fan-out service | [24-notification-fanout-lab.md](career-project-specs/24-notification-fanout-lab.md) |
| P25 | Search / autocomplete microservice | [25-search-autocomplete-lab.md](career-project-specs/25-search-autocomplete-lab.md) |

## Browse by systems skill

Not the learning order — use when you want **evidence by capability** (how backend/systems roles evaluate you). Aim for **enough projects to solve real problems**, not a fixed count per bucket: usually one foundational lab, one production-shaped lab, and one integrated proof (capstone **22** covers the cross-category story).

| Systems skill | Primary projects | Also practiced in |
|---------------|------------------|-------------------|
| **Reliability / monitoring / logging** | 1, 2, 3, 5, 9, 11, 12 | 6, 8, 15, 16, 22 |
| **Concurrency / background jobs** | 6, 7, 8, 10, 17, 21 | 1, 13, 22 |
| **Performance tuning / profiling** | 4, 8, 18 | 3, 19 (optional Rust), 22 |
| **Linux / processes / networking** | 13, 18 | 16, 17, 21, 22 |
| **Deployment / automation (CI/CD, Docker, scripting)** | 14, 15, 16 | 1, 4, 10, 22 |

**Optional performance depth (Go-first, after P8):** pick **one** — [P23 rate limiter](career-project-specs/23-rate-limiter-gateway-lab.md) (Go + Redis; edge middleware p99) **or** [P25 search/autocomplete](career-project-specs/25-search-autocomplete-lab.md) (Go + Postgres + Redis; trie/index p95). Both replace Rust P19/P20 interview depth without a second language rewrite.

**Minimum credible evidence (Go-first):** reliability **1 + 3 + 6** · concurrency **6 + 8** · performance **4 + 8 + 18** (before/after numbers in `docs/portfolio/performance.md`) · deploy **14 + 16** · capstone **22**. Steps **19–20** add Rust depth later — not required for backend/systems positioning today.

## Browse by topic (optional)

Not the learning order — use when you want every project that practices a concept.

| Concept | Projects |
|---------|----------|
| **Idempotency** | 1, 6, 7, 8, 10, 12, 17, 21 |
| HMAC / webhook trust | 1, 10, 9 |
| Dead letter / replay | 1, 6, 15 |
| RAG + eval regression | 2, 11, 21 |
| OpenAPI / contracts | 5, 2↔8, 7, 11 |
| SQL plans / vectors | 4, 2, 8, 12 |
| Auth + tenant isolation | 12, 11, 9 |
| Real-time push | 13, 8, 21 |
| **Bash / shell automation** | 1, 4, 10, 14, 16, 22 |
| **Performance (measure and tune)** | 3, 4, 8, 18, 23 (optional), 25 (optional), 19 (optional Rust) |
| **Memory / resource limits** | 2, 8, 13, 19 (optional), 20 (optional), 21 |
| Rust / systems ADR (optional future track) | 19, 20 |
| **Integrated capstone** | 22 |

Reference: [engineering pillars](docs/concepts/engineering-pillars.md) (optional topic index).

## Role direction

Build platforms that integrate systems, automate workflows, and layer AI — with contracts, idempotency, observability, and explicit failure modes.

**PHP stays ship-today.** Core depth here is **Python / Go / SQL / Bash** through numbered projects, with **TypeScript** where the spec calls for it. **Rust (steps 19–20)** is an optional future track — defer when paused; your Go-first performance story lives in Projects **4, 8, and 18**.

**Reference docs:** [languages/glossary.md](docs/languages/glossary.md) (stack maps) · [languages/bash.md](docs/languages/bash.md) (shell automation) · [concepts/](docs/README.md#concepts-theory-and-patterns) (theory and patterns) · [SDLC ↔ playbook map](docs/concepts/sdlc-playbook-map.md) (lifecycle ↔ projects)

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

Every project spec includes: **Progress** (step, prev/next) · **What you will learn** · **Stack and why** · **Before you start** (glossary + stack maps) · **Important concepts** · Success criteria · **Bash scripting milestone** (where applicable) · Testing · **Portfolio artifacts** · **When you're done**.

## Reference (not the path)

| Doc | Use when |
|-----|----------|
| [docs/languages/glossary.md](docs/languages/glossary.md) | New to a language — start here |
| [docs/career/target-alignment.md](docs/career/target-alignment.md) | UK Backend & Systems targeting — project ideas, £80k milestones, job matrix |
| [docs/career/big-tech-benchmark.md](docs/career/big-tech-benchmark.md) | Google/Meta/top-tier bar — optional ceiling, dual-track roadmap |
| [docs/concepts/messaging-and-rpc.md](docs/concepts/messaging-and-rpc.md) | Kafka vs Redis, REST vs gRPC (career + lab context) |
| [docs/concepts/software-engineering.md](docs/concepts/software-engineering.md) | Theory depth (testing, integration, security) |
| [docs/concepts/per-project-testing.md](docs/concepts/per-project-testing.md) | How to test each lab |
| [docs/templates/portfolio-artifacts.md](docs/templates/portfolio-artifacts.md) | Resume-ready diagram, ADR, perf, failure modes |
| [checklists/production-readiness.md](checklists/production-readiness.md) | Platform engineering gate per step |
| [docs/concepts/engineering-pillars.md](docs/concepts/engineering-pillars.md) | Optional topic index |

Full index: [docs/README.md](docs/README.md)
