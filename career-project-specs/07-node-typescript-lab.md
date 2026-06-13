# Project 7 — Node / TypeScript service lab

## Progress

| | |
|---|---|
| **Step** | 7 of 21 |
| **Previous** | [Project 6 — Async worker](06-async-worker-stretch.md) |
| **Next** | [Project 8 — Go retrieval gateway and worker lab](08-go-retrieval-worker-lab.md) |

## What you will learn

- Build a typed HTTP service with the same integration habits as Project 1
- Optional tracks: webhook ingress, contract API, or webhook + worker
- Structured logging and queue vocabulary in TypeScript

## Before you start

- **New to TypeScript/Node?** → [Node + TS map](../docs/languages/node-typescript-backend.md) · [Stacks glossary](../docs/languages/glossary.md)
- **Handbook:** [REST](../docs/concepts/software-engineering.md#rest) · [Language fundamentals](../docs/languages/language-fundamentals-comparison.md)

## Problem

Ship **one** small production-shaped HTTP service in **Node + TypeScript** so your playbook covers the same integration and API habits as [Project 1](01-integration-webhook-receiver.md) / [Project 5](05-contract-first-api.md) / [Project 6](06-async-worker-stretch.md)—in the stack many SaaS teams default to for APIs and BFFs.

**Pick one focus** (avoid three half-finished repos):

| Track | What you prove | Overlaps |
|-------|----------------|----------|
| **A — Webhook parity** | HMAC verify, idempotency, structured logs, dead-letter or safe 500 story | [Project 1](01-integration-webhook-receiver.md) |
| **B — Contract-first API** | OpenAPI checked in, validation + error shapes, breaking-change ritual | [Project 5](05-contract-first-api.md) |
| **C — Webhook + worker** | HTTP validates + enqueues; worker idempotent; DLQ | [Project 1](01-integration-webhook-receiver.md) + [Project 6](06-async-worker-stretch.md) |

## Career relevance

**Summary:** **TypeScript on the backend** maximizes **flexibility** across employers: shared types with modern frontends, huge library surface, and **ecosystem familiarity**—without replacing the **patterns** you already practice in PHP or Python.

### In depth

This is not about chasing every new JS framework; it is about **one disciplined service** that shows you can work in **JS-first orgs** and speak **Zod/OpenAPI/pino/BullMQ**-class tooling when job posts ask for it. The **durable** part is the same as everywhere else: **idempotency, signatures, logs, queues**.

**Why learning this moves the needle**

- **Market breadth:** Many “backend engineer” listings assume **Node** is at least comfortable; a small **typed** repo is easier to defend than “I can learn it on the job” with zero artifacts.
- **Shared vocabulary with frontend:** When the UI is **TypeScript**, a TS API or BFF reduces **DTO drift** and makes code review friendlier across the stack.
- **Same seniority signals:** Everything in [checklists/integration-hardening.md](../checklists/integration-hardening.md) still applies; you are proving **polyglot discipline**, not a second junior tutorial.

**Real-world situations this project mirrors**

- **Greenfield API** in a startup that standardized on **Node + TS** while your last job was PHP/Laravel—you already know the integration playbook; this is **syntax + ecosystem**.
- **BFF** that aggregates internal services; TS end-to-end with your API consumers.
- **Queue workers** with **BullMQ** / Redis mirroring Laravel queues—**at-least-once** and **idempotent handlers** are the same concepts under production load as in PHP/Go labs.

**Stretch:** Custom **n8n node** (TypeScript)—same reliability habits (errors, secrets, idempotency) in a workflow step; see [integration-automation map](../docs/concepts/integration-automation.md).

## Important concepts

### Concept spotlight

| **Typed API boundary** | Strict TS validation (Zod or equivalent) on body/headers/query |
| **Integration parity** | Track A: HMAC + idempotency like [Project 1](01-integration-webhook-receiver.md); Track C: queue + worker |
| **Contract in code** | Track B: OpenAPI aligned with [Project 5](05-contract-first-api.md) |

**Interview line:** *“Our TS service uses schema-first validation and the same idempotency habits as our PHP webhook—polyglot discipline, not different reliability rules per language.”*


**Interview line:** *“Our TS service uses schema-first validation and the same idempotency habits as our PHP webhook—polyglot discipline, not different reliability rules per language.”*

## Code repo

_TBD — create a sibling repo (e.g. `ts-webhook-lab` or `ts-api-lab`) when you start._ Link GitHub + local path here.

## Stack (suggestion)

- **Runtime:** **Active Node.js LTS** (track [nodejs.org release schedule](https://nodejs.org/en/about/previous-releases); **22+** at time of writing). Prefer LTS over “current” for labs meant to age gracefully.
- **Language:** **TypeScript** (strict mode in `tsconfig` where you can tolerate it).
- **HTTP:** **Fastify** or **Express** (pick one; document why in README).
- **Validation:** **Zod** (or equivalent) for body/headers/query; aligns with “contract in code.”
- **Logging:** **pino** (JSON lines) or structured logger with **`request_id`** on every line.
- **OpenAPI (track B):** Generated from Zod (`@asteasolutions/zod-to-openapi` or similar) **or** hand-maintained `openapi.yaml`—match the approach in [Project 5](05-contract-first-api.md).
- **Queue (track C):** **BullMQ** + Redis, or **SQS**-style consumer—document **retry, DLQ, idempotency key** in README.

## Key concepts (short)

### Types as a lightweight contract

**What:** TS types + runtime validation (Zod) catch **shape drift** at the boundary before bad data hits business logic.

**Problem it solves:** Same class of bugs as unchecked JSON in PHP—early failures, clearer 5xx vs **400** policy.

### Raw body before JSON parse (HMAC track)

**What:** Verify signature on **exact bytes** the sender signed; only then `JSON.parse`.

**Problem it solves:** Re-encoding changes bytes → signature false negatives; same lesson as Project 1’s `php://input` note.

### Idempotency in TS services

**What:** Reuse the **same key semantics** as Project 1 (`Idempotency-Key` header + store).

**Problem it solves:** Proves the **concept** is portable—SQLite, Redis, or Postgres is an implementation detail.

## Testing approach (lab)

**Primary:** Follow the **track** you declared—**A:** mirror [Project 1](01-integration-webhook-receiver.md) (HTTP + HMAC + idempotency + integration tests); **B:** mirror [Project 5](05-contract-first-api.md) (contract/schema + drift gate); **C:** mirror [Project 6](06-async-worker-stretch.md) (queue + worker + duplicate delivery).

**Secondary:** Add `npm test` / `pnpm test` with **Vitest** or **Jest**; enforce **raw body** before JSON parse on track A when testing signatures.

**Compare:** Do not invent a fourth style per repo—reuse the same layer choices as the PHP/Python analogue so vocabulary transfers.

**Example asks for AI (optional):**  
“Track A: scaffold supertest (or undici) tests for raw-body HMAC verification; show how to pass raw buffer so re-encoding does not break signature.”  
“Track B: generate Zod schemas from OpenAPI or dual-check response against OpenAPI component—tests fail on rename.”

**Shared patterns:** [Per-project testing (labs + AI)](../docs/concepts/per-project-testing.md).

## Success criteria

- [ ] **README** states track **A**, **B**, or **C** and points to this spec.
- [ ] **`npm`/`pnpm` scripts:** `build`, `start` (and `test` if you add tests).
- [ ] **Structured logs** with **`request_id`** (accept `X-Request-Id` or generate).
- [ ] Track **A:** HMAC verification + idempotency + behavior on replay documented (mirror [Project 1](01-integration-webhook-receiver.md) success criteria in TS).
- [ ] Track **B:** OpenAPI artifact in repo + validation matches spec + breaking-change note in README.
- [ ] Track **C:** Enqueue from HTTP path + worker with **duplicate delivery** story (README diagram or bullet list).
- [ ] **No secrets in git** — `.env.example` only.

## Exploration scenarios

Pick scenarios for **your declared track** (A, B, or C). **Track A** mirrors [Project 1 — Exploration scenarios](01-integration-webhook-receiver.md); **track B** mirrors [Project 5 — Exploration scenarios](05-contract-first-api.md); **track C** combines Project 1 HTTP edge cases with [Project 6 — Exploration scenarios](06-async-worker-stretch.md). Implement curls and signatures in the **TS lab README** (`rawBody` before `JSON.parse` for HMAC).

### Track A — Webhook parity (subset)

1. **Happy signed delivery** — valid `X-Signature`, `Idempotency-Key`, structured logs with `request_id`.
2. **Replay** — same key → same outcome; DB proves no duplicate effect.
3. **Bad/missing signature** → `401`.
4. **Concurrent same-key requests** — expect `409` or documented race handling.

### Track B — Contract-first API (subset)

1. **Happy path** matches OpenAPI / Zod schemas.
2. **Contract test fails** when handler field renamed without updating artifact.
3. **Additive optional field** — non-breaking per diff ritual in README.

### Track C — Webhook + worker (subset)

1. HTTP **enqueue + fast 2xx**; job recorded.
2. Worker **success** → ack; queue empty for that job.
3. **Duplicate delivery** or crash-before-ack → **one** side-effect thanks to idempotency keys.
4. **DLQ** after permanent failure—inspect payload + reason.

### All tracks

- **Structured logs:** grep JSON lines by `request_id` for one failing request.
- **Stretch:** Docker Compose healthchecks; CI runs `typecheck` on PR.

## Stretch

- Dockerfile + `docker compose` for app + Redis (if using queue).
- GitHub Action: `typecheck` + `lint` on PR.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — track-specific (webhook A, OpenAPI B, or queue C) HTTP boundaries.
- [ ] **ADR** — framework choice (Express vs Fastify) or OpenAPI generation approach.
- [ ] **Performance numbers** — HTTP p95 for primary track endpoint.
- [ ] **Failure modes** — HMAC on parsed body; replay without idempotency (track A/C).
- [ ] **Observability evidence** — JSON log with correlation id on one curl path.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 7)
- Checklist: [Integration hardening checklist](../checklists/integration-hardening.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 8 — Go retrieval gateway and worker lab](08-go-retrieval-worker-lab.md)
