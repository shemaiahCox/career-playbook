# Systems architect across languages

**Goal:** Reason about **systems** (boundaries, data, failure, operations) and **translate** ideas into many stacks—without pretending to be a syntax expert in every ecosystem.

## What “polyglot architect” means here

- **Reading fluency:** Skim unfamiliar code for **data flow, boundaries, and failure handling**—enough to challenge a design or spot obvious holes.
- **Concept translation:** Same problem, different mechanisms (e.g. async: Swift actors vs Kotlin coroutines vs .NET `Task`).
- **Explicit tradeoffs:** Latency vs consistency, coupling vs speed to ship—argued in **architecture language**, then mapped to stack where needed.

**Not the goal:** Expert-level mastery of six languages in parallel, or turning this repo into six tutorial tracks.

## Depth order (what to deepen first)

1. **System shape** — Service boundaries, sync vs durable work, APIs and contract evolution, data ownership, messaging, backpressure.
2. **Semantics** — Consistency, concurrency models (conceptually), idempotency, delivery guarantees, timeouts.
3. **Operations** — Observability, deploy/rollback, incident thinking, security at edges (auth, secrets, supply-chain awareness).
4. **Data** — SQL, transactions, indexing, migrations—at **decision** depth (your [SQL lab](../../project-specs/07-sql-performance-lab.md) lane supports this).
5. **Ecosystem surface (shallow)** — Per stack: modules, tests, typical DI/async story—**maps**, not full courses (see [concepts](../concepts/README.md)).

## Practices (language-agnostic)

- **Diagrams:** Context / container / component for systems you care about (even occasionally beats never).
- **ADRs:** One page: context, decision, consequences—for real forks in the road.
- **Explain without code:** Request path, consistency expectations, and **failure modes** in plain language first.

## Where this repo practices it

The phased specs and [README — Architectural narrative](../../README.md#architectural-narrative) are intentionally **architecture-shaped**. Pair them with [ai-assisted-unfamiliar-stack.md](ai-assisted-unfamiliar-stack.md) when the stack is new and AI is in the loop.

For breadth reference material, use [Software engineering](../reference/software-engineering.md) and sibling files under [reference/](../reference/).
