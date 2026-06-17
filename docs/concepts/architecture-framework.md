# Architecture framework

**Read this first.** Modern backend work is architectural work. Every lab in this playbook practices decisions under **five pillars**. Projects, languages, career docs, and checklists all map here — the framework is the spine; everything else is evidence and practice.

**Path:** [Architecture framework](architecture-framework.md) (you are here) → [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) → [PROGRESS.md](../../PROGRESS.md)

**Quality bar example:** [sample portfolio](../examples/sample-portfolio/) — filled diagram, ADR, and failure modes tagged by pillar.

---

## Why architecture is the backbone

Architecture is the set of **choices that are expensive to reverse**: how work is split, how data flows, what fails and how, and what you optimize for (latency, cost, consistency, operability).

Two lenses show up in hiring — **production first** in this playbook, **interview SD** as a whiteboard layer on top:

| Lens | What it emphasizes | Where in this playbook |
|------|-------------------|------------------------|
| **Production architecture** | Boundaries, contracts, queues, databases, observability, failure modes in shipped systems | Five pillars below + portfolio artifacts |
| **Interview system design** | Scale estimates, classic problems, tradeoff narration | [System design interview map](../career/system-design-interview-map.md) |

Where backend engineers are heading: **integration-first platforms** (webhooks, queues, workers), **AI systems boundaries** (Python for LLM logic, Go/Rust for throughput), and **operational credibility** (idempotency, DLQ, structured logs, deploy/rollback). Senior signal = end-to-end shape + explicit failure modes + measured performance + credible ADRs.

---

## Reference architecture

Every lab connects to this shape — even when you build one slice at a time:

```text
Partner / Boomi / n8n trigger
    → PHP or Node webhook (sign, idempotency, fast 2xx)     [Pillar 1 + 2 + 5]
    → queue / outbox                                         [Pillar 2]
    → Go worker (retries, DLQ, concurrent fan-out)           [Pillar 1 + 2 + 4]
    → Python RAG service (evals, citations, guardrails)      [Pillar 1 + 3]
    → Go retrieval gateway (chunk fetch, timeouts)           [Pillar 4]
    → Postgres (SQL correctness, indexes, vectors)           [Pillar 3]
```

**Pillar 1 deep dive:** [Systems integration architect — Pillar 1](systems-integration-architect.md)

---

## The five pillars

### Pillar 1 — System shape (highest leverage)

**Decisions you make:**

- Where does HTTP end and durable work begin? (fast 2xx + queue vs long sync request)
- Sync vs async at each integration edge
- Service boundaries — who owns retrieval, LLM, ingress
- Modular monolith vs microservices — **playbook default: monolith first**

**Playbook stance:** Draw system shape before opening an IDE. One diagram per shipped lab beats none.

**Deep docs:** [systems-integration-architect.md](systems-integration-architect.md) · [software-engineering.md § Architectural patterns](software-engineering.md#architectural-patterns)

**Example ADR prompts:** SQLite vs Postgres for idempotency store; why Go owns retrieval not Python; compose-orchestrated capstone vs monorepo.

**Primary projects:** 1, 5, 7, 8, 11, 22

---

### Pillar 2 — Integration and messaging

**Decisions you make:**

- Delivery semantics — at-most / at-least / effectively-once (via idempotency)
- Broker choice — Redis vs Kafka vs DB outbox
- API style — REST/OpenAPI vs gRPC vs webhooks
- Idempotency keys, DLQ, replay

**Playbook stance:** Design for duplicate delivery first; narrow the window where it hurts. Master idempotency + DLQ on **one** broker before adding a second.

**Deep docs:** [messaging-and-rpc.md](messaging-and-rpc.md) · [software-engineering.md § Integration](software-engineering.md#integration-sync-async-and-messaging) · [integration-hardening.md](../../checklists/integration-hardening.md)

**Example ADR prompts:** Redis vs DB outbox for queue; ack before vs after handler commit; REST vs gRPC for Python↔Go.

**Primary projects:** 1, 6, 8, 10, 23, 24

---

### Pillar 3 — Data architecture

**Decisions you make:**

- Schema, indexes, transactions — hot query paths
- Multi-tenancy — row-level `tenant_id` vs Postgres RLS
- CAP vocabulary — consistency vs availability; replication lag (study for SD interviews)

**Playbook stance:** Prove data-layer choices with `EXPLAIN ANALYZE` and explicit transaction boundaries.

**Deep docs:** [database-design.md](database-design.md) · [Project 12 spec](../../career-project-specs/12-multi-tenant-auth-lab.md)

**Example ADR prompts:** Partial vs covering index for hot query; JWT claims vs session for tenant context; Postgres FTS vs external search engine.

**Primary projects:** 4, 2, 8, 12, 25

---

### Pillar 4 — Performance and language boundaries

**Decisions you make:**

- Measure → profile → fix before rewriting
- Python vs Go vs Rust — same contract, evidence-based ADR
- Caching, fan-out on write vs read, rate limiting

**Playbook stance:** Go-first for throughput; Rust optional with p95 + RSS evidence. No rewrite without a profile.

**Deep docs:** [memory-and-performance.md](memory-and-performance.md) · [performance templates](../templates/)

**Example ADR prompts:** Why Go owns retrieval boundary; token bucket vs sliding window; trie in-memory vs DB-backed prefix index.

**Primary projects:** 4, 8, 18, 19 (optional), 23, 25

---

### Pillar 5 — Reliability, security, operations

**Decisions you make:**

- Observability — correlation IDs, logs/metrics/traces, SLO thinking
- Failure modes — partial outage, duplicate delivery, cache stampede
- Security at edges — HMAC, CSRF, tenant isolation
- Deploy and rollback — health checks, CI gates

**Playbook stance:** Every lab documents **three failure modes** without its mitigations. Gate milestones with [production-readiness.md](../../checklists/production-readiness.md).

**Deep docs:** [production-readiness.md](../../checklists/production-readiness.md) · [software-engineering.md § Observability](software-engineering.md#observability-logs-metrics-traces) · Projects 3, 9, 16

**Example ADR prompts:** JSON log schema; session vs token auth; cloud target and rollback strategy.

**Primary projects:** 3, 9, 12, 14, 15, 16 (+ failure modes on **every** lab)

---

## Project ↔ pillar matrix

● = primary practice · ○ = secondary / touched

| Step | Project | P1 Shape | P2 Integration | P3 Data | P4 Performance | P5 Reliability |
|------|---------|:--------:|:--------------:|:-------:|:--------------:|:--------------:|
| 1 | Webhook receiver | ● | ● | ○ | | ● |
| 2 | RAG / LLM | ● | ○ | ● | ○ | ● |
| 3 | Observability | | | | | ● |
| 4 | SQL performance | ○ | | ● | ● | ○ |
| 5 | Contract-first API | ● | ● | ○ | | ○ |
| 6 | Async worker | ● | ● | ○ | ○ | ● |
| 7 | Node / TS | ● | ● | | | ○ |
| 8 | Go retrieval + worker | ● | ● | ● | ● | ● |
| 9 | App security | ○ | ○ | | | ● |
| 10 | Automation bot | ● | ● | | | ● |
| 11 | LLM web app | ● | ○ | | | ● |
| 12 | Multi-tenant auth | ● | ○ | ● | | ● |
| 13 | Real-time dashboard | ● | ○ | | ○ | ● |
| 14 | Shell automation | | | | | ● |
| 15 | DevOps CLI | ○ | ● | | | ● |
| 16 | Cloud deploy | ○ | | | | ● |
| 17 | K8s controller | ● | ● | | | ● |
| 18 | Proxy / LB | ● | | | ● | ● |
| 19 | Rust hot-path (opt) | ● | | | ● | ● |
| 20 | WASM (opt) | ● | | | ● | ● |
| 21 | IoT edge | ● | ● | ○ | ○ | ● |
| 22 | Capstone | ● | ● | ● | ● | ● |
| 23 | Rate limiter (opt) | ○ | ○ | | ● | ● |
| 24 | Notifications (opt) | ● | ● | ○ | ● | ● |
| 25 | Search (opt) | ○ | ○ | ● | ● | ○ |

**Minimum credible bar (Go-first):** at least one **shipped** lab with ● in **each pillar** before capstone 22:

| Pillar | Minimum shipped lab |
|--------|---------------------|
| 1 System shape | Project 1 |
| 2 Integration & messaging | Project 6 |
| 3 Data architecture | Project 4 |
| 4 Performance & language | Project 8 (+ Project 4 or 18 for numbers) |
| 5 Reliability, security, ops | Project 3 (+ Project 14 or 16 for deploy/ops) |

See [target-alignment.md](../career/target-alignment.md) for the full £80k milestone list.

---

## Portfolio proof

Each lab repo accumulates `docs/portfolio/` tagged to pillars — see [portfolio-artifacts.md](../templates/portfolio-artifacts.md):

| Artifact | Typical pillar(s) |
|----------|-------------------|
| Architecture diagram | 1 (boundaries, sync vs async paths) |
| ADR | Tag `**Pillar:** N` for the decision's home pillar |
| Performance numbers | 4 |
| Failure modes | 5 |
| Observability evidence | 5 |

Log milestones in [PROGRESS.md](../../PROGRESS.md) with **Pillar(s)**, **Tradeoff**, and **Failure mode** fields.

---

## Interview appendix (not a sixth pillar)

[System design interview map](../career/system-design-interview-map.md) maps classic whiteboard problems to labs. In interviews, narrate **pillar tradeoffs at scale** — e.g. fan-out on write (Pillar 4 + 2), idempotency under retry (Pillar 2), tenant isolation (Pillar 3).

[Big Tech benchmark](../career/big-tech-benchmark.md): production pillars + parallel DSA/SD drills.

---

## Quick reference — pillar one-liners

| # | Pillar | One-line focus |
|---|--------|----------------|
| 1 | System shape | Boundaries, sync vs async, who owns what |
| 2 | Integration & messaging | Delivery semantics, brokers, idempotency, DLQ |
| 3 | Data architecture | Schema, indexes, tenancy, consistency |
| 4 | Performance & language boundaries | Measure first; Python/Go/Rust splits |
| 5 | Reliability, security, operations | Observability, failure modes, deploy |

**Next:** [Project 1 — Integration webhook receiver](../../career-project-specs/01-integration-webhook-receiver.md)
