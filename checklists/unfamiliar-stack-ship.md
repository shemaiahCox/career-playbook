# Unfamiliar stack ship (AI-assisted)

This is a definition-of-done rubric when you are **building in a stack you have not mastered**, often with AI-generated code. Walk through it once with your repo open before calling the milestone **done**.

## Intent and scope

These items nail down what you are shipping and what must not be compromised.

- [ ] **A** (what ships) and **B** (stack/runtime) are written in one place (README, spec, or [PROGRESS.md](../PROGRESS.md)).
- [ ] **Non-negotiables** for this product are listed (e.g. secrets, PII, uptime, offline behavior).

## Understanding bar (you, not the model)

These items prove you understand the system — not just that the code compiles.

- [ ] You can explain **where state lives** and the path from user action → storage/network → UI/response.
- [ ] You know **failure behavior**: timeouts, retries, error surfacing, empty states — not only happy path.
- [ ] You know how **configuration and secrets** are loaded and that they are **not** committed.

## Concepts applied by product shape

These sections apply only when your product has that shape. Skip what does not apply.

**If there is a UI**

- [ ] **Thread / actor model:** UI updates and touch handling follow platform rules (no “random thread updates UI”).
- [ ] **Lifecycle:** Screens or routes do not leave **orphaned** work (subscriptions, timers, listeners) that outlive the owner.
- [ ] **Memory and lifetime:** You checked the stack’s usual **leak footguns** (retain cycles / strong references, uncancelled `async` work, listener deregistration, image/cache growth).

**If there is an HTTP surface**

- [ ] **Contract:** Errors, status codes, and versioning story are conscious; breaking changes are not accidental.
- [ ] **Security:** Auth boundary, input validation, and secrets handling match the threat model at least at a **minimum** bar.

**If there is async / queue / worker work**

- [ ] **Delivery semantics** (at-least-once, etc.) and **idempotency** are explicit where duplicates hurt.
- [ ] **Backpressure / dead-letter queue (DLQ) / poison** path is considered for non-trivial throughput.

**If there is persistence**

- [ ] **Migrations** or schema change strategy will not silently corrupt existing users’ data.
- [ ] **Transactions** used where invariants require them (even if ORM hides the SQL).

## Observability and operations

These items let you find and follow your code in production-like conditions.

- [ ] Logs or traces include **correlation** (request/job id) for the paths you own.
- [ ] You can **find** your code path in a debugger or structured log for the main flows.

## AI-specific sanity

These items catch code that looks correct but is wrong in subtle ways.

- [ ] You **diff-reviewed** generated code for “looks real but wrong” (e.g. wrong thread, swallowed errors, fake security).
- [ ] Tests or manual scenarios cover **one failure** and **one edge** case per critical path — not only golden path.

## Pointer

Workflow context: [AI-assisted unfamiliar stack](../docs/concepts/ai-assisted-unfamiliar-stack.md) · Concept depth: [Software engineering](../docs/concepts/software-engineering.md)
