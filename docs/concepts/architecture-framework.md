# Architecture framework

**Use this:** **Read this first.** Every lab practices decisions under **five pillars**—the spine that maps projects, languages, and checklists.

**Reading order:**

1. **You are here** — five pillars + reference architecture
2. Pillar deep docs (learning-first: plain English + [Technical reference](#technical-reference) at bottom):
   - Pillar 1 → [Systems integration architect](systems-integration-architect.md)
   - Pillar 2 → [Messaging and RPC](messaging-and-rpc.md)
   - Pillar 3 → [Database design](database-design.md)
   - Pillar 4 → [Memory and performance](memory-and-performance.md) · [Concurrency runtime model](concurrency-runtime-model.md)
   - Pillar 5 → [Software engineering § Observability](software-engineering.md#observability-logs-metrics-traces) · [Azure cloud and AI](azure-cloud-and-ai.md) (cert overlay)
3. [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) → [PROGRESS.md](../../PROGRESS.md)

**Companion:** [Architecture checklist](../../checklists/architecture-checklist.md) · [Sample portfolio](../examples/sample-portfolio/)

Modern backend work is architectural work. Projects, languages, career docs, and checklists all map here — the framework is the spine; everything else is evidence and practice.

**Quality bar example:** [sample portfolio](../examples/sample-portfolio/) — filled diagram, Architecture Decision Record (ADR), and failure modes tagged by pillar.

**Full lifecycle checklist:** [architecture-checklist.md](../../checklists/architecture-checklist.md) — real-world questions from feasibility through scale (usable outside the lab path).

---

## Why architecture is the backbone

Architecture is the set of **choices that are expensive to reverse**: how work is split, how data flows, what fails and how, and what you optimize for (latency, cost, consistency, operability).

Two lenses show up in hiring — **production first** in this playbook, **interview system design** as a whiteboard layer on top:

| Lens | What it emphasizes | Where in this playbook |
|------|-------------------|------------------------|
| **Production architecture** | Boundaries, contracts, queues, databases, observability, failure modes in shipped systems | Five pillars below + portfolio artifacts |
| **Interview system design** | Scale estimates, classic problems, tradeoff narration | [System design interview map](../career/system-design-interview-map.md) |

Where backend engineers are heading: **integration-first platforms** (webhooks, queues, workers), **AI systems boundaries** (Python for Large Language Model (LLM) logic, Go/Rust for throughput), and **operational credibility** (idempotency, Dead Letter Queue (DLQ), structured logs, deploy/rollback). Senior signal means end-to-end shape plus explicit failure modes, measured performance, and credible ADRs.

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

The diagram reads top to bottom as a single event flow. A partner system or integration platform (Boomi, n8n) fires a trigger. Your ingress layer — PHP or Node — verifies the request (signing), deduplicates it (idempotency), and returns a fast HTTP 2xx success so the partner does not retry unnecessarily. That is where synchronous Hypertext Transfer Protocol (HTTP) ends and durable work begins: the payload lands on a queue or transactional outbox. A Go worker picks it up, retries on failure, routes poison messages to a DLQ, and can fan out to multiple downstream calls concurrently. When the work involves AI, a Python Retrieval-Augmented Generation (RAG) service handles LLM logic with evaluation sets, citations, and guardrails. A Go retrieval gateway sits on the performance boundary — fetching chunks with strict timeouts so slow Python does not wedge the hot path. Postgres holds relational correctness, indexes, and optionally vector embeddings.

**Pillar 1 deep dive:** [Systems integration architect — Pillar 1](systems-integration-architect.md)

---

## The five pillars

### Pillar 1 — System shape (highest leverage)

System shape is about drawing boundaries before you write code. The central question is where HTTP ends and durable work begins: do you hold the partner on a long synchronous request, or return a fast acknowledgment and finish in a queue? At each integration edge you choose sync versus async. You decide who owns retrieval, who owns the LLM, and who owns ingress. The playbook default is **monolith first** — start with a modular monolith and split only when evidence demands it.

Draw system shape before opening an integrated development environment (IDE). One diagram per shipped lab beats none.

**Deep docs (learning-first):** [systems-integration-architect.md](systems-integration-architect.md) · [software-engineering.md § Architectural patterns](software-engineering.md#architectural-patterns)

**Example ADR prompts:** SQLite versus Postgres for an idempotency store; why Go owns retrieval and not Python; compose-orchestrated capstone versus monorepo.

**Primary projects:** 1, 5, 7, 8, 11, 22

---

### Pillar 2 — Integration and messaging

Integration and messaging covers how systems talk and what happens when messages arrive more than once. You choose delivery semantics — at-most-once, at-least-once, or effectively-once via idempotency. You pick a broker (Redis versus Kafka versus a database outbox), an API style (Representational State Transfer (REST)/OpenAPI versus gRPC versus webhooks), and how idempotency keys, DLQs, and replay work together.

Design for duplicate delivery first; narrow the window where duplicates hurt. Master idempotency and DLQ on **one** broker before adding a second.

| Broker choice | Pros | Cons |
|---------------|------|------|
| **Redis** | Fast local iteration | Weaker durability vs Kafka |
| **DB outbox** | Same txn as business write | Polling/CDC complexity |
| **Kafka** | Durable event log | Heavier ops for solo labs |

**Deep docs (learning-first):** [messaging-and-rpc.md](messaging-and-rpc.md) · [software-engineering.md § Integration](software-engineering.md#integration-sync-async-and-messaging) · [integration-hardening.md](../../checklists/integration-hardening.md)

**Example ADR prompts:** Redis versus database outbox for the queue; acknowledge before versus after handler commit; REST versus gRPC for Python↔Go.

**Primary projects:** 1, 6, 8, 10, 23, 24

---

### Pillar 3 — Data architecture

Data architecture is schema design, indexing, transactions, and tenancy. You model hot query paths, choose between row-level `tenant_id` filtering and Postgres Row-Level Security (RLS), and use Consistency, Availability, Partition tolerance (CAP) vocabulary when discussing replication lag — especially useful in system design interviews.

Prove data-layer choices with `EXPLAIN ANALYZE` and explicit transaction boundaries.

| Tenancy approach | Pros | Cons |
|------------------|------|------|
| **App-layer `tenant_id` filter** | Simple; works everywhere | One missed WHERE leaks data |
| **Postgres RLS** | DB-enforced isolation | Policy + migration complexity |

**Deep docs (learning-first):** [database-design.md](database-design.md) · [Project 12 spec](../../career-project-specs/12-multi-tenant-auth-lab.md)

**Example ADR prompts:** Partial versus covering index for a hot query; JSON Web Token (JWT) claims versus session for tenant context; Postgres full-text search versus external search engine.

**Primary projects:** 4, 2, 8, 12, 25

---

### Pillar 4 — Performance and language boundaries

Performance decisions start with measurement. Profile before rewriting. When you split Python versus Go versus Rust, use the same contract and write an evidence-based ADR. Caching, fan-out on write versus read, and rate limiting all live here.

The playbook stance is Go-first for throughput; Rust is optional with 95th percentile (p95) latency and Resident Set Size (RSS) evidence. No rewrite without a profile.

**Deep docs (learning-first):** [memory-and-performance.md](memory-and-performance.md) · [concurrency-runtime-model.md](concurrency-runtime-model.md) · [performance templates](../templates/)

**Example ADR prompts:** Why Go owns the retrieval boundary; token bucket versus sliding window; trie in-memory versus database-backed prefix index.

**Primary projects:** 4, 8, 18, 19 (optional), 23, 25

---

### Pillar 5 — Reliability, security, operations

Reliability covers observability (correlation identifiers, logs/metrics/traces, Service Level Objective (SLO) thinking), failure modes (partial outage, duplicate delivery, cache stampede), security at edges (Hash-based Message Authentication Code (HMAC), Cross-Site Request Forgery (CSRF), tenant isolation), and deploy/rollback (health checks, Continuous Integration (CI) gates).

Every lab documents **three failure modes** and their mitigations. Gate milestones with [production-readiness.md](../../checklists/production-readiness.md).

**Deep docs (learning-first):** [production-readiness.md](../../checklists/production-readiness.md) · [software-engineering.md § Observability](software-engineering.md#observability-logs-metrics-traces) · [per-project-testing.md](per-project-testing.md) · [Azure certification track](../career/azure-certification-track.md) · Projects 3, 9, 16

**Example ADR prompts:** JSON log schema; session versus token auth; cloud target and rollback strategy.

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

[System design interview map](../career/system-design-interview-map.md) maps classic whiteboard problems to labs. In interviews, narrate **pillar tradeoffs at scale** — for example fan-out on write (Pillar 4 + 2), idempotency under retry (Pillar 2), tenant isolation (Pillar 3).

[Big Tech benchmark](../career/big-tech-benchmark.md): production pillars + parallel Data Structures and Algorithms (DSA)/system design drills.

---

**Next:** [Project 1 — Integration webhook receiver](../../career-project-specs/01-integration-webhook-receiver.md)

---

## Technical reference

### Pillar one-liners

| # | Pillar | One-line focus |
|---|--------|----------------|
| 1 | System shape | Boundaries, sync vs async, who owns what |
| 2 | Integration & messaging | Delivery semantics, brokers, idempotency, DLQ |
| 3 | Data architecture | Schema, indexes, tenancy, consistency |
| 4 | Performance & language boundaries | Measure first; Python/Go/Rust splits |
| 5 | Reliability, security, operations | Observability, failure modes, deploy |

### Learning docs by pillar

| Pillar | Primary concept docs |
|--------|---------------------|
| 1 | [Systems integration architect](systems-integration-architect.md) |
| 2 | [Messaging and RPC](messaging-and-rpc.md) · [Integration automation](integration-automation.md) |
| 3 | [Database design](database-design.md) |
| 4 | [Memory and performance](memory-and-performance.md) · [Concurrency runtime model](concurrency-runtime-model.md) |
| 5 | [Software engineering handbook](software-engineering.md) · [Servers and networking](servers-and-networking.md) · [Azure cloud and AI](azure-cloud-and-ai.md) |

### Interview

[System design interview map](../career/system-design-interview-map.md) · [Big Tech benchmark](../career/big-tech-benchmark.md)
