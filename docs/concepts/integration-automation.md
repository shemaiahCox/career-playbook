# Ecosystem map: Integration and automation platforms

**Use this:** Vocabulary for **Boomi**, **n8n**, and similar **workflow/automation** tools — mapped to playbook labs (webhooks, queues, idempotency), not vendor certification prep.

**Companion:** [integration hardening checklist](../../checklists/integration-hardening.md) · [Project 1 webhook](../../career-project-specs/01-integration-webhook-receiver.md) · [Project 6 worker](../../career-project-specs/06-async-worker-stretch.md)

**New here?** [Plain language (bottom)](#plain-language-terms-used-on-this-page) · [Stacks glossary](../languages/glossary.md)

---

## Mental model

Integration platforms use a consistent vocabulary. The table below maps each concept to plain English and to the equivalent pattern in this playbook.

| Concept | Plain English | Playbook analogue |
|---------|---------------|-------------------|
| **Connector** | Adapter that talks to one system (Customer Relationship Management (CRM), database, HTTP API) | Your webhook receiver or outbound HTTP client in Project 1 / Project 7 |
| **Trigger** | Starts a process (schedule, webhook, file drop) | Inbound HTTP webhook in Project 1 |
| **Process / workflow** | Ordered steps with branches and error paths | Queue job chain Project 1 → Project 6 → Project 8 |
| **Map / transform** | Shape data between systems | Contract Data Transfer Objects (DTOs) in Project 5 OpenAPI |
| **Atom / step** | Single unit of work with retry policy | Idempotent handler + DLQ |
| **Execution** | One run of a workflow for one payload | Trace ID + structured logs in Project 3 |

---

## Patterns you already practice in code

### Fast ack + durable work

Boomi and n8n often **acknowledge** a trigger quickly while **downstream steps** run asynchronously. The same pattern appears in the playbook: a PHP webhook returns HTTP 200 after enqueue, and a **Go worker** completes processing ([Project 1](../../career-project-specs/01-integration-webhook-receiver.md) → [Project 6](../../career-project-specs/06-async-worker-stretch.md)). The partner gets a fast response; your system finishes the work reliably in the background.

### Idempotent steps

Connectors retry on failure. Your handlers must tolerate **duplicate delivery** using idempotency keys or natural keys in the database — see [integration hardening](../../checklists/integration-hardening.md).

### Error branches

Visual tools expose **success / failure / retry** paths. In code you implement the same idea with try/catch at boundaries, a **DLQ** after N failures, and alerts on poison messages.

### Replay

Re-running a failed execution with the same business key must not **double-charge** or **double-provision**. That is the same semantics as idempotent webhook plus worker design.

---

## n8n custom node skeleton (Illustrative)

```typescript
// Illustrative — INodeType.execute() calling your API with idempotency
const idempotencyKey = this.getNodeParameter("idempotencyKey", 0) as string;
await this.helpers.requestWithAuthentication.call(this, "myApi", {
  method: "POST",
  url: "/webhook",
  headers: { "Idempotency-Key": idempotencyKey },
  body: items[0].json,
});
```

See [Project 10 — Automation bot](../../career-project-specs/10-automation-bot-lab.md) · [Illustrative snippets](illustrative-snippets.md).

---

## Boomi vs code-first integration

| Approach | Pros | Cons | Use when |
|----------|------|------|----------|
| **iPaaS (Boomi, n8n UI)** | Fast partner onboarding; visual ops; non-engineers can tweak flows | Export/secret hygiene risk; harder to unit test graphs | Enterprise glue, many connectors, ops-owned tweaks |
| **Code-first (Project 1/6/7)** | Testable; versioned in git; CI gates on contracts | Slower for non-engineers to change | Core product integrations, money paths |
| **Hybrid** | UI for ops; custom nodes or microservices for hard paths | Two skill sets; split ownership | Common in mid-size SaaS |

| Decision factor | Lean iPaaS | Lean code-first |
|-----------------|------------|-----------------|
| Change frequency | Ops adjusts mappings weekly | Engineers own release train |
| Correctness bar | Idempotent replays + DLQ in platform | Idempotency keys + tests in repo ([P1](../../career-project-specs/01-integration-webhook-receiver.md)) |
| Secrets | Platform vault; watch export leaks | Env + secret manager; never in workflow JSON |
| Observability | Platform execution logs | Structured logs + `request_id` ([P3](../../career-project-specs/03-observability-lab.md)) |
| Partner contract | Map/transform in UI | OpenAPI + CI drift gate ([P5](../../career-project-specs/05-contract-first-api.md)) |

**Playbook stance:** prove code-first idempotency and DLQ on **one** broker, then say the same semantics apply in Boomi or n8n executions.

### Workflow retry diagram

```mermaid
flowchart TD
  Trigger[Trigger] --> Step[Workflow step]
  Step -->|success| Next[Next step]
  Step -->|transient fail| Retry[Platform retry]
  Retry --> Step
  Step -->|permanent fail| ErrorBranch[Error workflow]
```

---

## n8n (future lane)

Custom nodes in n8n are often **TypeScript** — which aligns with [Project 7 Node/TS lab](../../career-project-specs/07-node-typescript-lab.md) as a stretch goal. The workflow JSON is the artifact; secrets live outside the graph; test **error workflows** explicitly.

---

## Boomi (your anchor)

Process reporting plus document properties map to structured logs and correlation IDs ([Project 3 observability](../../career-project-specs/03-observability-lab.md)). Connector Software Development Kit (SDK) thinking maps to small **Go or PHP** services with strict contracts when a packaged connector is not enough.

---

## Read next (handbook)

- [Integration: sync, async, messaging](software-engineering.md#integration-sync-async-and-messaging)
- [Event-driven integration](software-engineering.md#event-driven-integration)
- [Systems integration architect](systems-integration-architect.md)

---

## Plain language: terms used on this page

| Term | Means |
|------|--------|
| **At-least-once** | A step may run more than once; design idempotency. |
| **DLQ** | Dead-letter queue — where poison/failed messages go for inspection. |
| **Correlation ID** | Same ID across steps so you can trace one business event in logs. |
