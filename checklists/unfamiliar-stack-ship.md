# Unfamiliar stack ship (AI-assisted)

Definition-of-done rubric when you are **building in a stack you have not mastered**, often with AI-generated code. Walk once with your repo open before calling the milestone **done**.

## Intent and scope

- [ ] **A** (what ships) and **B** (stack/runtime) are written in one place (README, spec, or [PROGRESS.md](../PROGRESS.md)).
- [ ] **Non-negotiables** for this product are listed (e.g. secrets, PII, uptime, offline behavior).


## Understanding bar (you, not the model)

- [ ] You can explain **where state lives** and the path from user action → storage/network → UI/response.
- [ ] You know **failure behavior**: timeouts, retries, error surfacing, empty states—not only happy path.
- [ ] You know how **configuration and secrets** are loaded and that they are **not** committed.


## Concepts applied by product shape

**If there is a UI**

- [ ] **Thread / actor model:** UI updates and touch handling follow platform rules (no “random thread updates UI”).
- [ ] **Lifecycle:** Screens or routes don’t leave **orphaned** work (subscriptions, timers, listeners) that outlive the owner.
- [ ] **Memory and lifetime:** You checked the stack’s usual **leak footguns** (retain cycles / strong references, uncancelled `async` work, listener deregistration, image/cache growth).

**If there is an HTTP surface**

- [ ] **Contract:** Errors, status codes, and versioning story are conscious; breaking changes are not accidental.
- [ ] **Security:** Auth boundary, input validation, and secrets handling match the threat model at least at a **basic** bar.

**If there is async / queue / worker work**

- [ ] **Delivery semantics** (at-least-once, etc.) and **idempotency** are explicit where duplicates hurt.
- [ ] **Backpressure / DLQ / poison** path is considered for non-trivial throughput.

**If there is persistence**

- [ ] **Migrations** or schema change strategy won’t silently corrupt existing users’ data.
- [ ] **Transactions** used where invariants require them (even if ORM hides the SQL).


## Observability and operations

- [ ] Logs or traces include **correlation** (request/job id) for the paths you own.
- [ ] You can **find** your code path in a debugger or structured log for the main flows.


## AI-specific sanity

- [ ] You **diff-reviewed** generated code for “looks real but wrong” (e.g. wrong thread, swallowed errors, fake security).
- [ ] Tests or manual scenarios cover **one failure** and **one edge** case per critical path—not only golden path.


## Pointer

Workflow context: [AI-assisted unfamiliar stack](../docs/concepts/ai-assisted-unfamiliar-stack.md) · Concept depth: [Software engineering](../docs/concepts/software-engineering.md)
