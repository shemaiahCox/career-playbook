# Project 6 — Node / TypeScript service lab (optional parity)

## Problem

Ship **one** small production-shaped HTTP service in **Node + TypeScript** so your playbook covers the same integration and API habits as [Project 1](01-integration-webhook-receiver.md) / [Project 2](02-contract-first-api.md) / [Project 5](05-async-worker-stretch.md)—in the stack many SaaS teams default to for APIs and BFFs.

**Pick one focus** (avoid three half-finished repos):

| Track | What you prove | Overlaps |
|-------|----------------|----------|
| **A — Webhook parity** | HMAC verify, idempotency, structured logs, dead-letter or safe 500 story | [Project 1](01-integration-webhook-receiver.md) |
| **B — Contract-first API** | OpenAPI checked in, validation + error shapes, breaking-change ritual | [Project 2](02-contract-first-api.md) |
| **C — Webhook + worker** | HTTP validates + enqueues; worker idempotent; DLQ | [Project 1](01-integration-webhook-receiver.md) + [Project 5](05-async-worker-stretch.md) |

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
- **BFF** that aggregates internal services for a **React/Next** app; TS end-to-end is the common setup.
- **Queue workers** with **BullMQ** / Redis mirroring Laravel queues—**at-least-once** and **idempotent handlers** are the same concepts under production load as in PHP/Python labs.

## Code repo

_TBD — create a sibling repo (e.g. `ts-webhook-lab` or `ts-api-lab`) when you start._ Link GitHub + local path here.

## Stack (suggestion)

- **Runtime:** **Active Node.js LTS** (track [nodejs.org release schedule](https://nodejs.org/en/about/previous-releases); **22+** at time of writing). Prefer LTS over “current” for labs meant to age gracefully.
- **Language:** **TypeScript** (strict mode in `tsconfig` where you can tolerate it).
- **HTTP:** **Fastify** or **Express** (pick one; document why in README).
- **Validation:** **Zod** (or equivalent) for body/headers/query; aligns with “contract in code.”
- **Logging:** **pino** (JSON lines) or structured logger with **`request_id`** on every line.
- **OpenAPI (track B):** Generated from Zod (`@asteasolutions/zod-to-openapi` or similar) **or** hand-maintained `openapi.yaml`—match the approach in [Project 2](02-contract-first-api.md).
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

## Success criteria

- [ ] **README** states track **A**, **B**, or **C** and points to this spec.
- [ ] **`npm`/`pnpm` scripts:** `build`, `start` (and `test` if you add tests).
- [ ] **Structured logs** with **`request_id`** (accept `X-Request-Id` or generate).
- [ ] Track **A:** HMAC verification + idempotency + behavior on replay documented (mirror [Project 1](01-integration-webhook-receiver.md) success criteria in TS).
- [ ] Track **B:** OpenAPI artifact in repo + validation matches spec + breaking-change note in README.
- [ ] Track **C:** Enqueue from HTTP path + worker with **duplicate delivery** story (README diagram or bullet list).
- [ ] **No secrets in git** — `.env.example` only.

## Exploration scenarios

Pick scenarios for **your declared track** (A, B, or C). **Track A** mirrors [Project 1 — Exploration scenarios](01-integration-webhook-receiver.md); **track B** mirrors [Project 2 — Exploration scenarios](02-contract-first-api.md); **track C** combines P1 HTTP edge cases with [Project 5 — Exploration scenarios](05-async-worker-stretch.md). Implement curls and signatures in the **TS lab README** (`rawBody` before `JSON.parse` for HMAC).

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

## Maps to

Flexible backend hiring (Node/TS shops), full-stack-adjacent roles, same **integration reliability** story as PHP/Python labs.
