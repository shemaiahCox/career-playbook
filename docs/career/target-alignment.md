# Career targeting — Backend & Systems Engineer (UK)

**Use this:** Map your [22-step path](../../README.md#progression-step-1--22) to UK **Rust + Go backend** and **AI automation systems** roles. Not a job board — a living reference for which labs to ship, pin, and talk about in interviews.

**Architecture spine:** [Architecture framework](../concepts/architecture-framework.md) — minimum credible bar = shipped labs with ● coverage in **all five pillars** before capstone 22.

**Profile this supports:** Backend & Systems Engineer — PHP/SQL/JS commercial experience + Python, Go, Rust, TypeScript depth + AI/RAG automation + Bash ops glue.

**Companion:** [Portfolio artifacts template](../templates/portfolio-artifacts.md) · [Messaging and RPC](../concepts/messaging-and-rpc.md) · [Rust map](../languages/rust.md#career-positioning) · [Big Tech benchmark](big-tech-benchmark.md) (optional ceiling — Google/Meta bar)

---

## Verdict

The playbook spine already matches **Monzo-shaped fintech backend** and **Rust+Go systems** roles in the £70k–£100k band. Execution and **portfolio artifact quality** matter more than adding new project steps.

Your target band is **not** High-Frequency Trading (HFT) microsecond trading (£150k–£225k+) or blockchain Order Management System (OMS) core — those ask for market data, Financial Information eXchange (FIX), C++, and sub-millisecond tuning the playbook deliberately skips.

---

## Project ideas reference (advisor list → playbook)

Seven portfolio projects UK market advice says get interviews. Each maps to an existing spec — ship them with full `docs/portfolio/` artifacts.

| # | Project idea | Why it signals £80k+ | Playbook spec | Skills to highlight | Status |
|---|--------------|----------------------|---------------|---------------------|--------|
| 1 | **Webhook receiver** + idempotency + retries | Integration trust, money-moving patterns | [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) | HMAC, idempotency keys, DLQ, `request_id` | Lab exists — ship portfolio |
| 2 | **Message queue worker** + DLQ | At-least-once, poison message handling | [Project 6](../../career-project-specs/06-async-worker-stretch.md) + [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) | Idempotent handlers, retry policy, DLQ replay | Not started |
| 3 | **Rust microservice** (Axum/Actix) | Hot-path systems literacy | [Project 19](../../career-project-specs/19-rust-hot-path-lab.md) | Same contract as Go; `Result`; no `unwrap` in workers | After Project 8 Go green |
| 4 | **Go service** talking to Rust/Python | Rust+Go combo — rare in UK | [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) + [Project 2](../../career-project-specs/02-rag-llm-service.md) | Bounded concurrency, timeouts, Python↔Go ADR | RAG lab exists |
| 5 | **Shell automation toolkit** | Ops credibility — CI, smoke, deploy hooks | [Project 14](../../career-project-specs/14-shell-automation-lab.md) | strict mode, shellcheck, exit codes, bash vs Go CLI ADR | After P1–P13 milestones |
| 6 | **Go/Rust CLI** (fast, safe, clean) | Systems + ops credibility | [Project 15](../../career-project-specs/15-devops-cli-lab.md) | Flags, exit codes, structured output | After P14 |
| 7 | **IoT / edge ingest** | Edge niche (Bosch, Arm, Ocado Robotics) | [Project 21](../../career-project-specs/21-iot-edge-lab.md) | MQTT QoS, idempotent telemetry, offline buffer | Not started |
| 8 | **Distributed system** (small is fine) | End-to-end systems thinking | [Project 22](../../career-project-specs/22-integrated-platform-capstone.md) | Compose orchestration, cross-service `request_id`, E2E demo | After spine |

### Supporting ideas (already in playbook)

| Idea | Spec | Role in the story |
|------|------|-------------------|
| RAG / LLM + evals | [Project 2](../../career-project-specs/02-rag-llm-service.md) | AI automation on LinkedIn About |
| SQL under load + vectors | [Project 4](../../career-project-specs/04-sql-performance-lab.md) | Data layer credibility |
| Observability | [Project 3](../../career-project-specs/03-observability-lab.md) | Production-shaped claims |
| Contract-first API | [Project 5](../../career-project-specs/05-contract-first-api.md) | Service boundaries before Go/Rust split |
| TypeScript HTTP / BFF | [Project 7](../../career-project-specs/07-node-typescript-lab.md) | TS in headline |
| Proxy / load balancer | [Project 18](../../career-project-specs/18-proxy-load-balancer-lab.md) | Systems depth |
| WASM secure component | [Project 20](../../career-project-specs/20-wasm-secure-component-lab.md) | Security/sandboxing signal |
| Cloud deploy | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) | Cloud-ready services |
| Shell automation | [Project 14](../../career-project-specs/14-shell-automation-lab.md) | Bash ops glue, CI smoke |
| Automation bot | [Project 10](../../career-project-specs/10-automation-bot-lab.md) | Automation pipelines |
| LLM web app | [Project 11](../../career-project-specs/11-llm-web-app-lab.md) | User-facing AI integration |

### GitHub / interview bar (every pinned repo)

Every pinned repo should have clean commits and a README with a runnable demo. Include tests (unit plus at least one integration path) and `docs/portfolio/` with diagram, ADR, performance numbers, failure modes, and observability evidence ([template](../templates/portfolio-artifacts.md)). Add a **CI pipeline** (lint + test on pull request) per [Project 16](../../career-project-specs/16-cloud-deploy-lab.md). Include benchmarks where relevant (Projects **8** and **19** — p95 + peak RSS). Provide `scripts/demo.sh` or equivalent for reviewers — strict mode + shellcheck ([Project 14](../../career-project-specs/14-shell-automation-lab.md)).

---

## UK role categories you fit

| Category | Playbook fit | Notes |
|----------|--------------|-------|
| **Backend Engineer (Rust + Go)** | **Primary** | Projects 8, 19, 7, 5; capstone 22 |
| **Systems Engineer (Rust)** | Secondary | Projects 18, 19, 20 |
| **Security / Cryptography** | Partial | Projects 9, 20 — not crypto specialist track |
| **IoT / Embedded Firmware** | Partial | Project 21 = MQTT edge — not ESP32 firmware depth |
| **Blockchain / Crypto Core** | Not in spine | Deferred in [rust.md](../languages/rust.md) — optional pivot only |

---

## What UK employers ask vs playbook

Researched Monzo, fintech backend, infra Rust, and trading/HFT (London). Your £80k target = **fintech backend** band, not HFT.

| Employer ask | Who asks | Playbook | Gap |
|--------------|----------|----------|-----|
| Distributed systems + resilient software | Monzo, most backend | Strong — 1, 6, 8, 17, 22 | None |
| Go + strongly typed backend | Monzo, fintech | Strong — Project 8 | None |
| Rust + Tokio async | Monzo (growing), infra | Good — Project 19 | Minor — Tokio named in P19 |
| Idempotency, at-least-once, DLQ | Universal | Strong — 1, 6, 8, 15 | None |
| Bash / Linux ops glue | Most backend, Site Reliability Engineering (SRE)-adjacent | Strong — P14 + milestones | None |
| Postgres + SQL | Most backend | Strong — Project 4 | None |
| Kafka | Monzo onboarding, scale-ups | Stretch + [messaging doc](../concepts/messaging-and-rpc.md) | Medium — vocabulary + optional hands-on |
| Kubernetes + Docker | Monzo, cloud-native | Good — 16, 17 | Minor |
| AWS + Linux ops | Monzo, Keyrock | Partial — Project 16 (Elastic Container Service (ECS)/EKS examples) | Low |
| gRPC / service RPC | Monzo (Envoy), fintech profiles | Stretch on Project 8 + [messaging doc](../concepts/messaging-and-rpc.md) | Medium |
| CI/CD (GitHub Actions) | Every employer | **Required** in Project 16 | Closed by spec update |
| Prometheus + Grafana | Monzo profiles, K8s roles | **Required** `/metrics` in Project 8 | Closed by spec update |
| OpenTelemetry | Infra, modern backend | Good — Project 3 | Minor |
| Performance benchmarking | Systems, trading | Good — Project 19 ADR | None |
| Python secondary | AI backends, trading | Strong — 2, 10, 11 | None |
| OAuth / OIDC | B2B SaaS, fintech | Stretch on Project 12 | Medium |
| JWT + multi-tenant | SaaS/fintech | Strong — Project 12 | None |
| Event sourcing / µs latency | Citi HFT, trading | Not in spine | **Skip** — different market |
| Blockchain / OMS / market data | Crypto firms | Deferred | Skip unless pivot |
| Property-based testing | Security, trading QA | Stretch — `proptest` on Project 19 | Low |
| Cassandra | Monzo-specific | Not in spine | Skip — Postgres covers data layer |
| Chaos engineering | Large SRE | Not in spine | Low priority for £80k backend |

### Big Tech benchmark tier (optional ceiling)

Use when you want **Google/Meta/top-tier** as a learning benchmark — not a replacement for the £80k plan. Full scorecard: [big-tech-benchmark.md](big-tech-benchmark.md).

| Employer ask | UK £80k default | Big Tech benchmark tier |
|--------------|-----------------|-------------------------|
| Kafka / PubSub hands-on | Stretch on P6/P8 | **Required** on one deployment path ([messaging doc](../concepts/messaging-and-rpc.md)) |
| gRPC internal APIs | Stretch on P8 | **Required** + OpenTelemetry traces Python↔Go |
| OAuth / OIDC | Stretch on P12 | **Required** (Google sign-in) |
| Cloud deploy | Compose + one managed target | **GCP or AWS** with IAM least-privilege documented |
| LeetCode / DSA screens | Design-review literacy | [DSA interview track](dsa-interview-track.md) — parallel 12-week |
| System design interviews | Scattered checklists | [System design interview map](system-design-interview-map.md) |
| Optional portfolio depth | Capstone P22 | [P23](../../career-project-specs/23-rate-limiter-gateway-lab.md), [P24](../../career-project-specs/24-notification-fanout-lab.md), [P25](../../career-project-specs/25-search-autocomplete-lab.md) after spine |

**Do not chase for benchmark:** L5+ staff scope, HFT, blockchain core, full embedded firmware — same as UK non-goals in [big-tech-benchmark.md](big-tech-benchmark.md).

### Monzo-shaped profile (what onboarding looks like)

Monzo hires backend engineers agnostic to stack — they teach **Go, Kafka, Cassandra, K8s, Docker, AWS** on the job. Your playbook proves **Redis/Docker/Go/Rust + idempotency + observability** — the same reliability patterns with simpler local tooling. In interviews: *"Same idempotency semantics whether Redis or Kafka; I can ramp on your broker."*

### Do not chase

- HFT microsecond latency, market data, FIX, KDB, C++/Field-Programmable Gate Array (FPGA)
- Event sourcing at trading-firm scale
- Blockchain OMS / validator nodes (unless explicit pivot)
- Full embedded firmware / ESP32 drivers
- Cassandra (Monzo-specific; Postgres + Redis is enough for portfolio)

---

## £80k-ready milestones

£80k readiness means **evidence of systems thinking under production constraints**, not a language checklist.

### Minimum credible (interview-ready Go-first backend & systems)

Ship with full portfolio artifacts — **at least one ● lab per [architecture pillar](../concepts/architecture-framework.md#project--pillar-matrix)**:

| Pillar | Minimum lab |
|--------|-------------|
| 1 System shape | Project 1 |
| 2 Integration & messaging | Project 6 |
| 3 Data architecture | Project 4 |
| 4 Performance & language | Project 8 (+ 4 or 18 for numbers) |
| 5 Reliability, security, ops | Project 3 + 14 + 16 |

Full list:

1. [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) — webhook + HMAC + idempotency
2. [Project 6](../../career-project-specs/06-async-worker-stretch.md) — async worker + DLQ
3. [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) — Go gateway + worker (**spine milestone**)
4. [Project 3](../../career-project-specs/03-observability-lab.md) — observability on a real service
5. [Project 4](../../career-project-specs/04-sql-performance-lab.md) — plan-backed SQL tuning (before/after evidence)
6. [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) — deploy + CI + health checks
7. [Project 14](../../career-project-specs/14-shell-automation-lab.md) — shell toolkit + shellcheck CI

**Interview narrative:** *"Webhook ingress → queue → Go worker → Python RAG boundary → measured SQL and Go performance → deployed with observability, CI, and ops scripts."*

**Optional Rust enrichment:** [Project 19](../../career-project-specs/19-rust-hot-path-lab.md) adds Go vs Rust ADR when Rust is active — defer when paused; not required for Go-first positioning.

### Full differentiation (capstone + AI)

Add Projects **2, 11, 18, 22** for **backend + AI automation systems** — matches LinkedIn About; capstone **22** is the integrated proof across systems-skill categories.

### Optional performance depth (Go-first — pick one after P8)

When Rust is paused, add **one** optional lab for a fourth performance pin — do not require both:

| Pick | Stack | Best for | Spec |
|------|-------|----------|------|
| **P23** (recommended with P18) | Go + Redis | Rate limiting SD question; middleware p99 | [23-rate-limiter-gateway-lab.md](../../career-project-specs/23-rate-limiter-gateway-lab.md) |
| **P25** | Go + Postgres + Redis | Search/autocomplete SD question; trie/index p95 | [25-search-autocomplete-lab.md](../../career-project-specs/25-search-autocomplete-lab.md) |

Log your choice in [PROGRESS.md](../../PROGRESS.md). Commit `docs/portfolio/performance.md` in the optional lab repo.

---

## GitHub pin order

Pin repos that tell the **Go-first systems** story first (PHP stays in headline for commercial credibility):

1. **Go retrieval worker** (Project 8) — throughput + idempotency + Prometheus
2. **Platform capstone** (Project 22) — distributed system demo
3. **Shell automation** (Project 14) — ops glue story
4. **Webhook receiver** (Project 1) — integration foundation
5. **RAG service** (Project 2) — AI automation angle
6. **SQL performance** (Project 4) — data-layer evidence

**When Rust is active:** swap in **Rust hot-path** (Project 19) as pin #2 or #3.

**Optional Go-first performance pin:** after P8, add **P23** or **P25** (one only) as pin #2 or #3 if you want extra measured depth before capstone.

Each pinned repo: README demo, **CI badge**, `docs/portfolio/`, clean history.

---

## Interview themes (emphasise after each lab)

| Theme | Where you prove it |
|-------|-------------------|
| **Idempotency** | Projects 1, 6, 8 — "transport may duplicate; business effect runs once" |
| **Concurrency + backpressure** | Project 8 — bounded goroutines, context cancel |
| **Performance ADR** | Projects 4, 8, 18 — p95 + evidence; Project 19 optional (Rust) |
| **Memory safety** | Project 19 (optional Rust) — ownership, `Result`, no panic in hot path |
| **Async runtimes** | Project 19 (optional Rust) — Tokio after sync path solid |
| **Distributed systems** | Project 22 — trace `request_id` across 3+ services |
| **Observability** | Project 3 — structured logs, metrics, correlation |
| **Reliability patterns** | DLQ, retry backoff, health checks, rollback (1, 6, 15, 16) |
| **Bash / ops glue** | Project 14 — strict mode scripts, smoke tests, deploy hooks |

---

## Suggested priority (Steps 1, 2, 4 started)

```
Now     → Project 3 (obs on RAG lab) → Project 5 or 6 → Project 8 (Go) → Project 14/16 (deploy + bash)
Parallel → Project 9 reading; optional [DSA track](dsa-interview-track.md) for Big Tech benchmark
Later   → 11, 18, 22 for AI + networking + capstone; optional P23 or P25 for performance depth; Projects 19–20 when Rust is active
```

You do **not** need all 22 projects for £80k readiness — minimum credible milestone above is the bar; capstone is the stretch differentiator.

---

## LinkedIn ↔ playbook

- **Headline** — Backend & Systems Engineer with PHP/SQL/JS + Python/Go/Bash (Rust optional/future)
- **Featured repos** — lead with Go evidence (Projects 8, 22, 14, 1, 2); add Rust (Project 19) when shipped
- **About** — tie AI/RAG claims to Project 2/11 portfolio artifacts when shipped

---

## See also

- [Big Tech benchmark](big-tech-benchmark.md) — Google/Meta hiring bar, dual-track roadmap
- [DSA interview track](dsa-interview-track.md) — parallel LeetCode prep
- [System design interview map](system-design-interview-map.md) — classic SD problems ↔ labs
- [Engineering pillars](../concepts/engineering-pillars.md) — optional topic index
- [Portfolio artifacts](../templates/portfolio-artifacts.md)
- [Production readiness](../../checklists/production-readiness.md)
- [Rust career positioning](../languages/rust.md#career-positioning)
