# Engineering pillars — topic index (optional)

**Use this:** Browse projects by **domain topic** (AI, full-stack, DevOps)—**not** the main learning path.

**Learning order is now the [7-phase path](../../README.md#roadmap).** Tables below still mention v1 Project numbers — those specs live in [archive/v1-22-step](../../archive/v1-22-step/README.md).

**Reading order:** [Architecture framework](architecture-framework.md) → [README progression](../../README.md#roadmap) → return here only to browse old topic tags.

> **Not the learning path.** Follow projects in order unless you are cross-indexing completed labs.

Browse by **engineering pillar** when you want every project that touches a **domain topic**. For **architectural decision types** (shape, integration, data, performance, ops), use the [five-pillar framework](architecture-framework.md) instead.

**Companion:** [Phase catalog](../../README.md#roadmap) · [Concept matrix](#concept--project-matrix) · [SDLC map](sdlc-playbook-map.md)

---

## Five pillars at a glance

These engineering pillars group projects by domain topic. They complement — but do not replace — the five **architecture** pillars in the framework doc.

| Pillar | Stack emphasis | Wave 1 (Project 1–Project 8) | Wave 2 (Project 10–Project 16) | Wave 3 (Project 17–Project 21) |
|--------|----------------|----------------|------------------|------------------|
| **AI & Automation** | Python, Go, TypeScript (TS) | Project 1, Project 2, Project 6, Project 8 | Project 10, Project 11 | — |
| **Full-Stack Platforms** | TS, Go, SQL | Project 5, Project 7, Project 4 | Project 12, Project 13 | — |
| **DevOps & Cloud** | Bash, Go, Rust | Project 3 | Project 14, Project 15, Project 16 | Project 17, Project 18 |
| **Security & Systems** | Rust, any | Project 1, Project 9 | — | Project 19, Project 20 |
| **IoT & Edge** | Rust, Python, TS | — | — | Project 21 |

**Integrated capstone:** [Project 22 — Integrated platform capstone](../../archive/v1-22-step/career-project-specs/22-integrated-platform-capstone.md) composes Projects 1–21 into one deployable flagship system (orchestration repo + linked `docs/portfolio/` per lab).

---

## Pillar 1 — AI & Automation (Python + Go + TS)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| Project 1 | Integration / automation ingress | [01](../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md) | Idempotency, HMAC, DLQ, fast ack |
| Project 2 | RAG / AI-powered API | [02](../archive/v1-22-step/career-project-specs/02-rag-llm-service.md) | RAG, evals, citations, guardrails |
| Project 6 | Async data pipeline | [06](../archive/v1-22-step/career-project-specs/06-async-worker-stretch.md) | At-least-once, idempotency (worker), DLQ |
| Project 8 | Retrieval + pipeline worker | [08](../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) | Concurrency, timeouts, ingest |
| Project 10 | Automation bot / workflow connector | [10](../archive/v1-22-step/career-project-specs/10-automation-bot-lab.md) | Workflow steps, secrets, idempotent side effects |
| Project 11 | LLM-integrated web app | [11](../archive/v1-22-step/career-project-specs/11-llm-web-app-lab.md) | Backend for Frontend (BFF), streaming UX, eval-aware errors |

---

## Pillar 2 — Full-Stack Platforms (TS + Go/Rust)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| Project 5 | Contract-first API | [05](../archive/v1-22-step/career-project-specs/05-contract-first-api.md) | OpenAPI, versioning, breaking-change discipline |
| Project 7 | Node/TS HTTP service | [07](../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md) | Typed API, webhooks, queue track |
| Project 4 | SQL / data under load | [04](../archive/v1-22-step/career-project-specs/04-sql-performance-lab.md) | Plans, indexes, vectors, transactions |
| Project 12 | Auth + multi-tenant SaaS slice | [12](../archive/v1-22-step/career-project-specs/12-multi-tenant-auth-lab.md) | Tenant isolation, JWT/session, row scoping |
| Project 13 | Real-time dashboard | [13](../archive/v1-22-step/career-project-specs/13-realtime-dashboard-lab.md) | Server-Sent Events (SSE)/WebSocket, backpressure, reconnect |

High-traffic API patterns combine Project 5, Project 7, and Project 8 — not a separate spec.

---

## Pillar 3 — DevOps & Cloud (Bash + Go + Rust)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| Project 3 | Observability foundations | [03](../archive/v1-22-step/career-project-specs/03-observability-lab.md) | Structured logs, request_id, latency |
| Project 14 | Shell automation toolkit | [14](../archive/v1-22-step/career-project-specs/14-shell-automation-lab.md) | Strict mode, smoke scripts, shellcheck, bats |
| Project 15 | CLI / ops tool | [15](../archive/v1-22-step/career-project-specs/15-devops-cli-lab.md) | Flags, exit codes, DLQ replay |
| Project 16 | Infra automation + deploy | [16](../archive/v1-22-step/career-project-specs/16-cloud-deploy-lab.md) | Compose, secrets, health checks; [Azure stretch](../career/azure-certification-track.md) optional |
| Project 17 | K8s operator / controller-lite | [17](../archive/v1-22-step/career-project-specs/17-k8s-controller-lab.md) | Reconcile loop, idempotent apply |
| Project 18 | Proxy / load-balancer lab | [18](../archive/v1-22-step/career-project-specs/18-proxy-load-balancer-lab.md) | Timeouts, pooling, graceful shutdown |

Per-project **Bash scripting milestone** sections in Projects 1–13 build skills before Project 14.

---

## Pillar 4 — Security & Systems (Rust)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| Project 9 | OWASP + integration security | [09](../archive/v1-22-step/career-project-specs/09-application-security-lab.md) | SQL injection (SQLi), Cross-Site Scripting (XSS), CSRF, session hygiene |
| Project 19 | Rust hot-path reimplementation | [19](../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) | Same Project 8 contract, Go vs Rust ADR |
| Project 20 | WebAssembly (WASM) / secure network component | [20](../archive/v1-22-step/career-project-specs/20-wasm-secure-component-lab.md) | Sandboxed logic, Foreign Function Interface (FFI) boundaries |

Project 1 HMAC covers integration-edge trust alongside Project 9.

---

## Pillar 5 — IoT & Edge (Rust + Python + TS)

| # | Project | Spec | Primary concepts |
|---|---------|------|------------------|
| Project 21 | Edge ingest + local inference | [21](../archive/v1-22-step/career-project-specs/21-iot-edge-lab.md) | Message Queuing Telemetry Transport (MQTT), idempotent telemetry, offline buffer, dashboard hook |

Project 13 shares the real-time dashboard pillar with Full-Stack.

---

## Waves and dependencies

| Wave | Months (illustrative) | Specs | Goal |
|------|----------------------|-------|------|
| **1 — Foundation** | 1–12 | Project 1 → Project 2/Project 3 → Project 5 → Project 6/Project 8 → Project 7 → Project 4 → Project 9 | Shared habits + bash milestones start |
| **2 — Pillar depth** | 12–24 | Project 10, Project 11, Project 12, Project 13, Project 14, Project 15, Project 16 | Shell automation + deploy |
| **3 — Advanced** | 24–36 | Project 17, Project 18, Project 19, Project 20, Project 21 | Kubernetes (K8s), Rust systems, IoT |
| **4 — Capstone** | After Wave 3 | [Project 22](../../archive/v1-22-step/career-project-specs/22-integrated-platform-capstone.md) | Flagship integrated platform demo |

**Dependencies (highlights):**

- Project 10 after Project 1 + Project 2 · Project 11 after Project 2 + Project 7 · Project 12 after Project 5/Project 7 + Project 4
- Project 13 after Project 6/Project 8 · Project 14 after Project 6 (and prior bash milestones) · Project 15 after Project 14 · Project 16 after Project 8
- Project 17 after Project 16 · Project 19 after Project 8 Go green · Project 21 after Project 6 + Project 4 · **Project 22 after Projects 1–21 green (or documented deferrals)**

**Controlled parallelism:** Project 4 drills or Project 9 reading while another spec is spine — not a second ship target.

---

## Concept → project matrix

| Concept | Primary | Also practiced in |
|---------|---------|-------------------|
| **Idempotency** | Project 1 | Project 6, Project 7-C, Project 8, Project 10, Project 12, Project 17, Project 21 |
| HMAC / webhook trust | Project 1 | Project 10, Project 9 |
| Dead letter / replay | Project 1, Project 6 | Project 15 |
| **Bash / shell automation** | Project 14 | Project 1, Project 4, Project 10, Project 16, Project 22 |
| At-least-once delivery | Project 6 | Project 8, Project 17, Project 21 |
| OpenAPI / contracts | Project 5 | Project 2↔Project 8, Project 7-B, Project 11 |
| RAG + eval regression | Project 2 | Project 11, Project 21 |
| Observability | Project 3 | All labs (request_id) |
| SQL plans / vectors | Project 4 | Project 2, Project 8, Project 12 |
| Auth + tenant isolation | Project 12 | Project 11, Project 9 |
| Real-time push | Project 13 | Project 8, Project 21 |
| Cloud deploy / ops | Project 16 | Project 17 · [Azure certification track](../career/azure-certification-track.md) |
| Rust safety / perf ADR | Project 19 | Project 18, Project 20 |
| Edge / MQTT | Project 21 | Project 10 |

---

## Related

- [Project catalog](../../README.md#roadmap)
- [Bash ecosystem map](../languages/bash.md)
- [Architecture framework](architecture-framework.md) — spine (read first)
- [Systems integration architect](systems-integration-architect.md) — Pillar 1 deep dive
- [README.md](../../README.md)
