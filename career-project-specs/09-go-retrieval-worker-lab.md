# Project 9 — Go retrieval gateway and worker lab

## Problem

**Python** fits LLM orchestration and evals; **chunking, concurrent retrieval, and queue workers** need a fast, concurrent service. Ship a **Go** binary that (1) serves a **retrieval gateway** HTTP API and (2) consumes **durable jobs** from a queue—with idempotency, retries, and observability aligned with [Project 1](01-integration-webhook-receiver.md) and [Project 5](05-async-worker-stretch.md).

## Career relevance

**Summary:** You practice the **performance boundary** common in AI + integration systems: Python owns model logic; **Go owns throughput** (retrieval fan-out, workers, connectors).

### In depth

Production RAG and automation stacks often split **slow, rich** Python services from **fast, concurrent** Go services (retrieval gateways, embedding routers, workflow workers). Vector DB ecosystems (Milvus, Weaviate, Qdrant) and workflow engines (Temporal) are frequently Go or Go-adjacent—**reading and shipping Go** is sustainable for integrations + AI careers without entering Rust/systems pain.

**Why learning this moves the needle**

- **Latency:** Fan-out chunk fetch with strict timeouts and bounded goroutines beats naive Python loops at scale.
- **Workers:** Queue consumers with **at-least-once** semantics and **idempotent** handlers mirror Boomi/n8n durable steps—see [integration-automation map](../docs/stacks/integration-automation.md).
- **Interview signal:** “We moved retrieval to Go and cut p95” plus **duplicate delivery** story is credible staff-level integration + AI talk.

**Real-world situations this project mirrors**

- Python FastAPI **calls Go** for `/retrieve` while keeping eval harness in Python ([Project 4](04-rag-llm-service.md)).
- Webhook path **enqueues**; Go worker **drains** queue extending [Project 1](01-integration-webhook-receiver.md).
- Connector-style microservice with **OpenAPI JSON** contract and structured logs ([Project 3](03-observability-lab.md)).

## Code repo

_TBD — create sibling repo (e.g. `go-retrieval-worker-lab`) when you start._ Link GitHub + local path here.

Suggested local folder: [`../career-projects/09-go-retrieval-worker-lab`](../career-projects/09-go-retrieval-worker-lab).

## Stack

- **Go 1.22+**, `go mod`, table-driven tests (`go test ./...`).
- **HTTP:** `net/http` or **chi** / **echo** (pick one; document in README).
- **Queue:** Redis list/stream, or NATS, or SQS-compatible local (document choice); align vocabulary with [Project 5](05-async-worker-stretch.md).
- **Data:** Postgres for idempotency keys and optional chunk table; optional **pgvector** stretch with [Project 7](07-sql-performance-lab.md).
- **Observability:** structured JSON logs, `request_id` / `trace_id`, basic latency metrics in logs.

## Architecture split (with Project 4)

| Component | Owner | Responsibility |
|-----------|--------|----------------|
| `POST /query`, eval JSONL, citations policy | Python (P4) | LLM call, guardrails, regression evals |
| `POST /retrieve`, chunk fan-out, timeouts | Go (P9) | Concurrent fetch, cache-friendly read path |
| Job enqueue / DLQ | P1/P5 pattern | Fast HTTP ack; durable Go consumer |

Document the **HTTP or queue contract** in OpenAPI or README—stable for both services.

## Key concepts

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

## Testing approach (lab)

**Primary:** Table-driven unit tests for idempotency and parsing; integration test with **testcontainers** or docker-compose (Postgres + Redis) optional.

**Exploration scenarios**

1. Fire same job twice—assert single side effect.
2. Slow dependency—context cancel; worker ack/retry behavior documented.
3. Gateway timeout—Python caller receives **504** or partial result policy you documented.

## Stretch

- Prometheus metrics endpoint.
- Benchmark retrieval with 1k chunks—relate to [Algorithms study path](../docs/paths/algorithms-study-path.md) (O(n) scan vs indexed lookup).
- Share queue with PHP/Laravel or Node producer from P1/P6.

## Related

- [Go ecosystem map](../docs/stacks/go.md)
- [go-cli-http-probe sandbox](../exploration-projects/go-cli-http-probe/README.md)
- [Integration hardening checklist](../checklists/integration-hardening.md)
