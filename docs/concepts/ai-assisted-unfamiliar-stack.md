# Build product **A** in unfamiliar stack **B** (with AI)

**Use this:** Someone asks for **A** (mobile app, API, worker, CLI) and you have **not** shipped production **B** before—AI may draft code; **you** own boundaries and correctness.

**Reading order:**

1. [Architecture framework](architecture-framework.md) — non-negotiables by pillar
2. **You are here** — intent lock + AI prompt shape
3. [Unfamiliar stack ship checklist](../../checklists/unfamiliar-stack-ship.md) — before calling done
4. Stack map under [docs README — languages](../README.md#languages-new-to-a-stack)

**Companion:** [Systems integration architect](systems-integration-architect.md) · [Software engineering handbook](software-engineering.md)

---

## 1. Lock intent before tools

Write **three lines** (in your lab README or this repo's [PROGRESS.md](../../PROGRESS.md)):

- **A:** What ships (user-visible outcome, not "use framework X").
- **B:** Runtime, packaging, and deployment target (e.g. iOS + SwiftUI, ASP.NET minimal API, Android + Kotlin).
- **Non-negotiables:** Which concepts **must** hold (e.g. "no secrets in repo," "idempotent webhook," "UI thread rules," "migrations safe").

If you cannot state non-negotiables, read the relevant section of [software engineering breadth](software-engineering.md) (integration, security, concurrency) **before** generating large amounts of code.

## 2. Map **A** to concept checklist (not to syntax)

The kind of product you are building determines which invariants you must enforce. Stack **B** only changes *how* each item appears in code (see [term cards](README.md)).

| Kind of **A** | You usually must enforce |
|---------------|---------------------------|
| **UI app** | State flow, lifecycle, main/UI thread vs background, navigation, persistence, **resource ownership** (memory leaks, subscriptions, delegates). |
| **HTTP API** | Contract shape, errors, auth boundary, idempotency where needed, observability. |
| **Worker / async** | Delivery semantics, retries, poison messages, concurrency vs correctness. |
| **CLI / script** | Exit codes, config and secrets, stderr vs stdout. |

These concerns are **stack-agnostic**. The syntax differs; the engineering obligations do not.

## 3. One pass with AI (prompt shape)

Keep prompts **architecture-shaped**:

- Inputs/outputs, failure modes, and **where state lives**.
- Explicit: "Follow **B** idioms for packaging and tests; explain **why** in comments only where the choice is non-obvious."
- Ask for a **file list** and **data-flow diagram in text** before asking for full implementation.

Review the output for **happy-path-only** code — missing errors, missing cancellation, missing tests for the contract.

## 4. Human bar: can you answer these?

Before merging or tagging a release, you should answer **without opening five blog posts**:

1. Where does **mutable state** live, and who reads/writes it?
2. What runs on the **UI or "main" path** vs background (if applicable)?
3. What happens on **network/storage failure**?
4. How are **secrets** loaded and where do they **not** go?
5. What **resource or lifetime** mistakes would cause leaks or hangs in **B**? (See checklist.)

If any answer is "I'm not sure," treat that as a **review gap**, not shame — fill it with one focused read of official docs or your ecosystem notes.

## 5. Before "done": walk the checklist

Use [unfamiliar-stack-ship.md](../../checklists/unfamiliar-stack-ship.md) as a rubric — not a daily todo.

---

## Worked prompt examples

### HTTP API in unfamiliar stack

```
Product A: REST API with POST /orders (idempotent), GET /orders/{id}, OpenAPI checked in.
Stack B: FastAPI + Postgres + pytest.
Non-negotiables: no secrets in repo; Idempotency-Key header; structured JSON logs with request_id.

First: list files and a text data-flow diagram (client → API → DB).
Then: implement with parameterized SQL only; show error envelope for 400/409/500.
```

### Worker in unfamiliar stack

```
Product A: Redis queue consumer with DLQ after 3 failures; idempotent on job_id.
Stack B: Go 1.22, table-driven tests for dedupe helper.
Non-negotiables: at-least-once safe; context timeouts on outbound HTTP.

First: describe ack timing ADR (before vs after commit).
Then: implement consumer loop + one integration test with duplicate delivery.
```

## Anti-patterns (AI-generated code)

| Anti-pattern | Why it fails | Fix |
|--------------|--------------|-----|
| Happy-path-only handlers | Production errors swallowed | Explicit error branches + tests |
| Secrets in generated `.env` | Committed credentials | `.env.example` placeholders only |
| HMAC after `JSON.parse` | Signature always fails | Raw body buffer first |
| Unbounded goroutines / promises | OOM under load | Semaphore / worker pool |
| Missing idempotency on POST | Retries double-charge | Key + durable store |

---

## Related

- [Career projects](../../README.md#progression-step-1--22) — linear path; each spec links handbook and stack maps.
- [Architecture framework](architecture-framework.md) — five pillars; read before generating large amounts of code.
- [Systems integration architect](systems-integration-architect.md) — Pillar 1 depth order for integration-shaped **design** literacy on your stack.
- [docs README](../README.md) — definition + minimal example + failure mode; **[Stacks glossary (plain-language index)](../languages/glossary.md)** gathers links to newcomer-friendly blurbs under each ecosystem map.
- [Ecosystem maps](../README.md#languages-new-to-a-stack) — stack-specific vocabulary (PHP/Laravel, Python, Node/TS, Go, Rust, SQL).

---

## Technical reference

### Prompt skeleton

```
Product A: [user-visible outcome]
Stack B: [runtime + packaging + test runner]
Non-negotiables: [secrets, idempotency, observability, …]

First: file list + text data-flow diagram.
Then: implementation with explicit error paths.
```

### Anti-pattern index

| Pattern | Fix |
|---------|-----|
| Happy-path-only | Error branches + tests |
| Secrets in generated `.env` | `.env.example` only |
| HMAC after parse | Raw body buffer first |
| Unbounded concurrency | Worker pool / semaphore |
| POST without idempotency | Durable idempotency key |

### Checklist

[unfamiliar-stack-ship.md](../../checklists/unfamiliar-stack-ship.md)
