# Career project specs — catalog

Numbered specs **P1–P23** organized by **engineering pillar** and **wave**. Each spec includes **Concept spotlight** (primary concepts + interview line).

**Navigation:** [Engineering pillars](../docs/paths/engineering-pillars.md) · [Learning journey](../docs/paths/learning-journey.md)

**Rule:** One **active** spec at a time. Status below is playbook intent—not your personal progress (log that in [PROGRESS.md](../PROGRESS.md)).

---

## Full catalog

| # | Spec | Pillar(s) | Wave | Stack | Primary concepts | Status |
|---|------|-----------|------|-------|------------------|--------|
| P1 | [Webhook receiver](01-integration-webhook-receiver.md) | AI/Automation, Security | 1 | PHP / TS | Idempotency, HMAC, DLQ | Lab exists |
| P2 | [Contract-first API](02-contract-first-api.md) | Full-Stack | 1 | Laravel / FastAPI / TS | OpenAPI, versioning | _TBD repo_ |
| P3 | [Observability](03-observability-lab.md) | DevOps/Cloud | 1 | Any | request_id, structured logs | On P4 lab |
| P4 | [RAG / LLM service](04-rag-llm-service.md) | AI/Automation | 1 | Python | RAG, evals, citations | Lab exists |
| P5 | [Async worker](05-async-worker-stretch.md) | AI/Automation, DevOps | 1 | PHP / Go / TS | At-least-once, idempotency, DLQ | _TBD repo_ |
| P6 | [Node / TS lab](06-node-typescript-lab.md) | Full-Stack, AI/Automation | 1 | TypeScript | Typed API, webhooks, queue | _TBD repo_ |
| P7 | [SQL performance](07-sql-performance-lab.md) | Full-Stack, AI/Automation | 1 | Postgres | Plans, indexes, vectors | Lab exists |
| P8 | [Application security](08-application-security-lab.md) | Security/Systems | 1 | Any | OWASP, integration edge | _TBD repo_ |
| P9 | [Go retrieval + worker](09-go-retrieval-worker-lab.md) | AI/Automation, DevOps | 1 | Go | Concurrency, retrieval gateway | _TBD repo_ |
| P10 | [Automation bot / workflow](10-automation-bot-lab.md) | AI/Automation | 2 | TS + Python | Workflow, idempotent steps | _TBD repo_ |
| P11 | [LLM web app](11-llm-web-app-lab.md) | AI/Automation, Full-Stack | 2 | TS + Python | BFF, streaming, eval errors | _TBD repo_ |
| P12 | [Multi-tenant + auth](12-multi-tenant-auth-lab.md) | Full-Stack | 2 | TS + SQL | Tenant isolation, JWT | _TBD repo_ |
| P13 | [Real-time dashboard](13-realtime-dashboard-lab.md) | Full-Stack, IoT/Edge | 2 | TS | SSE/WS, reconnect | _TBD repo_ |
| P15 | [DevOps CLI](15-devops-cli-lab.md) | DevOps/Cloud | 2 | Go | DLQ replay, ops flags | _TBD repo_ |
| P16 | [Cloud deploy](16-cloud-deploy-lab.md) | DevOps/Cloud | 2 | Compose + cloud | Deploy, secrets, health | _TBD repo_ |
| P17 | [K8s controller-lite](17-k8s-controller-lab.md) | DevOps/Cloud | 3 | Go | Reconcile, idempotent apply | _TBD repo_ |
| P18 | [Proxy / load balancer](18-proxy-load-balancer-lab.md) | DevOps/Cloud, Security | 3 | Go / Rust | Timeouts, graceful shutdown | _TBD repo_ |
| P21 | [Rust hot-path](21-rust-hot-path-lab.md) | Security/Systems | 3 | Rust | Go vs Rust ADR | _TBD repo_ |
| P22 | [WASM secure component](22-wasm-secure-component-lab.md) | Security/Systems | 3 | Rust | WASM, FFI boundaries | _TBD repo_ |
| P23 | [IoT / edge ingest](23-iot-edge-lab.md) | IoT/Edge | 3 | Rust/Go + Py + TS | MQTT, idempotent telemetry | _TBD repo_ |

Note: **P14** and **P19–P20** numbers reserved; catalog uses P15–P23 as in [engineering pillars](../docs/paths/engineering-pillars.md).

---

## By wave

| Wave | Specs |
|------|-------|
| **1 — Foundation** | P1, P2, P3, P4, P5, P6, P7, P8, P9 |
| **2 — Pillar depth** | P10, P11, P12, P13, P15, P16 |
| **3 — Advanced** | P17, P18, P21, P22, P23 |

---

## Spec template

Every spec follows: Problem → Career relevance → **Concept spotlight** → Code repo → Stack → Key concepts → Success criteria → Testing → Exploration scenarios → Stretch → Related.
