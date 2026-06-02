# Ecosystem map: Integration and automation platforms

**Use this:** Vocabulary for **Boomi**, **n8n**, and similar **workflow/automation** tools—mapped to playbook labs (webhooks, queues, idempotency), not vendor certification prep.

**Companion:** [integration hardening checklist](../../checklists/integration-hardening.md) · [Project 1 webhook](../../career-project-specs/01-integration-webhook-receiver.md) · [Project 5 worker](../../career-project-specs/05-async-worker-stretch.md)

**New here?** [Plain language (bottom)](#plain-language-terms-used-on-this-page) · [Stacks glossary](glossary.md)

---

## Mental model

| Concept | Plain English | Playbook analogue |
|---------|---------------|-------------------|
| **Connector** | Adapter that talks to one system (CRM, DB, HTTP API) | Your webhook receiver or outbound HTTP client in P1/P2 |
| **Trigger** | Starts a process (schedule, webhook, file drop) | Inbound HTTP webhook in P1 |
| **Process / workflow** | Ordered steps with branches and error paths | Queue job chain P1 → P5 → P9 |
| **Map / transform** | Shape data between systems | Contract DTOs in P2 OpenAPI |
| **Atom / step** | Single unit of work with retry policy | Idempotent handler + DLQ |
| **Execution** | One run of a workflow for one payload | Trace ID + structured logs in P3 |

---

## Patterns you already practice in code

**Fast ack + durable work**

Boomi and n8n often **acknowledge** a trigger quickly while **downstream steps** run asynchronously. Same as: PHP webhook returns `200` after enqueue, **Go worker** completes processing ([P1](../../career-project-specs/01-integration-webhook-receiver.md) → [P5](../../career-project-specs/05-async-worker-stretch.md)).

**Idempotent steps**

Connectors retry; your handlers must tolerate **duplicate delivery** (idempotency keys, natural keys in DB)—[integration hardening](../../checklists/integration-hardening.md).

**Error branches**

Visual tools expose **success / failure / retry** paths. In code: try/catch at boundaries, **DLQ** after N failures, alerts on poison messages.

**Replay**

Re-running a failed execution with the same business key must not **double-charge** or **double-provision**. Same semantics as idempotent webhook + worker design.

---

## n8n (future lane)

- **Custom nodes** are often **TypeScript**—aligns with [P6 Node/TS lab](../../career-project-specs/06-node-typescript-lab.md) as a stretch goal.
- **Workflow JSON** is the artifact; secrets live outside the graph; test **error workflows** explicitly.

---

## Boomi (your anchor)

- **Process reporting** + **document properties** ≈ structured logs + correlation IDs ([P3 observability](../../career-project-specs/03-observability-lab.md)).
- **Connector SDK** thinking ≈ small **Go or PHP** services with strict contracts when a packaged connector is not enough.

---

## Read next (handbook)

- [Integration: sync, async, messaging](../handbook/software-engineering.md#integration-sync-async-and-messaging)
- [Event-driven integration](../handbook/software-engineering.md#event-driven-integration)
- [Systems integration architect](../paths/systems-integration-architect.md)

---

## Plain language: terms used on this page

| Term | Means |
|------|--------|
| **At-least-once** | A step may run more than once; design idempotency. |
| **DLQ** | Dead-letter queue—where poison/failed messages go for inspection. |
| **Correlation ID** | Same ID across steps so you can trace one business event in logs. |
