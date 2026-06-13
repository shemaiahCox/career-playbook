# Project 12 — Multi-tenant auth + SaaS slice lab

## Problem

Add **authentication** and **tenant isolation** to a small API + SQL schema: users belong to tenants; every read/write scoped by `tenant_id`; JWT or session boundary documented and tested.

## Career relevance

**Summary:** You practice **SaaS-shaped data ownership**—the pattern behind multi-tenant B2B products, not single-user demos.

### In depth

Multi-tenant bugs are **cross-customer data leaks**—career-ending severity. This lab builds on [P2](02-contract-first-api.md) contracts and [P7](07-sql-performance-lab.md) indexing (`tenant_id` in composite indexes). Complements [P8](08-application-security-lab.md) session hygiene.

## Concept spotlight

**Pillars:** Full-Stack Platforms · Security & Systems

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **Tenant isolation** | Every query filters by authenticated tenant; tests prove no cross-tenant read | Full-Stack, Security |
| **Auth boundary** | JWT or session; secure cookies; logout invalidates server state where used | Full-Stack, Security |
| **Idempotent provisioning** | Sign-up or invite webhook uses idempotency key ([P1](01-integration-webhook-receiver.md) pattern) | Full-Stack, AI/Automation |

**Interview line:** *“Tenant id comes from auth context, never from client body—we index and test for cross-tenant leakage.”*

## Code repo

_TBD — extend [P6](06-node-typescript-lab.md) or [P2](02-contract-first-api.md) repo._ Suggested folder: [`../career-projects/12-multi-tenant-auth-lab`](../career-projects/12-multi-tenant-auth-lab).

## Stack

- **TypeScript** (Fastify/Express) or Laravel/FastAPI from P2
- **Postgres** — shared schema, row-level tenant column (RLS optional stretch)
- Migrations checked in

## Success criteria

- [ ] Register/login/logout flows; password hashing (bcrypt/argon2).
- [ ] API routes reject missing/wrong tenant context.
- [ ] Integration test: tenant A token cannot read tenant B row.
- [ ] OpenAPI or README documents auth headers/cookies.

## Testing approach (lab)

Two tenant fixtures; assert isolation on list and detail endpoints.

## Exploration scenarios

1. Forged `tenant_id` in JSON body → ignored or 403.
2. Expired JWT → 401 with stable error shape.
3. Duplicate invite webhook → idempotent tenant membership.

## Stretch

- Postgres RLS policies mirroring app checks.
- Link to [P11](11-llm-web-app-lab.md) for tenant-scoped RAG queries.

## Related

- [P8 Application security](08-application-security-lab.md)
- [P7 SQL performance](07-sql-performance-lab.md)
- [Engineering pillars — Full-Stack](../docs/paths/engineering-pillars.md#pillar-2--full-stack-platforms-ts--gorust)
