# Career targeting — Backend & Systems Engineer (UK)

**Use this:** Map your [21-step path](../../README.md#progression-step-1--21) to UK **Rust + Go backend** and **AI automation systems** roles. Not a job board — a living reference for which labs to ship, pin, and talk about in interviews.

**Profile this supports:** Backend & Systems Engineer — PHP/SQL/JS commercial experience + Python, Go, Rust, TypeScript depth + AI/RAG automation.

**Companion:** [Portfolio artifacts template](../templates/portfolio-artifacts.md) · [Messaging and RPC](../concepts/messaging-and-rpc.md) · [Rust map](../languages/rust.md#career-positioning)

---

## Verdict

The playbook spine already matches **Monzo-shaped fintech backend** and **Rust+Go systems** roles in the £70k–£100k band. Execution and **portfolio artifact quality** matter more than adding new project steps.

Your target band is **not** HFT microsecond trading (£150k–£225k+) or blockchain OMS core — those ask for market data, FIX, C++, and sub-millisecond tuning the playbook deliberately skips.

---

## Project ideas reference (advisor list → playbook)

Seven portfolio projects UK market advice says get interviews. Each maps to an existing spec — ship them with full `docs/portfolio/` artifacts.

| # | Project idea | Why it signals £80k+ | Playbook spec | Skills to highlight | Status |
|---|--------------|----------------------|---------------|---------------------|--------|
| 1 | **Webhook receiver** + idempotency + retries | Integration trust, money-moving patterns | [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) | HMAC, idempotency keys, DLQ, `request_id` | Lab exists — ship portfolio |
| 2 | **Message queue worker** + DLQ | At-least-once, poison message handling | [Project 6](../../career-project-specs/06-async-worker-stretch.md) + [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) | Idempotent handlers, retry policy, DLQ replay | Not started |
| 3 | **Rust microservice** (Axum/Actix) | Hot-path systems literacy | [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) | Same contract as Go; `Result`; no `unwrap` in workers | After Project 8 Go green |
| 4 | **Go service** talking to Rust/Python | Rust+Go combo — rare in UK | [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) + [Project 2](../../career-project-specs/02-rag-llm-service.md) | Bounded concurrency, timeouts, Python↔Go ADR | RAG lab exists |
| 5 | **Rust CLI** (fast, safe, clean) | Systems + ops credibility | [Project 14 stretch](../../career-project-specs/14-devops-cli-lab.md) + [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/) | Flags, exit codes, structured output | Sandbox exists |
| 6 | **IoT / edge ingest** | Edge niche (Bosch, Arm, Ocado Robotics) | [Project 20](../../career-project-specs/20-iot-edge-lab.md) | MQTT QoS, idempotent telemetry, offline buffer | Not started |
| 7 | **Distributed system** (small is fine) | End-to-end systems thinking | [Project 21](../../career-project-specs/21-integrated-platform-capstone.md) | Compose orchestration, cross-service `request_id`, E2E demo | After spine |

### Supporting ideas (already in playbook)

| Idea | Spec | Role in the story |
|------|------|-------------------|
| RAG / LLM + evals | [Project 2](../../career-project-specs/02-rag-llm-service.md) | AI automation on LinkedIn About |
| SQL under load + vectors | [Project 4](../../career-project-specs/04-sql-performance-lab.md) | Data layer credibility |
| Observability | [Project 3](../../career-project-specs/03-observability-lab.md) | Production-shaped claims |
| Contract-first API | [Project 5](../../career-project-specs/05-contract-first-api.md) | Service boundaries before Go/Rust split |
| TypeScript HTTP / BFF | [Project 7](../../career-project-specs/07-node-typescript-lab.md) | TS in headline |
| Proxy / load balancer | [Project 17](../../career-project-specs/17-proxy-load-balancer-lab.md) | Systems depth |
| WASM secure component | [Project 19](../../career-project-specs/19-wasm-secure-component-lab.md) | Security/sandboxing signal |
| Cloud deploy | [Project 15](../../career-project-specs/15-cloud-deploy-lab.md) | Cloud-ready services |
| Automation bot | [Project 10](../../career-project-specs/10-automation-bot-lab.md) | Automation pipelines |
| LLM web app | [Project 11](../../career-project-specs/11-llm-web-app-lab.md) | User-facing AI integration |

### GitHub / interview bar (every pinned repo)

- Clean commits; README with runnable demo
- Tests (unit + at least one integration path)
- `docs/portfolio/` — diagram, ADR, perf numbers, failure modes, observability ([template](../templates/portfolio-artifacts.md))
- **CI pipeline** (lint + test on PR) — [Project 15](../../career-project-specs/15-cloud-deploy-lab.md)
- Benchmarks where relevant (Projects **8** and **18** — p95 + peak RSS)
- `scripts/demo.sh` or equivalent for reviewers

---

## UK role categories you fit

| Category | Playbook fit | Notes |
|----------|--------------|-------|
| **Backend Engineer (Rust + Go)** | **Primary** | Projects 8, 18, 7, 5; capstone 21 |
| **Systems Engineer (Rust)** | Secondary | Projects 17, 18, 19 |
| **Security / Cryptography** | Partial | Projects 9, 19 — not crypto specialist track |
| **IoT / Embedded Firmware** | Partial | Project 20 = MQTT edge — not ESP32 firmware depth |
| **Blockchain / Crypto Core** | Not in spine | Deferred in [rust.md](../languages/rust.md) — optional pivot only |

---

## What UK employers ask vs playbook

Researched Monzo, fintech backend, infra Rust, and trading/HFT (London). Your £80k target = **fintech backend** band, not HFT.

| Employer ask | Who asks | Playbook | Gap |
|--------------|----------|----------|-----|
| Distributed systems + resilient software | Monzo, most backend | Strong — 1, 6, 8, 16, 21 | None |
| Go + strongly typed backend | Monzo, fintech | Strong — Project 8 | None |
| Rust + Tokio async | Monzo (growing), infra | Good — Project 18 | Minor — Tokio named in P18 |
| Idempotency, at-least-once, DLQ | Universal | Strong — 1, 6, 8, 14 | None |
| Postgres + SQL | Most backend | Strong — Project 4 | None |
| Kafka | Monzo onboarding, scale-ups | Stretch + [messaging doc](../concepts/messaging-and-rpc.md) | Medium — vocabulary + optional hands-on |
| Kubernetes + Docker | Monzo, cloud-native | Good — 15, 16 | Minor |
| AWS + Linux ops | Monzo, Keyrock | Partial — Project 15 (ECS/EKS examples) | Low |
| gRPC / service RPC | Monzo (Envoy), fintech profiles | Stretch on Project 8 + [messaging doc](../concepts/messaging-and-rpc.md) | Medium |
| CI/CD (GitHub Actions) | Every employer | **Required** in Project 15 | Closed by spec update |
| Prometheus + Grafana | Monzo profiles, K8s roles | **Required** `/metrics` in Project 8 | Closed by spec update |
| OpenTelemetry | Infra, modern backend | Good — Project 3 | Minor |
| Performance benchmarking | Systems, trading | Good — Project 18 ADR | None |
| Python secondary | AI backends, trading | Strong — 2, 10, 11 | None |
| OAuth / OIDC | B2B SaaS, fintech | Stretch on Project 12 | Medium |
| JWT + multi-tenant | SaaS/fintech | Strong — Project 12 | None |
| Event sourcing / µs latency | Citi HFT, trading | Not in spine | **Skip** — different market |
| Blockchain / OMS / market data | Crypto firms | Deferred | Skip unless pivot |
| Property-based testing | Security, trading QA | Stretch — `proptest` on Project 18 | Low |
| Cassandra | Monzo-specific | Not in spine | Skip — Postgres covers data layer |
| Chaos engineering | Large SRE | Not in spine | Low priority for £80k backend |

### Monzo-shaped profile (what onboarding looks like)

Monzo hires backend engineers agnostic to stack — they teach **Go, Kafka, Cassandra, K8s, Docker, AWS** on the job. Your playbook proves **Redis/Docker/Go/Rust + idempotency + observability** — the same reliability patterns with simpler local tooling. In interviews: *"Same idempotency semantics whether Redis or Kafka; I can ramp on your broker."*

### Do not chase

- HFT microsecond latency, market data, FIX, KDB, C++/FPGA
- Event sourcing at trading-firm scale
- Blockchain OMS / validator nodes (unless explicit pivot)
- Full embedded firmware / ESP32 drivers
- Cassandra (Monzo-specific; Postgres + Redis is enough for portfolio)

---

## £80k-ready milestones

£80k readiness = **evidence of systems thinking under production constraints**, not a language checklist.

### Minimum credible (interview-ready Rust+Go backend)

Ship with full portfolio artifacts:

1. [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) — webhook + HMAC + idempotency
2. [Project 6](../../career-project-specs/06-async-worker-stretch.md) — async worker + DLQ
3. [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) — Go gateway + worker (**spine milestone**)
4. [Project 3](../../career-project-specs/03-observability-lab.md) — observability on a real service
5. [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) — Rust reimplementation + Go vs Rust ADR (p95 + peak RSS)
6. [Project 15](../../career-project-specs/15-cloud-deploy-lab.md) — deploy + CI + health checks

**Interview narrative:** *"Webhook ingress → queue → Go worker → Python RAG boundary → Rust hot-path ADR with measured tradeoffs → deployed with observability and CI."*

### Full differentiation (capstone + AI)

Add Projects **2, 11, 21** for **backend + AI automation systems** — matches LinkedIn About; separates you from Rust-only candidates.

---

## GitHub pin order

Pin repos that tell the **Go + Rust systems** story first (PHP stays in headline for commercial credibility):

1. **Go retrieval worker** (Project 8) — throughput + idempotency + Prometheus
2. **Rust hot-path** (Project 18) — ADR with benchmarks
3. **Platform capstone** (Project 21) — distributed system demo
4. **Webhook receiver** (Project 1) — integration foundation
5. **RAG service** (Project 2) — AI automation angle

Each pinned repo: README demo, **CI badge**, `docs/portfolio/`, clean history.

---

## Interview themes (emphasise after each lab)

| Theme | Where you prove it |
|-------|-------------------|
| **Idempotency** | Projects 1, 6, 8 — "transport may duplicate; business effect runs once" |
| **Concurrency + backpressure** | Project 8 — bounded goroutines, context cancel |
| **Memory safety** | Project 18 — ownership, `Result`, no panic in hot path |
| **Async runtimes** | Project 18 — Tokio after sync path solid |
| **Distributed systems** | Project 21 — trace `request_id` across 3+ services |
| **Observability** | Project 3 — structured logs, metrics, correlation |
| **Reliability patterns** | DLQ, retry backoff, health checks, rollback (1, 6, 14, 15) |
| **Performance ADR** | Project 18 — p95 + peak RSS, not "Rust is faster" |

---

## Suggested priority (Steps 1, 2, 4 started)

```
Now     → Project 3 (obs on RAG lab) → Project 5 or 6 → Project 8 (Go) → Project 18 (Rust)
Parallel → Project 9 reading, rust-cli-http-probe sandbox
Later   → 11, 15, 21 for AI + deploy flagship story
```

You do **not** need all 21 projects for £80k readiness — minimum credible milestone above is the bar; capstone is the stretch differentiator.

---

## LinkedIn ↔ playbook

- **Headline** — Backend & Systems Engineer with PHP/SQL/JS + Python/Go/Rust/TS is correct
- **Featured repos** — lead with Go + Rust evidence (Projects 8, 18, 21), not PHP
- **About** — tie AI/RAG claims to Project 2/11 portfolio artifacts when shipped

---

## See also

- [Engineering pillars](../concepts/engineering-pillars.md) — optional topic index
- [Portfolio artifacts](../templates/portfolio-artifacts.md)
- [Production readiness](../../checklists/production-readiness.md)
- [Rust career positioning](../languages/rust.md#career-positioning)
