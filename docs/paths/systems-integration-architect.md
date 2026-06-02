# Systems integration architect

**Goal:** Reason about **integration and event-driven systems**—boundaries, data, failure, operations, security—on **your core stack** (PHP, Node/TS, Go, Python, SQL), not as a tour of every programming language.

## What this means here

- **System shape first:** Where does HTTP end and durable work begin? What is sync ack vs async completion? How do Boomi/n8n-style workflows map to webhooks, queues, and workers?
- **Explicit tradeoffs:** Latency vs consistency, at-least-once vs exactly-once attempts, thin PHP ingress vs Go worker throughput vs Python LLM boundary.
- **Explain without code:** Request path, delivery guarantees, and failure modes in plain language before opening an IDE.

**Not the goal:** Expert syntax in six ecosystems, or breadth sandboxes for languages outside your stack.

## Reference architecture (this playbook)

```text
Partner / Boomi / n8n trigger
    → PHP or Node webhook (sign, idempotency, fast 2xx)
    → queue / outbox
    → Go worker (retries, DLQ, concurrent fan-out)
    → Python RAG service (evals, citations, guardrails)  [optional sync path]
    → Go retrieval gateway (chunk fetch, timeouts)       [performance boundary]
    → Postgres (SQL correctness, indexes, vectors)
```

Practice mapping: [P1 webhook](../../career-project-specs/01-integration-webhook-receiver.md) → [P5 worker](../../career-project-specs/05-async-worker-stretch.md) → [P9 Go lab](../../career-project-specs/09-go-retrieval-worker-lab.md) → [P4 RAG](../../career-project-specs/04-rag-llm-service.md) → [P7 SQL](../../career-project-specs/07-sql-performance-lab.md).

## Depth order (what to deepen first)

1. **System shape** — Service boundaries, sync vs durable work, API evolution, data ownership, messaging, backpressure.
2. **Event-driven integration** — Connectors, idempotent steps, error branches, replay; [integration-automation](../stacks/integration-automation.md).
3. **Semantics** — Consistency, concurrency (Go goroutines vs PHP request vs Node event loop), idempotency, delivery guarantees, timeouts.
4. **Operations** — Observability, deploy/rollback, incident thinking, security at edges.
5. **Data** — SQL transactions, indexing, migrations, vector retrieval—[SQL lab](../../career-project-specs/07-sql-performance-lab.md).
6. **Performance literacy** — Big-O and structure choice under load—[Algorithms study path](algorithms-study-path.md).

## Practices

- **Diagrams:** Context / container / component—even one diagram per shipped lab beats none.
- **ADRs:** One page: context, decision, consequences—for real forks (e.g. Python-only retrieval vs Go gateway).
- **Study, don’t skim:** Load-bearing handbook sections and the algorithms study path when a spec points you there.

## Where this repo practices it

Phased specs and [README — Architectural narrative](../../README.md#architectural-narrative). Pair with [AI-assisted unfamiliar stack](ai-assisted-unfamiliar-stack.md) when AI accelerates a new corner of **your** stack.

Handbook depth: [Software engineering](../handbook/software-engineering.md) · [Database design](../handbook/database-design.md).
