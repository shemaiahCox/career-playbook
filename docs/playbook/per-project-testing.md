# Per-project testing (labs + AI)

How to choose **test layers**, use **AI assistants** responsibly, and stay aligned with each [project spec](../../project-specs/). **General theory** (pyramid, doubles, flaky tests) lives in the handbook: [Testing](../handbook/software-engineering.md#testing).

Using an LLM to draft tests is **optional**. These pages describe what to aim for and **example prompts** you can copy—whether you write tests by hand or with help.

## Habits (realistic for teams + AI)

- **You own** what must stay true: invariants, contracts, failure modes, and “this must never regress.”
- **AI helps** with boilerplate, table-driven cases, fixtures, and enumerating edges—after you state behavior in plain language.
- **You still review** every test: one clear reason to fail, stable assertions (prefer **public behavior** over private details), no gratuitous flakiness (time, network, ordering).

When a bug is understood, add a **regression** test so the failure mode stays visible—same loop as the [handbook debugging section](../handbook/software-engineering.md#debugging-workflow).

## Compare test approaches

| Approach | Best for | Signal / cost | Typical pitfall |
|----------|----------|---------------|-----------------|
| **Unit** | Pure functions, parsers, validators, deterministic domain rules | Fast, pinpoints logic bugs | Over-mocking; testing private methods—couples to implementation |
| **Integration** | HTTP + real DB/queue, migrations, “does it wire?” | Catches SQL and config mistakes | Slower; needs containers or shared test DB; avoid real external network in CI unless necessary |
| **Contract / schema** | APIs consumed by others; OpenAPI or consumer expectations | Catches field renames and type drift—high value under AI refactors | Must run in CI to matter; keep aligned with one spec artifact |
| **Eval / golden regression** (LLM/RAG) | Answer quality, grounding, “Paris not London” after prompt/model change | Behavioral regression for **non-deterministic** surface | Not a substitute for unit tests on chunking, routing, tool args—**both** matter |

**Rule of thumb:** Prefer **unit** where the code is deterministic and cheap to isolate; prefer **integration** where the bug class is “connected the wrong thing”; prefer **contract/eval** where the risk is **silent shape or answer drift**.

## Generic prompts for AI (adapt per lab)

Paste your real types, routes, and invariants. Ask for edits, not blind trust.

1. **Behavior first:** “Given [request/state], the system must [observable outcome]. List edge and failure cases; for each, suggest one test name and assertion focus.”
2. **Layer:** “Generate **unit** tests only for [function/module]—no DB.” / “Generate **integration** tests hitting [route] using [test DB / httpx / supertest pattern]; minimal mocking.”
3. **Regression:** “We fixed: [description]. Propose one test that fails on the old behavior and passes now.”
4. **Guardrails:** “Avoid testing private helpers; assert only **public** API or exported functions.” “Avoid real network calls; use [fake | container].”
5. **Contract:** “Given this OpenAPI fragment, generate a consumer test that fails if [field] is renamed or removed.”
6. **LLM:** “Given this eval JSONL schema, generate 5 more cases for [topic] with `expected_facts` and `must_not_contain`; no live model calls in the suggestion if keys are missing.”

## Lab index

Skim the **Testing approach (lab)** section in each spec for stack-specific emphasis and tailored prompts.

| Project | Spec | Typical primary layers |
|---------|------|-------------------------|
| 1 — Webhook receiver | [01-integration-webhook-receiver.md](../../project-specs/01-integration-webhook-receiver.md#testing-approach-lab) | Integration (HTTP + DB) + unit on crypto/idempotency helpers |
| 2 — Contract-first API | [02-contract-first-api.md](../../project-specs/02-contract-first-api.md#testing-approach-lab) | Contract/schema + CI drift gate |
| 3 — Observability | [03-observability-lab.md](../../project-specs/03-observability-lab.md#testing-approach-lab) | Integration or component tests on log/correlation shape |
| 4 — RAG / LLM | [04-rag-llm-service.md](../../project-specs/04-rag-llm-service.md#testing-approach-lab) | Eval JSONL + runner; unit on deterministic seams |
| 5 — Async worker | [05-async-worker-stretch.md](../../project-specs/05-async-worker-stretch.md#testing-approach-lab) | Integration (queue + worker + idempotency) |
| 6 — Node / TypeScript | [06-node-typescript-lab.md](../../project-specs/06-node-typescript-lab.md#testing-approach-lab) | Same as track (A→P1, B→P2, C→P5 patterns) |
| 7 — SQL performance | [07-sql-performance-lab.md](../../project-specs/07-sql-performance-lab.md#testing-approach-lab) | Exercise scripts + documented plan excerpts (correctness of SQL behavior) |
| 8 — Application security | [08-application-security-lab.md](../../project-specs/08-application-security-lab.md#testing-approach-lab) | Targeted **reproduction** scripts + checklist pass |

## Review checklist (before merge)

- Does this test fail for a **specific** wrong behavior (not “sync vs async noise”)?
- If AI wrote it, do assertions match **your** spec and README—not an invented API?
- For integration tests, is the environment **reproducible** (compose, fixtures)?
