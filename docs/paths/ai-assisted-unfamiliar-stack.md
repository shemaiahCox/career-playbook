# Build product **A** in unfamiliar stack **B** (with AI)

Use this when someone asks for **A** (mobile app, API, worker, CLI, …) and you have **not** shipped production **B** before. AI is allowed to draft code; **you** remain accountable for boundaries, correctness, and platform footguns.

## 1. Lock intent before tools

Write **three lines** (in your lab README or this repo’s [PROGRESS.md](../../PROGRESS.md)):

- **A:** What ships (user-visible outcome, not “use framework X”).
- **B:** Runtime, packaging, and deployment target (e.g. iOS + SwiftUI, ASP.NET minimal API, Android + Kotlin).
- **Non-negotiables:** Which concepts **must** hold (e.g. “no secrets in repo,” “idempotent webhook,” “UI thread rules,” “migrations safe”).

If you cannot state non-negotiables, read the relevant section of [software engineering breadth](../handbook/software-engineering.md) (integration, security, concurrency) **before** generating large amounts of code.

## 2. Map **A** to concept checklist (not to syntax)

| Kind of **A** | You usually must enforce |
|---------------|---------------------------|
| **UI app** | State flow, lifecycle, main/UI thread vs background, navigation, persistence, **resource ownership** (memory leaks, subscriptions, delegates). |
| **HTTP API** | Contract shape, errors, auth boundary, idempotency where needed, observability. |
| **Worker / async** | Delivery semantics, retries, poison messages, concurrency vs correctness. |
| **CLI / script** | Exit codes, config and secrets, stderr vs stdout. |

These are **stack-agnostic**. Stack **B** only changes *how* each item appears in code (see [term cards](../stacks/README.md)).

## 3. One pass with AI (prompt shape)

Keep prompts **architecture-shaped**:

- Inputs/outputs, failure modes, and **where state lives**.
- Explicit: “Follow **B** idioms for packaging and tests; explain **why** in comments only where the choice is non-obvious.”
- Ask for a **file list** and **data-flow diagram in text** before asking for full implementation.

Review the output for **happy-path-only** code (missing errors, missing cancellation, missing tests for the contract).

## 4. Human bar: can you answer these?

Before merging or tagging a release, you should answer **without opening five blog posts**:

1. Where does **mutable state** live, and who reads/writes it?
2. What runs on the **UI or “main” path** vs background (if applicable)?
3. What happens on **network/storage failure**?
4. How are **secrets** loaded and where do they **not** go?
5. What **resource or lifetime** mistakes would cause leaks or hangs in **B**? (See checklist.)

If any answer is “I’m not sure,” treat that as a **review gap**, not shame—fill it with one focused read of official docs or your ecosystem notes.

## 5. Before “done”: walk the checklist

Use [unfamiliar-stack-ship.md](../../checklists/unfamiliar-stack-ship.md) as a rubric—not a daily todo.

## Related

- [Learning journey](learning-journey.md) — dependency path, optional week overlay, phase → reference skim.
- [Systems architect across languages](systems-architect-across-languages.md) — depth order for polyglot **design** literacy.
- [Term cards and vocabulary](../stacks/README.md) — definition + minimal example + failure mode.
- [Ecosystem maps](../stacks/README.md#ecosystem-maps-optional-short) — stack-specific vocabulary (Swift, Kotlin, Next/TS, .NET, PHP/Laravel, Python, SQL).
