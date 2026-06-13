# Learning journey (easy to follow)

Three views of the same playbook: **dependency order** (View A), **calendar overlay** (View B), and **five engineering pillars** (View C). Every spec **P1–P23** includes a **Concept spotlight**. Study load-bearing handbook sections—do not skim—especially [Algorithms study path](algorithms-study-path.md) during P7, P9, and RAG retrieval work.

**Companion:** [README — Learning path](../../README.md#learning-path-suggested) · [Engineering pillars](engineering-pillars.md) · [Project catalog](../../career-project-specs/README.md) · [Systems integration architect](systems-integration-architect.md)

**Core stack:** JavaScript · TypeScript · PHP · SQL · Go · Python · Rust (Tier‑2) — [FOCUS.md](../../FOCUS.md). **Python + Go** = long-term growth lanes; **Rust** after P9 Go; **PHP, TypeScript, SQL** = ship-today ingress and data — [Growth lanes vs ship today](../../FOCUS.md#growth-lanes-vs-ship-today).

---

## AI, automation, and cloud — quick map

If your goal is **AI features + integration/automation + cloud-shaped ops**, use this table first—then follow **View A** below for order.

| Theme | What you are proving | Primary specs | Stack lane |
|-------|----------------------|---------------|------------|
| **AI (product)** | Grounded RAG, evals, citations, guardrails | [P4](../career-project-specs/04-rag-llm-service.md), [P3](../career-project-specs/03-observability-lab.md) | **Python** |
| **Automation** | Fast ack, idempotent steps, queues, DLQ (Boomi/n8n mental model) | [P1](../career-project-specs/01-integration-webhook-receiver.md), [P5](../career-project-specs/05-async-worker-stretch.md), [integration-automation](../stacks/integration-automation.md) | **PHP** or **TypeScript** ingress |
| **Throughput / scale** | Workers, retrieval fan-out, bounded concurrency | [P9](../career-project-specs/09-go-retrieval-worker-lab.md) (with P5) | **Go** (Rust Tier‑2 after P9 — [below](#rust-tier-2-after-p9-go)) |
| **Data / vectors** | Correct indexes, plans, chunk storage | [P7](../career-project-specs/07-sql-performance-lab.md) | **SQL** (Postgres) |
| **Cloud (practice)** | Containers, durable queues, optional single deploy | P7 Docker Compose; P5/P6/P9 queue + `docker compose` in lab README | Ops discipline—not a separate cert track |

**Who owns what (avoid duplicate repos):**

| Job | Owner | Not this |
|-----|--------|----------|
| LLM calls, eval JSONL, prompt boundaries | **Python (P4)** | A second “AI bot” repo in Go |
| Webhooks, partner HTTP, n8n nodes | **PHP (P1)** or **TS (P6)** | Rebuilding the same ingress in Go first |
| Queue drain, ingest jobs, `/retrieve` fan-out | **Go (P5/P9)** | Full REST monolith in Go; **Rust worker spine in parallel with unfinished P9** |
| Hot-path reimplementation (optional) | **Rust (Tier‑2)** after P9 Go green | Rust before any Go P9 artifact |
| Embeddings storage, vector indexes | **SQL (P7)** | Operating a separate vector DB product on day one |

**Start retrieval in Python (P4).** Move hot-path retrieval to **Go (P9)** only when profiling shows I/O concurrency is the bottleneck—see [P4 architecture split](../career-project-specs/04-rag-llm-service.md#architecture-split-python--go).

### Integrated capstone (one system, not five Go repos)

After P4 has a minimal `/query` + eval path and P9 core is green, wire **one** story (diagram in P9 README; contract in OpenAPI):

1. **Ingress** — P1 or P6 track C: webhook validates → enqueue.
2. **Durable work** — P5/P9 Go worker: ingest/normalize documents (optional stretch).
3. **Data** — P7 Postgres: chunks/embeddings; plans under load.
4. **AI path** — P4 calls P9 `POST /retrieve` → LLM + citations.
5. **Optional** — Event bus or WebSocket notify (P9 stretch) for “ingest complete.”

Log one ADR in [PROGRESS.md](../../PROGRESS.md) (e.g. Python-only retrieval vs Go gateway). Full architecture lens: [Systems integration architect](systems-integration-architect.md).

**Out of scope this year:** Full IoT/robotics/embedded curriculum; Milvus/Weaviate operator tracks; cloning Boomi/n8n; deep ML training; **Rust as a second active worker spine** — [FOCUS non-goals](../../FOCUS.md#non-goals-this-year).

### Rust Tier‑2 (after P9 Go)

**When:** After [P9](../career-project-specs/09-go-retrieval-worker-lab.md) success criteria are green—not in parallel as a second spine.

| Step | Action |
|------|--------|
| 1 | Optional anytime: [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/README.md) for ownership, `Result`, Cargo |
| 2 | Read [Rust ecosystem map](../stacks/rust.md) — when Rust vs Go vs Python |
| 3 | **P9 stretch:** reimplement in Rust → [P21](../career-project-specs/21-rust-hot-path-lab.md) | Same contract as Go |
| 4 | Log ADR in [PROGRESS.md](../../PROGRESS.md): Go vs Rust for this boundary (latency, ops, team, safety) |
| 5 | Optional IoT: [P23](../career-project-specs/23-iot-edge-lab.md) after P5 + P7 |

**LinkedIn alignment:** AI Systems · Cloud · Automation · **Go · Python · Rust · TypeScript · SQL · PHP** — playbook spine matches; Rust is depth after Go, not breadth on day one.

---

## Rules of thumb

1. **One active milestone** — Pick **one** spec as spine; ship its success criteria before starting the next. The full catalog is [P1–P23](../../career-project-specs/README.md)—not five parallel half-finished repos.
2. **Concept spotlight** — Each spec names 2–4 primary concepts + an **interview line**; reuse vocabulary (e.g. idempotency from P1 → P5 → P10 → P23).
3. **Controlled parallelism** — **OK:** P7 SQL drills or P8 reading while another spec is spine. **Not OK:** two Wave-2+ specs both chasing ship criteria.
4. **Concepts on demand** — Use **Key concepts** in the active spec and [stack maps](../stacks/README.md).
5. **Overlap is OK** — Calendar overlap; dependency order in View A still applies.

---

## View A — Dependency path (spine)

| Order | Phase theme | Specs | What you are practicing |
|-------|-------------|-------|-------------------------|
| 1 | Integration spine | [P1 — Webhook](../career-project-specs/01-integration-webhook-receiver.md) | Signatures, idempotency, Boomi-style fast ack, dead letters |
| 2 | Applied AI + ops | [P4 — RAG](../career-project-specs/04-rag-llm-service.md), [P3 — Observability](../career-project-specs/03-observability-lab.md) | Python LLM boundary, evals, structured logs |
| 3 | API contracts | [P2 — Contract-first API](../career-project-specs/02-contract-first-api.md) | OpenAPI, breaking-change discipline |
| 4 | Event-driven scale | [P5 — Async worker](../career-project-specs/05-async-worker-stretch.md), [P9 — Go lab](../career-project-specs/09-go-retrieval-worker-lab.md) | Queues, DLQ, Go workers + retrieval gateway |
| 5 | TypeScript API | [P6 — Node / TS](../career-project-specs/06-node-typescript-lab.md) | Core stack HTTP service, optional n8n node stretch |
| 4b | SQL depth | [P7 — SQL performance](../career-project-specs/07-sql-performance-lab.md) | Plans, indexes, transactions, vector-adjacent retrieval |
| 4c | Security | [P8 — Application security](../career-project-specs/08-application-security-lab.md) | OWASP + integration-edge security |
| 4d | Rust / advanced systems | [P21 — Rust hot-path](../career-project-specs/21-rust-hot-path-lab.md) (after P9 Go) | Formal Tier‑2; Go vs Rust ADR |

---

## View C — Pillars and waves

Navigate by **engineering pillar** or **wave**. Full tables: [Engineering pillars](engineering-pillars.md) · [Project catalog](../../career-project-specs/README.md).

| Wave | Months (illustrative) | Specs | Pillars covered |
|------|----------------------|-------|-----------------|
| **1 — Foundation** | 1–12 | P1–P9 | All pillars (baseline) |
| **2 — Pillar depth** | 12–24 | P10, P11, P12, P13, P15, P16 | AI/Automation, Full-Stack, DevOps |
| **3 — Advanced** | 24–36 | P17, P18, P21, P22, P23 | DevOps, Security/Systems, IoT/Edge |

| Pillar | Wave 2–3 specs (after foundation) |
|--------|-------------------------------------|
| **AI & Automation** | [P10](../career-project-specs/10-automation-bot-lab.md), [P11](../career-project-specs/11-llm-web-app-lab.md) |
| **Full-Stack Platforms** | [P12](../career-project-specs/12-multi-tenant-auth-lab.md), [P13](../career-project-specs/13-realtime-dashboard-lab.md) |
| **DevOps & Cloud** | [P15](../career-project-specs/15-devops-cli-lab.md), [P16](../career-project-specs/16-cloud-deploy-lab.md), [P17](../career-project-specs/17-k8s-controller-lab.md), [P18](../career-project-specs/18-proxy-load-balancer-lab.md) |
| **Security & Systems** | [P21](../career-project-specs/21-rust-hot-path-lab.md), [P22](../career-project-specs/22-wasm-secure-component-lab.md) |
| **IoT & Edge** | [P23](../career-project-specs/23-iot-edge-lab.md) (+ [P13](../career-project-specs/13-realtime-dashboard-lab.md) dashboard) |

**Concept index:** [Engineering pillars — concept matrix](engineering-pillars.md#concept--project-matrix)

---

## View B — Example calendar overlay (illustrative)

**Assumption:** ~6–10 focused hours/week.

| Notional weeks | Spine focus | Example primary action |
|----------------|-------------|-------------------------|
| **1–2** | Phase 1 (P1) | Ship webhook success criteria; run exploration scenarios |
| **3–5** | Phase 2 (P4 + P3) | RAG slice + structured logging on same service |
| **6–7** | Phase 3 (P2) | Contract-first API milestone |
| **7–8** | Go prep (sandbox) | [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/README.md) — CLI/HTTP only, not a lab milestone |
| **8–10** | Phase 4 (P5 + P9) | Queue + Go worker/retrieval; optional [integrated capstone](#integrated-capstone-one-system-not-five-go-repos) wiring |
| **11–12** | Phase 5 (P6) | Node/TS service with same integration habits |
| **13–18** | Wave 1 finish + capstone | P7, P8, integrated capstone wiring |
| **19–30** | Wave 2 (pillar depth) | P10 → P11 → P12 → P13 → P15 → P16 (one at a time) |
| **31+** | Wave 3 (advanced) | P17, P18, P21, P22, P23 |
| **Parallel** | P7 | Algorithms study path + Postgres exercises |
| **Parallel** | P8 | OWASP lab after or alongside P2/P6 |

Log tradeoffs in [PROGRESS.md](../../PROGRESS.md).

---

## Phase → reference study (build-aligned)

### [Software engineering breadth](../handbook/software-engineering.md)

| While you are in… | Study these sections |
|---------------------|----------------------|
| **P1** Webhook | [Integration](../handbook/software-engineering.md#integration-sync-async-and-messaging) · [Event-driven integration](../handbook/software-engineering.md#event-driven-integration) · [Security](../handbook/software-engineering.md#security-for-applications) |
| **P4** RAG + **P3** Observability | [Observability](../handbook/software-engineering.md#observability-logs-metrics-traces) · [Testing](../handbook/software-engineering.md#testing) · [Algorithms study path](algorithms-study-path.md) (retrieval hot paths) |
| **P2** Contract API | [REST](../handbook/software-engineering.md#rest) · [Versioning](../handbook/software-engineering.md#versioning-and-compatibility) |
| **P5** + **P9** Workers | [Integration](../handbook/software-engineering.md#integration-sync-async-and-messaging) · [Concurrency](../handbook/software-engineering.md#concurrency-basics) · [Algorithms study path](algorithms-study-path.md) |
| **P6** Node / TS | [REST](../handbook/software-engineering.md#rest) · [Language fundamentals](../handbook/language-fundamentals-comparison.md) |
| **P8** Security | [Security](../handbook/software-engineering.md#security-for-applications) |

### Ecosystem maps (core stack)

| Stack | Map |
|-------|-----|
| PHP / Laravel (P1/P2) | [php-laravel](../stacks/php-laravel.md) |
| Python / FastAPI (P4) | [python](../stacks/python.md) |
| Go (P9, P5 worker) | [go](../stacks/go.md) |
| Rust (Tier‑2, after P9) | [rust](../stacks/rust.md) |
| Node + TS (P6) | [node-typescript-backend](../stacks/node-typescript-backend.md) |
| SQL / Postgres (P7) | [sql](../stacks/sql.md) |
| Boomi / n8n patterns | [integration-automation](../stacks/integration-automation.md) |

### Sandboxes (syntax only)

| Sandbox | When |
|---------|------|
| [laravel-route-slice](../../exploration-projects/laravel-route-slice/) | Before/during P1 |
| [node-ts-http-probe](../../exploration-projects/node-ts-http-probe/) | Before/during P6 |
| [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/) | Before/during P9 |
| [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/) | Before P9 (syntax) or after P9 Go (Tier‑2 stretch prep) |

---

## Related

- [Engineering pillars](engineering-pillars.md) — full P1–P23 catalog by pillar
- [Project catalog](../../career-project-specs/README.md)
- [README](../../README.md) — Architectural narrative, quick links
- [Systems integration architect](systems-integration-architect.md)
- [Algorithms study path](algorithms-study-path.md)
