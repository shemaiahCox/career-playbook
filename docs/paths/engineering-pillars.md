# Engineering pillars — full project catalog

**Use this:** Navigate the playbook by **five engineering pillars** (AI/Automation, Full-Stack, DevOps/Cloud, Security/Systems, IoT/Edge). Each pillar has **dedicated project specs** (P1–P23). Every spec includes a **Concept spotlight**—what you implement and how you explain it in interviews.

**Companion:** [Project catalog](../../career-project-specs/README.md) · [Learning journey — View C](learning-journey.md#view-c--pillars-and-waves) · [Concept matrix](#concept--project-matrix)

**Rule:** **One active milestone** at a time. The catalog is the full backlog (~18–36 months), not five parallel half-finished repos.

---

## Five pillars at a glance

| Pillar | Stack emphasis | Wave 1 (P1–P9) | Wave 2 (P10–P16) | Wave 3 (P17–P23) |
|--------|----------------|----------------|------------------|------------------|
| **AI & Automation** | Python, Go, TS | P1, P4, P5, P9 | P10, P11 | — |
| **Full-Stack Platforms** | TS, Go, SQL | P2, P6, P7 | P12, P13 | — |
| **DevOps & Cloud** | Go, Rust | P3 | P15, P16 | P17, P18 |
| **Security & Systems** | Rust, any | P1, P8 | — | P21, P22 |
| **IoT & Edge** | Rust, Python, TS | — | — | P23 |

**Integrated capstone:** Wire P1 → P5 → P9 → P4 → P7; extend with P12/P13 when ready. One diagram in the active lab README.

---

## Pillar 1 — AI & Automation (Python + Go + TS)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| P1 | Integration / automation ingress | [01](../career-project-specs/01-integration-webhook-receiver.md) | Idempotency, HMAC, DLQ, fast ack |
| P4 | RAG / AI-powered API | [04](../career-project-specs/04-rag-llm-service.md) | RAG, evals, citations, guardrails |
| P5 | Async data pipeline | [05](../career-project-specs/05-async-worker-stretch.md) | At-least-once, idempotency (worker), DLQ |
| P9 | Retrieval + pipeline worker | [09](../career-project-specs/09-go-retrieval-worker-lab.md) | Concurrency, timeouts, ingest |
| P10 | Automation bot / workflow connector | [10](../career-project-specs/10-automation-bot-lab.md) | Workflow steps, secrets, idempotent side effects |
| P11 | LLM-integrated web app | [11](../career-project-specs/11-llm-web-app-lab.md) | BFF, streaming UX, eval-aware errors |

---

## Pillar 2 — Full-Stack Platforms (TS + Go/Rust)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| P2 | Contract-first API | [02](../career-project-specs/02-contract-first-api.md) | OpenAPI, versioning, breaking-change discipline |
| P6 | Node/TS HTTP service | [06](../career-project-specs/06-node-typescript-lab.md) | Typed API, webhooks, queue track |
| P7 | SQL / data under load | [07](../career-project-specs/07-sql-performance-lab.md) | Plans, indexes, vectors, transactions |
| P12 | Auth + multi-tenant SaaS slice | [12](../career-project-specs/12-multi-tenant-auth-lab.md) | Tenant isolation, JWT/session, row scoping |
| P13 | Real-time dashboard | [13](../career-project-specs/13-realtime-dashboard-lab.md) | SSE/WebSocket, backpressure, reconnect |

High-traffic API patterns combine P2, P6, and P9—not a separate spec.

---

## Pillar 3 — DevOps & Cloud (Go + Rust)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| P3 | Observability foundations | [03](../career-project-specs/03-observability-lab.md) | Structured logs, request_id, latency |
| P15 | CLI / ops tool | [15](../career-project-specs/15-devops-cli-lab.md) | Flags, exit codes, DLQ replay |
| P16 | Infra automation + deploy | [16](../career-project-specs/16-cloud-deploy-lab.md) | Compose, secrets, health checks, managed queue |
| P17 | K8s operator / controller-lite | [17](../career-project-specs/17-k8s-controller-lab.md) | Reconcile loop, idempotent apply |
| P18 | Proxy / load-balancer lab | [18](../career-project-specs/18-proxy-load-balancer-lab.md) | Timeouts, pooling, graceful shutdown |

Prep: [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/) · [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/)

---

## Pillar 4 — Security & Systems (Rust)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| P8 | OWASP + integration security | [08](../career-project-specs/08-application-security-lab.md) | SQLi, XSS, CSRF, session hygiene |
| P21 | Rust hot-path reimplementation | [21](../career-project-specs/21-rust-hot-path-lab.md) | Same P9 contract, Go vs Rust ADR |
| P22 | WASM / secure network component | [22](../career-project-specs/22-wasm-secure-component-lab.md) | Sandboxed logic, FFI boundaries |

P1 HMAC covers integration-edge trust alongside P8.

---

## Pillar 5 — IoT & Edge (Rust + Python + TS)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| P23 | Edge ingest + local inference | [23](../career-project-specs/23-iot-edge-lab.md) | MQTT, idempotent telemetry, offline buffer, dashboard hook |

P13 shares the real-time dashboard pillar with Full-Stack.

---

## Waves and dependencies

| Wave | Months (illustrative) | Specs | Goal |
|------|----------------------|-------|------|
| **1 — Foundation** | 1–12 | P1 → P4/P3 → P2 → P5/P9 → P6 → P7 → P8 | Shared habits + capstone |
| **2 — Pillar depth** | 12–24 | P10, P11, P12, P13, P15, P16 | Dedicated pillar projects |
| **3 — Advanced** | 24–36 | P17, P18, P21, P22, P23 | K8s, Rust systems, IoT |

**Dependencies (highlights):**

- P10 after P1 + P4 · P11 after P4 + P6 · P12 after P2/P6 + P7
- P13 after P5/P9 · P15 after P5 · P16 after P9
- P17 after P16 · P21 after P9 Go green · P23 after P5 + P7

**Controlled parallelism:** P7 drills or P8 reading while another spec is spine—not a second ship target.

---

## Concept → project matrix

| Concept | Primary | Also practiced in |
|---------|---------|-------------------|
| **Idempotency** | P1 | P5, P6-C, P9, P10, P12, P17, P23 |
| HMAC / webhook trust | P1 | P10, P8 |
| Dead letter / replay | P1, P5 | P15 |
| At-least-once delivery | P5 | P9, P17, P23 |
| OpenAPI / contracts | P2 | P4↔P9, P6-B, P11 |
| RAG + eval regression | P4 | P11, P23 |
| Observability | P3 | All labs (request_id) |
| SQL plans / vectors | P7 | P4, P9, P12 |
| Auth + tenant isolation | P12 | P11, P8 |
| Real-time push | P13 | P9, P23 |
| Cloud deploy / ops | P16 | P17 |
| Rust safety / perf ADR | P21 | P18, P22 |
| Edge / MQTT | P23 | P10 |

---

## LinkedIn alignment

**Headline themes:** AI Systems · Cloud · Automation · IoT-adjacent · **Go · Python · Rust · TypeScript · SQL · PHP**

The playbook spine matches; PHP stays ship-today ingress (P1/P2); Rust and IoT are Wave 2–3 depth.

---

## Related

- [Learning journey](learning-journey.md)
- [Systems integration architect](systems-integration-architect.md)
- [FOCUS.md](../../FOCUS.md)
