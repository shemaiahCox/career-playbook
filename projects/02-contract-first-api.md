# Project 2 — Contract-first API

## Problem

Keep an API from silently breaking consumers when you (or AI assistants) refactor quickly.

## Code repo

_TBD — create a sibling repo (e.g. `contract-api-lab`) when you start._ Link it here.

GitHub template once created: `https://github.com/shemaiahCox/<repo-name>`

## Stack (suggestion)

Laravel or FastAPI + OpenAPI document checked into git.

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
