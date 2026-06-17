# Pillar 1 deep dive — System shape

**Part of:** [Architecture framework](architecture-framework.md) — **read the framework first.**

**Goal:** Reason about **integration and event-driven system shape**—boundaries, sync vs durable work, data ownership—on **your core stack** (PHP, Node/TS, Go, Python, SQL), not as a tour of every programming language.

## What this means here

- **System shape first:** Where does HTTP end and durable work begin? What is sync ack vs async completion? How do Boomi/n8n-style workflows map to webhooks, queues, and workers?
- **Explicit tradeoffs:** Latency vs consistency, at-least-once vs exactly-once attempts, thin PHP ingress vs Go worker throughput vs Python LLM boundary.
- **Explain without code:** Request path, delivery guarantees, and failure modes in plain language before opening an IDE.

**Not the goal:** Expert syntax in six ecosystems, or breadth sandboxes for languages outside your stack.

## Reference architecture (this playbook)

```text
Partner / Boomi / n8n trigger
    → PHP or Node webhook (sign, idempotency, fast 2xx)     [Pillar 1 + 2 + 5]
    → queue / outbox                                         [Pillar 2 — Integration]
    → Go worker (retries, DLQ, concurrent fan-out)           [Pillar 1 + 2 + 4]
    → Python RAG service (evals, citations, guardrails)        [Pillar 1 + 3 — Data]
    → Go retrieval gateway (chunk fetch, timeouts)           [Pillar 4 — Performance]
    → Postgres (SQL correctness, indexes, vectors)           [Pillar 3 — Data]
```

Practice mapping: [Project 1 webhook](../../career-project-specs/01-integration-webhook-receiver.md) → [Project 6 worker](../../career-project-specs/06-async-worker-stretch.md) → [Project 8 Go lab](../../career-project-specs/08-go-retrieval-worker-lab.md) → [Project 2 RAG](../../career-project-specs/02-rag-llm-service.md) → [Project 4 SQL](../../career-project-specs/04-sql-performance-lab.md) → … → [Project 22 capstone](../../career-project-specs/22-integrated-platform-capstone.md).

## Depth order (what to deepen first)

Maps to the [five pillars](architecture-framework.md#the-five-pillars):

1. **Pillar 1 — System shape** — Service boundaries, sync vs durable work, API evolution, data ownership, messaging, backpressure.
2. **Pillar 2 — Integration** — Connectors, idempotent steps, error branches, replay; [integration-automation](integration-automation.md).
3. **Pillar 3 — Data** — SQL transactions, indexing, migrations, vector retrieval—[SQL lab](../../career-project-specs/04-sql-performance-lab.md).
4. **Pillar 4 — Performance** — Big-O and structure choice under load—[Algorithms study path](algorithms-study-path.md); Python vs Go splits.
5. **Pillar 5 — Operations** — Observability, deploy/rollback, incident thinking, security at edges.

## Practices

- **Diagrams:** Context / container / component—even one diagram per shipped lab beats none. Tag boundaries to [Pillar 1](architecture-framework.md#pillar-1--system-shape-highest-leverage).
- **ADRs:** One page: context, decision, consequences—for real forks (e.g. Python-only retrieval vs Go gateway). Set `**Pillar:** 1` (or 1 + 4 when split is performance-driven).
- **Study, don’t skim:** Load-bearing handbook sections and the algorithms study path when a spec points you there.

## Where this repo practices it

Phased specs: [career projects catalog](../../README.md#progression-step-1--22) · [architecture framework](architecture-framework.md) (learning order). Pair with [AI-assisted unfamiliar stack](ai-assisted-unfamiliar-stack.md) when AI accelerates a new corner of **your** stack.

Handbook depth: [Software engineering](software-engineering.md) · [Database design](database-design.md) · [Messaging and RPC](messaging-and-rpc.md).
