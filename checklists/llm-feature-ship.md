# Checklist — shipping an LLM / RAG feature

Use for any user-facing model path (internal or external).

## Product & scope

- [ ] Clear **forbidden uses** (legal, medical, etc.) if applicable.
- [ ] **Grounding policy** — when must the model cite retrieval vs general knowledge?

## Safety & data

- [ ] **Prompt injection** — untrusted content (user mail, web pages) never mixed into system instructions without sandboxing; document mitigations.
- [ ] **PII** — classification of what may be sent to the provider; retention policy.
- [ ] **Secrets** — API keys only via env; no logging of prompts containing tokens.

## Evaluation

- [ ] **Eval set** checked in (JSONL or similar) with stable cases.
- [ ] **Regression** — script or CI step runs evals on model/prompt changes.
- [ ] **Human spot-check** rubric for first release.

## Operations

- [ ] **Timeouts** and fallback behavior (degrade gracefully message).
- [ ] **Logging** — request id, latency, model id, token usage if available; no full prompt in prod if policy forbids.
- [ ] **Cost** — rough $/1k requests or monthly cap awareness.

## Engineering

- [ ] Rate limits on public endpoints.
- [ ] Tool allowlist if using agents; no arbitrary shell/file tools in prod.
- [ ] Version prompts / retrieval index (`git` or artifact version in responses for debugging).
