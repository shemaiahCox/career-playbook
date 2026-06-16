# Project 12 — Multi-tenant auth + SaaS slice lab

## Progress

| | |
|---|---|
| **Step** | 12 of 22 |
| **Previous** | [Project 11 — LLM-integrated web app lab](11-llm-web-app-lab.md) |
| **Next** | [Project 13 — Real-time dashboard lab](13-realtime-dashboard-lab.md) |

## What you will learn

- Row-level tenant isolation
- JWT/session patterns with scoped queries
- AuthZ on every data path

## Before you start

- **Requires:** [Project 5](05-contract-first-api.md) and [Project 4](04-sql-performance-lab.md)

## Problem

Add **authentication** and **tenant isolation** to a small API + SQL schema: users belong to tenants; every read/write scoped by `tenant_id`; JWT or session boundary documented and tested.

## Career relevance

**Summary:** You practice **SaaS-shaped data ownership**—the pattern behind multi-tenant B2B products, not single-user demos.

### In depth

Multi-tenant bugs are **cross-customer data leaks**—career-ending severity. This lab builds on [Project 5](05-contract-first-api.md) contracts and [Project 4](04-sql-performance-lab.md) indexing (`tenant_id` in composite indexes). Complements [Project 9](09-application-security-lab.md) session hygiene.

## Important concepts

### Concept spotlight

| **Tenant isolation** | Every query filters by authenticated tenant; tests prove no cross-tenant read |
| **Auth boundary** | JWT or session; secure cookies; logout invalidates server state where used |
| **Idempotent provisioning** | Sign-up or invite webhook uses idempotency key ([Project 1](01-integration-webhook-receiver.md) pattern) |

**Interview line:** *“Tenant id comes from auth context, never from client body—we index and test for cross-tenant leakage.”*


**Interview line:** *“Tenant id comes from auth context, never from client body—we index and test for cross-tenant leakage.”*

## Code repo

_TBD — extend [Project 7](07-node-typescript-lab.md) or [Project 5](05-contract-first-api.md) repo._ Suggested folder: [`../career-projects/12-multi-tenant-auth-lab`](../career-projects/12-multi-tenant-auth-lab).

## Stack

- **TypeScript** (Fastify/Express) or Laravel/FastAPI from Project 5
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
- Link to [Project 11](11-llm-web-app-lab.md) for tenant-scoped RAG queries.
- **OAuth/OIDC** — "Sign in with Google" (or similar) → issue your existing JWT/session; document token exchange and tenant mapping on first login.

## Big Tech benchmark tier

Optional ceiling — see [big-tech-benchmark.md](../docs/career/big-tech-benchmark.md). Complete after UK £80k success criteria are green.

- [ ] **OAuth/OIDC required** — Google (or similar) sign-in issues your JWT/session; not optional stretch.
- [ ] Document authorization code flow, token refresh, and tenant mapping on first login.
- [ ] Integration test: OAuth callback → session → tenant-scoped API access.
- [ ] Threat notes: CSRF on OAuth state param; redirect URI allowlist ([Project 9](09-application-security-lab.md)).

## Bash scripting milestone

Ship `scripts/smoke.sh` — authenticated or public health path; exit 0/1 for CI.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — auth gate → tenant context → scoped queries on every path.
- [ ] **ADR** — row-level `tenant_id` vs RLS; JWT vs session for this lab.
- [ ] **Performance numbers** — composite index impact on tenant-scoped list query (optional).
- [ ] **Failure modes** — cross-tenant read/write; missing tenant on insert; session fixation.
- [ ] **Observability evidence** — log showing tenant id on authenticated request (redacted).
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 12)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 13 — Real-time dashboard lab](13-realtime-dashboard-lab.md)
