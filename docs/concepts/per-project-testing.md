# Per-project testing (labs + AI)

**Use this:** When a lab spec’s **Testing approach** section asks what to write—and how to use AI without shipping fantasy tests.

**Reading order:** [Software engineering § Testing](software-engineering.md#testing) (theory) → **this doc** (lab habits + prompts) → your **phase** spec’s test section.

**Companion:** [Debugging workflow](software-engineering.md#debugging-workflow) · [Glossary](software-engineering-glossary.md)

General theory (pyramid, doubles, flaky tests) lives in the handbook. Using an LLM to draft tests is **optional**—you still review every assertion.

## Habits (realistic for teams + AI)

You own what must stay true: invariants, contracts, failure modes, and "this must never regress." AI helps with boilerplate, table-driven cases, fixtures, and enumerating edges — but only after you state behavior in plain language. You still review every test: one clear reason to fail, stable assertions (prefer **public behavior** over private details), and no gratuitous flakiness from time, network, or ordering.

When a bug is understood, add a **regression** test so the failure mode stays visible — same loop as the [handbook debugging section](software-engineering.md#debugging-workflow).

## Compare test approaches

| Approach | Best for | Signal / cost | Typical pitfall |
|----------|----------|---------------|-----------------|
| **Unit** | Pure functions, parsers, validators, deterministic domain rules | Fast, pinpoints logic bugs | Over-mocking; testing private methods — couples to implementation |
| **Integration** | HTTP + real DB/queue, migrations, "does it wire?" | Catches SQL and config mistakes | Slower; needs containers or shared test DB; avoid real external network in CI unless necessary |
| **Contract / schema** | APIs consumed by others; OpenAPI or consumer expectations | Catches field renames and type drift — high value under AI refactors | Must run in CI to matter; keep aligned with one spec artifact |
| **Eval / golden regression** (LLM/RAG) | Answer quality, grounding, "Paris not London" after prompt/model change | Behavioral regression for **non-deterministic** surface | Not a substitute for unit tests on chunking, routing, tool args — **both** matter |

**Rule of thumb:** Prefer **unit** tests where the code is deterministic and cheap to isolate. Prefer **integration** tests where the bug class is "connected the wrong thing." Prefer **contract/eval** tests where the risk is **silent shape or answer drift**.

## Examples by product type

| Product type | Primary test | Example assertion |
|--------------|--------------|-------------------|
| **Webhook ingress** | Integration | Replay same `Idempotency-Key` → one side effect |
| **Contract API** | OpenAPI/schema | Rename response field → CI fails |
| **Queue worker** | Integration | Duplicate delivery → dedupe store hit |
| **LLM/RAG** | Eval JSONL | `must_not_contain` after prompt change |
| **Multi-tenant API** | Integration | Tenant A token cannot read tenant B row |
| **Shell toolkit** | bats | Missing env → exit code 2 |

## Generic prompts for AI (adapt per lab)

Paste your real types, routes, and invariants. Ask for edits, not blind trust.

1. **Behavior first:** "Given [request/state], the system must [observable outcome]. List edge and failure cases; for each, suggest one test name and assertion focus."
2. **Layer:** "Generate **unit** tests only for [function/module] — no DB." / "Generate **integration** tests hitting [route] using [test DB / httpx / supertest pattern]; minimal mocking."
3. **Regression:** "We fixed: [description]. Propose one test that fails on the old behavior and passes now."
4. **Guardrails:** "Avoid testing private helpers; assert only **public** API or exported functions." "Avoid real network calls; use [fake | container]."
5. **Contract:** "Given this OpenAPI fragment, generate a consumer test that fails if [field] is renamed or removed."
6. **LLM:** "Given this eval JSONL schema, generate 5 more cases for [topic] with `expected_facts` and `must_not_contain`; no live model calls in the suggestion if keys are missing."

## Lab index (follows project order)

Skim the **Testing approach (lab)** section in each spec for stack-specific emphasis and tailored prompts.

| Project | Spec | Typical primary layers |
|---------|------|-------------------------|
| 1 — Webhook receiver | [01-integration-webhook-receiver.md](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md#testing-approach-lab) | Integration (HTTP + DB) + unit on crypto/idempotency |
| 2 — RAG / LLM | [02-rag-llm-service.md](../../archive/v1-22-step/career-project-specs/02-rag-llm-service.md#testing-approach-lab) | Eval JSONL + runner; unit on deterministic seams |
| 3 — Observability | [03-observability-lab.md](../../archive/v1-22-step/career-project-specs/03-observability-lab.md#testing-approach-lab) | Integration on log/correlation shape |
| 4 — SQL performance | [04-sql-performance-lab.md](../../archive/v1-22-step/career-project-specs/04-sql-performance-lab.md#testing-approach-lab) | Exercise scripts + documented plan excerpts |
| 5 — Contract-first API | [05-contract-first-api.md](../../archive/v1-22-step/career-project-specs/05-contract-first-api.md#testing-approach-lab) | Contract/schema + CI drift gate |
| 6 — Async worker | [06-async-worker-stretch.md](../../archive/v1-22-step/career-project-specs/06-async-worker-stretch.md#testing-approach-lab) | Integration (queue + worker + idempotency) |
| 7 — Node / TypeScript | [07-node-typescript-lab.md](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md#testing-approach-lab) | Same patterns as Projects 1/5/6 tracks |
| 8 — Go retrieval/worker | [08-go-retrieval-worker-lab.md](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md#testing-approach-lab) | Table-driven unit + integration (queue/idempotency) |
| 9 — Application security | [09-application-security-lab.md](../../archive/v1-22-step/career-project-specs/09-application-security-lab.md#testing-approach-lab) | Reproduction scripts + checklist pass |
| 10 — Automation bot | [10-automation-bot-lab.md](../../archive/v1-22-step/career-project-specs/10-automation-bot-lab.md#testing-approach-lab) | Integration on workflow step + idempotency |
| 11 — LLM web app | [11-llm-web-app-lab.md](../../archive/v1-22-step/career-project-specs/11-llm-web-app-lab.md#testing-approach-lab) | Component + eval-aware error paths |
| 12 — Multi-tenant auth | [12-multi-tenant-auth-lab.md](../../archive/v1-22-step/career-project-specs/12-multi-tenant-auth-lab.md#testing-approach-lab) | Integration on tenant isolation |
| 13 — Real-time dashboard | [13-realtime-dashboard-lab.md](../../archive/v1-22-step/career-project-specs/13-realtime-dashboard-lab.md#testing-approach-lab) | Component tests on reconnect/backpressure |
| 14 — Shell automation | [14-shell-automation-lab.md](../../archive/v1-22-step/career-project-specs/14-shell-automation-lab.md#testing-approach-lab) | bats + shellcheck; integration smoke against compose |
| 15 — DevOps CLI | [15-devops-cli-lab.md](../../archive/v1-22-step/career-project-specs/15-devops-cli-lab.md#testing-approach-lab) | Table-driven CLI + exit codes |
| 16 — Cloud deploy | [16-cloud-deploy-lab.md](../../archive/v1-22-step/career-project-specs/16-cloud-deploy-lab.md#testing-approach-lab) | Smoke / health-check integration; `post-deploy-smoke.sh` |
| 17 — K8s controller | [17-k8s-controller-lab.md](../../archive/v1-22-step/career-project-specs/17-k8s-controller-lab.md#testing-approach-lab) | Reconcile loop unit + envtest-style integration |
| 18 — Proxy / LB | [18-proxy-load-balancer-lab.md](../../archive/v1-22-step/career-project-specs/18-proxy-load-balancer-lab.md#testing-approach-lab) | Integration under timeout/load scenarios |
| 19 — Rust hot-path | [19-rust-hot-path-lab.md](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md#testing-approach-lab) | Contract parity vs Project 8 + benchmarks |
| 20 — WASM component | [20-wasm-secure-component-lab.md](../../archive/v1-22-step/career-project-specs/20-wasm-secure-component-lab.md#testing-approach-lab) | Sandbox boundary + FFI tests |
| 21 — IoT / edge | [21-iot-edge-lab.md](../../archive/v1-22-step/career-project-specs/21-iot-edge-lab.md#testing-approach-lab) | Integration on MQTT idempotency + offline buffer |
| 22 — Integrated capstone | [22-integrated-platform-capstone.md](../../archive/v1-22-step/career-project-specs/22-integrated-platform-capstone.md#testing-approach-lab) | End-to-end (E2E) smoke (`demo.sh`) + tenant isolation + cross-service trace |

## Review checklist (before merge)

- Does this test fail for a **specific** wrong behavior (not "sync vs async noise")?
- If AI wrote it, do assertions match **your** spec and README — not an invented API?
- For integration tests, is the environment **reproducible** (compose, fixtures)?

---

## Technical reference

### Test layers (one line each)

| Layer | When |
|-------|------|
| **Unit** | Deterministic logic, parsers, validators |
| **Integration** | HTTP + DB/queue wiring |
| **Contract / schema** | OpenAPI or consumer expectations in CI |
| **Eval / golden** | LLM/RAG answer drift (non-deterministic surface) |

### Pre-merge checklist

- [ ] Test fails for a **specific** wrong behavior
- [ ] Assertions match **your** spec, not invented APIs
- [ ] Integration env is **reproducible** (compose, fixtures)
- [ ] AI-generated tests assert **public** behavior only

### Glossary

[Mock (test double)](software-engineering-glossary.md#mock-test-double) · [Idempotency](software-engineering-glossary.md#idempotency) · [Regression test](software-engineering-glossary.md#regression-test)
