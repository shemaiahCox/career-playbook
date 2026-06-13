# Project 10 — Automation bot / workflow connector lab

## Problem

Ship a **workflow-shaped automation** piece—custom **n8n node**, scheduled job, or Boomi-adjacent connector step—that calls your [P4](04-rag-llm-service.md) or [P1](01-integration-webhook-receiver.md) boundaries with **secrets, errors, and idempotency** handled like production integration code.

## Career relevance

**Summary:** You prove automation is **engineering**, not drag-and-drop only—connectors fail, retry, and double-fire; your step must survive that.

### In depth

iPaaS and workflow tools (n8n, Boomi, Zapier-class) are how many enterprises glue systems. Backend engineers who can **author reliable steps** (typed I/O, idempotent side effects, structured errors) stand out from “I built a flow in the UI.” This lab bridges [integration-automation map](../docs/stacks/integration-automation.md) vocabulary and shippable TypeScript or Python.

**Real-world situations:** Partner workflow retries a failed node; your step must not double-create tickets. API key rotation without plaintext in exported JSON. Clear error messages for ops when downstream LLM times out.

## Concept spotlight

**Pillars:** AI & Automation

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **Idempotent side effects** | Key outbound writes on business id; safe on workflow retry | AI/Automation |
| **Secrets hygiene** | Credentials via env/vault; never commit workflow export secrets | AI/Automation, Security |
| **Fast failure + structured errors** | Return actionable errors to workflow engine; log `request_id` | AI/Automation, DevOps |

**Interview line:** *“Our n8n node treats retries like webhooks—idempotent keys and structured errors so workflow replays don’t duplicate side effects.”*

## Code repo

_TBD — e.g. `automation-bot-lab` or n8n community node package._ Suggested folder: [`../career-projects/10-automation-bot-lab`](../career-projects/10-automation-bot-lab).

## Stack

- **TypeScript** (n8n custom node) **or** **Python** (scheduled worker calling APIs)
- Calls existing [P4](04-rag-llm-lab) or [P1](01-integration-webhook-receiver.md) endpoints
- Structured logging aligned with [P3](03-observability-lab.md)

## Key concepts

### Workflow step vs HTTP service

**What:** A step runs **inside** a orchestrator’s retry/DLQ semantics—not a standalone public API.

**Problem it solves:** You design for **at-least-once step execution**, same as queue consumers.

## Success criteria

- [ ] Step/node calls P4 or P1 with auth; secrets outside repo.
- [ ] **Idempotent** outbound effect documented (key + store or natural idempotency).
- [ ] Errors surface to workflow with log correlation id.
- [ ] README: diagram of trigger → step → downstream API.

## Testing approach (lab)

Integration test: run step twice with same input → one side effect.

## Exploration scenarios

1. Downstream 503 → workflow retries → no duplicate writes.
2. Invalid API key → clear error, no partial state.
3. LLM timeout from P4 → bounded wait; documented fallback.

## Stretch

- Publish as private n8n community package with version tag.
- Enqueue to [P5](05-async-worker-stretch.md) instead of sync call.

## Related

- [Engineering pillars — AI & Automation](../docs/paths/engineering-pillars.md#pillar-1--ai--automation-python--go--ts)
- [P6 n8n stretch](06-node-typescript-lab.md)
- [Integration hardening checklist](../checklists/integration-hardening.md)
