# Project 8 — Go retrieval gateway and worker lab

## Progress

| | |
|---|---|
| **Step** | 8 of 22 |
| **Previous** | [Project 7 — Node / TypeScript service lab](07-node-typescript-lab.md) |
| **Next** | [Project 9 — OWASP / cybersecurity foundations](09-application-security-lab.md) |

## What you will learn

- Serve a retrieval gateway with bounded concurrency and strict timeouts
- Consume durable queue jobs with idempotent handlers
- Document the Python ↔ Go performance boundary

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 1. System shape | Python owns LLM; Go owns retrieval gateway and queue workers |
| 2. Integration & messaging | Queue consumers, at-least-once, optional Kafka/gRPC stretches |
| 3. Data architecture | Chunk fetch paths, SQL/vector retrieval boundaries |
| 4. Performance & language boundaries | Bounded concurrency, pprof, p95/RSS evidence for Python↔Go split |
| 5. Reliability, security, operations | Idempotent jobs, `/metrics`, timeouts, failure modes |

**Required ADR(s):** tag each ADR with pillar (e.g. why Go owns retrieval — **Pillar 1 + 4**; REST vs gRPC — **Pillar 2**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

## Before you start

- **New to Go?** → [Go map](../docs/languages/go.md) · [Stacks glossary](../docs/languages/glossary.md)
- **Cross-stack depth:** [Generators and iterators](../docs/languages/language-fundamentals-comparison.md#lazy-evaluation-generators-and-iterators) · [Concurrency beyond syntax](../docs/languages/language-fundamentals-comparison.md#concurrency-beyond-syntax)
- **Brokers (career context):** [Messaging and RPC](../docs/concepts/messaging-and-rpc.md)
- **Deep dive (optional):** [Architecture framework](../docs/concepts/architecture-framework.md) · [Systems integration architect — Pillar 1](../docs/concepts/systems-integration-architect.md)
- **Handbook:** [Integration](../docs/concepts/software-engineering.md#integration-sync-async-and-messaging) · [Concurrency](../docs/concepts/software-engineering.md#concurrency-basics) · [Memory and performance](../docs/concepts/memory-and-performance.md)

## Problem

**Python** fits LLM orchestration and evals; **chunking, concurrent retrieval, and queue workers** need a fast, concurrent service. Ship a **Go** binary that (1) serves a **retrieval gateway** HTTP API and (2) consumes **durable jobs** from a queue—with idempotency, retries, and observability aligned with [Project 1](01-integration-webhook-receiver.md) and [Project 6](06-async-worker-stretch.md).

## Career relevance

**Summary:** You practice the **performance boundary** common in AI + integration systems: Python owns model logic; **Go owns throughput** (retrieval fan-out, workers, connectors).

### In depth

Production RAG and automation stacks often split **slow, rich** Python services from **fast, concurrent** Go services (retrieval gateways, embedding routers, workflow workers). Vector DB ecosystems (Milvus, Weaviate, Qdrant) and workflow engines (Temporal) are frequently Go or Go-adjacent—**reading and shipping Go** is sustainable for integrations + AI careers without entering Rust/systems pain.

**Why learning this moves the needle**

- **Latency:** Fan-out chunk fetch with strict timeouts and bounded goroutines beats naive Python loops at scale.
- **Workers:** Queue consumers with **at-least-once** semantics and **idempotent** handlers mirror Boomi/n8n durable steps—see [integration-automation map](../docs/concepts/integration-automation.md).
- **Interview signal:** “We moved retrieval to Go and cut p95” plus **duplicate delivery** story is credible staff-level integration + AI talk.

**Real-world situations this project mirrors**

- Python FastAPI **calls Go** for `/retrieve` while keeping eval harness in Python ([Project 2](02-rag-llm-service.md)).
- Webhook path **enqueues**; Go worker **drains** queue extending [Project 1](01-integration-webhook-receiver.md).
- Connector-style microservice with **OpenAPI JSON** contract and structured logs ([Project 3](03-observability-lab.md)).

### How to talk about this

Python owns LLM (large language model) orchestration and evals; Go owns concurrent retrieval with strict timeouts—you split on profiling and failure isolation, not hype. Bring p95 (95th percentile latency) and RSS (resident set size) evidence from `pprof` when you moved fan-out or queue consumption to Go, and repeat the at-least-once idempotency story from Projects 1 and 6.

## Important concepts

### Concurrency and backpressure

Use a bounded goroutine pool for chunk fan-out and `context` timeouts on handlers and jobs. Unbounded concurrency exhausts file descriptors and memory; backpressure keeps retrieval gateways stable under load.

### Idempotency (worker)

Dedupe on `job_id` before writes; safe under at-least-once queue delivery. Duplicate delivery is expected—business keys and durable dedupe stores are how you avoid double writes.

### Performance boundary

Go `/retrieve` serves Python [Project 2](02-rag-llm-service.md); document the JSON contract in OpenAPI or README. Python keeps model vendor churn and eval iteration; Go keeps hot-path throughput and timeout discipline.

### Profile before split

Use `pprof` CPU and heap during fan-out; capture p95/RSS with versus without a worker pool in [`performance.md`](../docs/templates/performance-p8-go.md) ([Memory and performance](../docs/concepts/memory-and-performance.md)). Split languages when measurement shows a boundary, not by default on day one.

## Code repo

_TBD — create sibling repo (e.g. `go-retrieval-worker-lab`) when you start._ Link GitHub + local path here.

Suggested local folder: [`../career-projects/08-go-retrieval-worker-lab`](../career-projects/08-go-retrieval-worker-lab).

## Stack

- **Go 1.22+**, `go mod`, table-driven tests (`go test ./...`).
- **HTTP:** `net/http` or **chi** / **echo** (pick one; document in README).
- **Queue:** Redis list/stream, or NATS, or SQS-compatible local (document choice); align vocabulary with [Project 6](06-async-worker-stretch.md).
- **Data:** Postgres for idempotency keys and optional chunk table; optional **pgvector** stretch with [Project 4](04-sql-performance-lab.md).
- **Observability:** structured JSON logs, `request_id` / `trace_id`, basic latency metrics in logs.

## Architecture split (with Project 2)

| Component | Owner | Responsibility |
|-----------|--------|----------------|
| `POST /query`, eval JSONL, citations policy | Python (Project 2) | LLM call, guardrails, regression evals |
| `POST /retrieve`, chunk fan-out, timeouts | Go (Project 8) | Concurrent fetch, cache-friendly read path |
| Job enqueue / DLQ | Project 1/Project 6 pattern | Fast HTTP ack; durable Go consumer |

Document the **HTTP or queue contract** in OpenAPI or README—stable for both services.

### Key concepts

### Retrieval gateway

**What:** HTTP service that accepts a query + filters, fetches candidate chunks (DB or mock), returns ranked IDs + text within a **timeout budget**.

**Problem it solves:** Keeps **Python** process free of N concurrent DB/API calls; failure isolation when retrieval degrades.

### Idempotent worker

**What:** Consumer that processes `(job_id, payload)` with **dedupe** on `job_id` or business key before side effects.

**Problem it solves:** **At-least-once** queue delivery does not double-apply integration effects.

### Context and cancellation

**What:** `context.Context` on HTTP handlers and worker jobs; cancel when parent timeout fires.

**Problem it solves:** Goroutine leaks and hung workers under slow dependencies.

## Success criteria

- [ ] **Retrieval gateway** returns chunks within configured timeout; logs `request_id`, duration_ms, chunk_count.
- [ ] **Worker** processes jobs idempotently—**duplicate `job_id` does not double-write**.
- [ ] **Retry + DLQ:** poison message lands in DLQ (or dead-letter table) after N failures; main queue drains.
- [ ] **Contract doc** for Python ↔ Go boundary (JSON schema or OpenAPI fragment).
- [ ] README diagram: sync retrieval path vs async worker path; three failure modes named.
- [ ] `go test` covers at least idempotency helper and one handler/table-driven case.
- [ ] **Prometheus `/metrics`** endpoint (request count, latency histogram, or queue depth)—document scrape path in README.
- [ ] **Go-first performance track:** `net/http/pprof` registered; [`docs/portfolio/performance.md`](../docs/templates/performance-p8-go.md) with `/retrieve` p95 vs Python baseline **and** peak RSS (bounded vs unbounded pool comparison).

## Testing approach (lab)

**Primary:** Table-driven unit tests for idempotency and parsing; integration test with **testcontainers** or docker-compose (Postgres + Redis) optional.

**Exploration scenarios**

1. Fire same job twice—assert single side effect.
2. Slow dependency—context cancel; worker ack/retry behavior documented.
3. Gateway timeout—Python caller receives **504** or partial result policy you documented.
4. Fan-out with vs without worker pool—note goroutine count, p95, and heap/RSS in [`performance.md`](../docs/templates/performance-p8-go.md) ([Memory and performance](../docs/concepts/memory-and-performance.md)).

## Go-first performance track (replaces Project 19)

When Rust is paused, this project is your **hot-path performance proof** — no second-language rewrite required.

1. Baseline Python `/retrieve` or equivalent fan-out path (from [Project 2](02-rag-llm-service.md)).
2. Go gateway with bounded worker pool + `context` timeouts.
3. Capture CPU + heap via `pprof`; record p95 and peak RSS before/after pool sizing.
4. ADR: why Go owns the boundary (profile evidence, not “Go is faster”).

Template: [`performance-p8-go.md`](../docs/templates/performance-p8-go.md).

No separate profiling lab spec is needed — the Go-first performance track above is the P19 replacement.

## Stretch

**Core (any one):**

- Benchmark retrieval with 1k chunks—relate to [Algorithms study path](../docs/concepts/algorithms-study-path.md) (O(n) scan vs indexed lookup).
- Share queue with PHP/Laravel or Node producer from Project 1/Project 4.
- **Kafka consumer** — same idempotency/DLQ semantics as Redis worker; document consumer group + replay ([Messaging and RPC](../docs/concepts/messaging-and-rpc.md)).
- **gRPC retrieve endpoint** — protobuf `Retrieve` RPC as internal alternative to REST JSON; Python Project 2 client unchanged at HTTP boundary or updated with gRPC client (document choice in ADR).

**AI + automation capstone (after success criteria green):**

- **Concurrent ingestion pipeline** — `ingest_batch` jobs from Project 1/Project 4 enqueue; worker pool with **backpressure**; idempotent chunk upserts into [Project 4](04-sql-performance-lab.md) tables.
- **Event bus** — NATS or Redis Streams for `ingest_complete` / `chunks_ready`; at-least-once consumers; document replay—**after** queue + DLQ basics from [Project 6](06-async-worker-stretch.md).
- **Real-time notify (optional)** — SSE or WebSocket on gateway for job status; handbook: [WebSockets](../docs/concepts/servers-and-networking.md#websockets-and-long-polling).

**Cloud / ops:**

- `docker compose` for Go service + Postgres + Redis/NATS; document local → managed queue (e.g. SQS) in README.
- Small ops CLI: replay DLQ, drain queue (CLI flags, exit codes, bounded HTTP—see [Project 15](15-devops-cli-lab.md)).

**Rust Tier‑2 (after Go core green — not a parallel spine):**

- Reimplement **retrieval gateway** or **worker** per [Project 19](19-rust-hot-path-lab.md); **same** OpenAPI/queue contract as Go; log Go-vs-Rust ADR in [PROGRESS.md](../PROGRESS.md).

## Big Tech benchmark tier

Optional ceiling — see [big-tech-benchmark.md](../docs/career/big-tech-benchmark.md). Complete after UK £80k success criteria are green.

- [ ] **Kafka consumer** — primary or alternate deployment path; idempotency + DLQ unchanged ([Messaging and RPC](../docs/concepts/messaging-and-rpc.md)).
- [ ] **gRPC** `Retrieve` RPC as internal API (protobuf); document REST vs gRPC ADR; Python [Project 2](02-rag-llm-service.md) client uses gRPC or HTTP gateway — document choice.
- [ ] **OpenTelemetry** traces propagate `trace_id` across Python ↔ Go (or Go worker ↔ gateway); sample trace in `docs/portfolio/`.
- [ ] README documents consumer group, gRPC deadlines, and metric cardinality limits.


## Stretch: connect your labs

When Projects 2, 4, 6, and 8 are green, wire one integrated story:

1. **Ingress** — Project 1 webhook validates → enqueue
2. **Durable work** — Project 6/8 worker ingests documents
3. **Data** — Project 4 Postgres stores chunks/embeddings
4. **AI path** — Project 2 calls Project 8 `POST /retrieve` → LLM + citations

Log one ADR in [PROGRESS.md](../PROGRESS.md). Optional deep dive: [Architecture framework](../docs/concepts/architecture-framework.md) · [Pillar 1 — Systems integration architect](../docs/concepts/systems-integration-architect.md).

## Bash scripting milestone

Ship `scripts/enqueue-fixture.sh` — idempotent fixture enqueue for integration tests; same pattern as [Project 6](06-async-worker-stretch.md).

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — Python `/query` vs Go `/retrieve` + queue consumer paths.
- [ ] **ADR** — why Go owns retrieval/worker boundary (latency, concurrency, isolation).
- [ ] **Performance numbers** — commit [`docs/portfolio/performance.md`](../docs/templates/performance-p8-go.md): `/retrieve` p95 vs Python baseline, peak RSS, pprof summary.
- [ ] **Failure modes** — retrieval timeout cascading; unbounded goroutines; DLQ without replay story.
- [ ] **Observability evidence** — cross-service log with shared trace/request id.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 8)
- Checklist: [Integration hardening checklist](../checklists/integration-hardening.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 9 — OWASP / cybersecurity foundations](09-application-security-lab.md)
