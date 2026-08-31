# Checklist — shipping a large language model (LLM) / retrieval-augmented generation (RAG) feature

Use this for any user-facing model path (internal or external).

## Product and scope

**Why:** LLM features fail in production when scope and forbidden uses are undefined—support and legal need explicit boundaries.

**Handbook:** [LLMs](../docs/concepts/llms.md) · [Project 2](../archive/v1-22-step/career-project-specs/02-rag-llm-service.md)

These items define what the feature is for and what it must not do.

- [ ] Clear **forbidden uses** (legal, medical, etc.) if applicable.
- [ ] **Grounding policy** — when must the model cite retrieval vs general knowledge?

## Safety and data

These items protect users and keep sensitive data out of prompts and logs.

- [ ] **Prompt injection** — untrusted content (user mail, web pages) never mixed into system instructions without sandboxing; document mitigations.
- [ ] **Personally identifiable information (PII)** — classification of what may be sent to the provider; retention policy.
- [ ] **Secrets** — API keys only via environment variables; no logging of prompts containing tokens.

## Evaluation

**Why:** Model and prompt changes regress silently without a checked-in eval set—JSONL regression is the LLM equivalent of contract tests.

**Handbook:** [LLMs — evaluation](../docs/concepts/llms.md#evaluation-and-regression-on-model-outputs)

These items catch regressions when you change models or prompts.

- [ ] **Eval set** checked in (JSONL or similar) with stable cases.
- [ ] **Regression** — script or continuous integration (CI) step runs evals on model/prompt changes.

**Pass:** CI fails when eval score drops on golden cases. **Fail:** prompt change ships with no eval run.
- [ ] **Human spot-check** rubric for first release.

## Operations

These items keep the feature reliable and observable in production.

- [ ] **Timeouts** and fallback behavior (degrade gracefully message).
- [ ] **Logging** — request id, latency, model id, token usage if available; no full prompt in production if policy forbids.
- [ ] **Cost** — rough $/1k requests or monthly cap awareness.

## Engineering

These items limit abuse and make debugging possible after deploy.

- [ ] Rate limits on public endpoints.
- [ ] Tool allowlist if using agents; no arbitrary shell/file tools in production.
- [ ] Version prompts / retrieval index (`git` or artifact version in responses for debugging).
