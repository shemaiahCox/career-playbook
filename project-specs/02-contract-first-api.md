# Project 2 — Contract-first API

## Problem

Keep an API from silently breaking consumers when you (or AI assistants) refactor quickly.

## Career relevance

**Summary:** You practice making the **API contract** explicit and enforceable so refactors, new clients, and AI-generated code don’t silently break what the world thinks your API is.

### In depth

Public and partner APIs are **long-lived contracts**. Teams that treat the spec as the source of truth ship faster **with fewer production fires** and fewer angry emails from mobile or third-party integrators. The hard part isn’t writing endpoints—it’s **change management**: who is allowed to break whom, and how you catch drift before production.

**Why learning this moves the needle**

- **Velocity without thrash:** OpenAPI (or equivalent) gives designers, frontend, and external devs a **shared truth** before implementation lands. Mock servers and generated types turn integration from a **serial** negotiation into parallel work.
- **AI-assisted coding:** Generated code refactors easily break **field names and nullability**. A checked-in spec plus **contract or diff checks** catches those mistakes in CI instead of in user devices—exactly the failure mode teams hit when they “let the model” rename DTOs.
- **Platform credibility:** Publishing accurate docs, versioning, and deprecation policies is how you grow an **ecosystem** (marketplaces, agencies, enterprise procurement). Big customers often ask for **SLAs and stability** promises, not just “REST-ish JSON.”
- **Career signal:** “I can define a breaking change and roll it out safely” reads as **mid/senior API discipline**, not just CRUD. You want stories about **deprecation windows**, consumer-driven contracts, and rolling out **`v2`** without orphaning `v1`.

**Real-world situations this project mirrors**

- **Mobile / SPA drift:** the app still sends `camelCase` while the server “cleanup” renames to **`snake_case`**—screens go blank or crash because optional UI state depended on a field that disappeared.
- **Partner integrations** that **worked last quarter** until an optional field became required, a type changed (`"123"` vs `123`), or an error shape stopped including a field their parser assumed was always present.
- **Audit and reviews:** legal or security asks what the API **guaranteed** at release time; `openapi.yaml` committed next to the code is a cheap, reviewable artifact (especially compared to stale wiki pages).
- **Multi-team codegen:** you need a **TypeScript or Kotlin client** (or internal SDK) without hand-writing DTOs—the spec becomes the **single generator input** for all consumers.

## Code repo

_TBD — create a sibling repo (e.g. `contract-api-lab`) when you start._ Link it here.

GitHub template once created: `https://github.com/shemaiahCox/<repo-name>`

## Stack (suggestion)

Laravel or FastAPI + OpenAPI document checked into git. **Node + TypeScript:** implement [Project 6 — track B](06-node-typescript-lab.md) as the same exercise with Zod/pino (or equivalent).

**Deeper SQL:** List and detail endpoints are where N+1 and pagination mistakes show up—see [Project 7 — SQL performance lab](07-sql-performance-lab.md) for deliberate Postgres exercises.

## Key concepts (with definitions and patterns)

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

## Success criteria

- [ ] OpenAPI 3 spec defines resources and error shapes.
- [ ] Server generated from spec or spec validated against implementation (choose one approach and document it).
- [ ] **Breaking-change ritual:** document in README (e.g. `openapi-diff` in CI, or manual checklist before merge).
- [ ] One **contract test** or consumer stub that fails if response shape drifts.

## Maps to

Platform engineering, API longevity, safer velocity with AI-assisted coding.
