# Project 5 — Contract-first API

## Progress

| | |
|---|---|
| **Step** | 5 of 22 |
| **Previous** | [Project 4 — SQL performance and correctness lab](04-sql-performance-lab.md) |
| **Next** | [Project 6 — Async worker](06-async-worker-stretch.md) |

## What you will learn

- Treat OpenAPI as the source of truth checked into git
- Gate breaking vs non-breaking changes in CI
- Version and deprecate APIs without orphaning consumers

## Before you start

- **Stack choice:** Laravel, FastAPI, or TypeScript — see [PHP map](../docs/languages/php-laravel.md) or [Node/TS map](../docs/languages/node-typescript-backend.md)
- **Handbook:** [REST](../docs/concepts/software-engineering.md#rest) · [Versioning](../docs/concepts/software-engineering.md#versioning-and-compatibility)

## Problem

Keep an API from silently breaking consumers when you (or AI assistants) refactor quickly.

## Career relevance

**Summary:** You practice making the **API contract** explicit and enforceable so refactors, new clients, and AI-generated code don’t silently break what the world thinks your API is.

### In depth

Public and partner APIs are **long-lived contracts**. Teams that treat the spec as the source of truth ship faster **with fewer production fires** and fewer angry emails from mobile or third-party integrators. The hard part isn’t writing endpoints—it’s **change management**: who is allowed to break whom, and how you catch drift before production.

**Why learning this moves the needle**

- **Velocity without thrash:** OpenAPI (or equivalent) gives designers, frontend, and external devs a **shared truth** before implementation lands. Mock servers and generated types turn integration from a **serial** negotiation into parallel work.
- **AI-assisted coding:** Generated code refactors easily break **field names and nullability**. A checked-in spec plus **contract checks in CI** catches those mistakes before merge: **OpenAPI diff** gates (breaking vs non-breaking), implementation-vs-spec validation (`spectral`, framework plugins), or **consumer-driven** contract tests (e.g. Pact-style)—exactly the failure mode teams hit when they “let the model” rename DTOs.
- **Platform credibility:** Publishing accurate docs, versioning, and deprecation policies is how you grow an **ecosystem** (marketplaces, agencies, enterprise procurement). Big customers often ask for **SLAs and stability** promises, not just “REST-ish JSON.”
- **Career signal:** “I can define a breaking change and roll it out safely” reads as **mid/senior API discipline**, not just CRUD. You want stories about **deprecation windows**, consumer-driven contracts, and rolling out **`v2`** without orphaning `v1`.

**Real-world situations this project mirrors**

- **Mobile / SPA drift:** the app still sends `camelCase` while the server “cleanup” renames to **`snake_case`**—screens go blank or crash because optional UI state depended on a field that disappeared.
- **Partner integrations** that **worked last quarter** until an optional field became required, a type changed (`"123"` vs `123`), or an error shape stopped including a field their parser assumed was always present.
- **Audit and reviews:** legal or security asks what the API **guaranteed** at release time; `openapi.yaml` committed next to the code is a cheap, reviewable artifact (especially compared to stale wiki pages).
- **Multi-team codegen:** you need a **TypeScript or Kotlin client** (or internal SDK) without hand-writing DTOs—the spec becomes the **single generator input** for all consumers.

## Important concepts

### Concept spotlight

| **OpenAPI as source of truth** | Check in `openapi.yaml`; validate implementation against spec in CI |
| **Breaking vs non-breaking change** | Document and gate renames, required fields, error shape changes |
| **Versioning discipline** | Path or header versioning; deprecation window for consumers |

**Interview line:** *“The OpenAPI file is the contract—we diff it in CI and treat breaking changes like API semver, not surprise refactors.”*


**Interview line:** *“The OpenAPI file is the contract—we diff it in CI and treat breaking changes like API semver, not surprise refactors.”*

## Code repo

_TBD — create a sibling repo (e.g. `contract-api-lab`) when you start._ Link it here.

GitHub template once created: `https://github.com/shemaiahCox/<repo-name>`

## Stack (suggestion)

Laravel or FastAPI + OpenAPI document checked into git. **Node + TypeScript:** implement [Project 7 — track B](07-node-typescript-lab.md) as the same exercise with Zod/pino (or equivalent).

**Deeper SQL:** List and detail endpoints are where N+1 and pagination mistakes show up—see [Project 4 — SQL performance lab](04-sql-performance-lab.md) for deliberate Postgres exercises.

### Key concepts (with definitions and patterns)

### OpenAPI (formerly Swagger)

**What:** A **machine-readable description** of your HTTP API (paths, methods, request/response schemas, error shapes)—usually a `openapi.yaml` / `openapi.json` checked into git.

**Problem it solves:** Humans and tools agree on **what “correct” looks like** before code ships. You can generate **docs**, **clients**, and **mock servers**.

**Illustrative snippet** (not from a repo yet—shape to copy):

```yaml
paths:
  /v1/orders/{id}:
    get:
      responses:
        '200':
          content:
            application/json:
              schema:
                type: object
                required: [id, status]
                properties:
                  id: { type: string }
                  status: { type: string, enum: [pending, paid] }
```

### Contract / consumer test

**What:** A test where a **consumer** (or a fake consumer in CI) asserts the **real server** still matches expected response **fields and types**.

**Problem it solves:** Your refactor renamed `userId` → `user_id`—**compilation** might still pass server-side, but mobile/web breaks. Contract tests **fail the build** when you break the promise.

**Illustrative** Pact-style idea:

```typescript
// Pseudo: consumer expectation
expect(response.body).toMatchSchema({
  type: "object",
  required: ["id", "status"],
  properties: { id: { type: "string" }, status: { type: "string" } },
});
```

### Breaking vs non-breaking API change

**What:**

- **Non-breaking:** Adding optional fields, new endpoints, widening enums consumers already accept.
- **Breaking:** Removing fields, renaming fields, changing types, tightening validation so old clients fail.

**Problem it solves:** Lets you **version** or **gate** releases (deprecation windows) instead of surprising partners.

**Practice:** Before merge, run `openapi-diff old.yaml new.yaml` (or equivalent) and document the policy in README.

## Testing approach (lab)

**Primary:** **Contract or schema tests** (consumer stub, response shape assertions against OpenAPI, or framework-native “implements spec” checks) plus a **CI gate** so spec and implementation cannot drift silently—this is the main failure mode when AI renames DTO fields.

**Secondary:** Narrow **integration** tests for happy-path HTTP and documented error envelopes—prove **status + JSON error shape**, not only `200` on golden requests.

**Compare:** Contract tests **beat** deep unit suites that mock every repository here: the risk being mitigated is **compatibility**, not algorithmic cleverness. Unit tests still help for **pure validation** helpers if you extract them.

**Example asks for AI (optional):**  
“From this `openapi.yaml` [paste], generate a test that fails if `userId` is removed from `GET /users/{id}` response or renamed. Use [Pact | jest + schema | spectral pipeline] as I specify.”  
“Add a CI script that runs `openapi-diff` or spectral against the checked-in spec and fails on breaking changes—document exit codes in README.”

**Shared patterns:** [Per-project testing (labs + AI)](../docs/concepts/per-project-testing.md).

## Success criteria

- [ ] OpenAPI 3 spec defines resources and error shapes.
- [ ] Server generated from spec or spec validated against implementation (choose one approach and document it).
- [ ] **Breaking-change ritual:** document in README (e.g. `openapi-diff` in CI, or manual checklist before merge).
- [ ] **CI or pre-merge gate** that fails when spec and implementation drift—automated diff/lint against `openapi.yaml`, consumer contract test, or equivalent (pick one; mirror how AI-heavy teams prevent silent DTO churn).
- [ ] One **contract test** or consumer stub that fails if response shape drifts.

## Exploration scenarios

Use these once the lab repo exists; wire **copy-paste HTTP examples** into that repo’s README. Goal: prove the **contract** is enforced, not only that endpoints return `200`.

### 1 — Spec matches reality

- **Setup:** OpenAPI checked in; server running.
- **Action:** Call each documented path with examples from `openapi.yaml` (happy path).
- **Expected outcome:** Status codes and JSON bodies match **required fields and types** in the spec.

### 2 — Consumer / schema test catches drift

- **Setup:** Passing contract or schema test on `main`.
- **Action:** Rename a response field or drop a `required` property in the handler **without** updating spec/test.
- **Expected outcome:** CI or local test **fails** before merge.

### 3 — Non-breaking additive change

- **Action:** Add an **optional** response field; run contract tests + `openapi-diff` (or equivalent) against previous spec artifact.
- **Expected outcome:** Tests still pass; diff labeled **non-breaking** per your README policy.

### 4 — Breaking change ritual

- **Action:** Remove or rename a field consumers rely on; run breaking-change ritual (`openapi-diff`, semver bump, or deprecation checklist).
- **Expected outcome:** Procedure forces explicit **version or deprecation** note—you don’t ship silently.

### 5 — Error shape stability

- **Action:** Trigger validation error (`400`), not-found (`404`), conflict (`409`)—whatever your API defines.
- **Expected outcome:** Error bodies match documented **error schema** (same envelope keys every time).

### 6 — Pagination / list contract (if applicable)

- **Action:** Hit list endpoint with valid and invalid query params.
- **Expected outcome:** Documented defaults; stable sort keys for consumers building UI—pairs well with [Project 4](04-sql-performance-lab.md) for performance stories later.

## Bash scripting milestone

Ship `scripts/openapi-diff-check.sh` (stretch) — fail CI when OpenAPI spec drifts from committed artifact; strict mode.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — OpenAPI contract → validation layer → handlers → persistence.
- [ ] **ADR** — versioning strategy (URL prefix vs header) and breaking-change policy.
- [ ] **Performance numbers** — list endpoint p95 or validation overhead baseline.
- [ ] **Failure modes** — silent schema drift; consumers break on undeclared breaking change.
- [ ] **Observability evidence** — log with `request_id` on validation error path.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 5)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 6 — Async worker](06-async-worker-stretch.md)
