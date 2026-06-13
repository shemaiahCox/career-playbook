# Project 16 — Cloud deploy + infra automation lab

## Problem

Take [P9](09-go-retrieval-worker-lab.md) (or P4+P5 stack) to **deployable** shape: `docker compose` locally, documented path to **one managed environment** (Fly, Railway, ECS, or similar), secrets outside git, health checks, and managed queue option.

## Career relevance

**Summary:** You close the loop from **works on my machine** to **runs with rollback and secrets**—cloud-shaped ops without a certification detour.

### In depth

Employers hiring for Go/Python/TS backends expect **Docker literacy** and basic deploy hygiene. This lab is prerequisite for [P17](17-k8s-controller-lab.md) (K8s assumes you already ship containers).

## Concept spotlight

**Pillars:** DevOps & Cloud

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **Immutable deploy** | Image or artifact per release; tagged deploy; rollback story | DevOps |
| **Secrets management** | Env from platform secret store; `.env.example` only in git | DevOps, Security |
| **Health checks** | Liveness/readiness endpoints; compose `healthcheck` blocks | DevOps, Full-Stack |

**Interview line:** *“We deploy the worker and API as containers with health checks and secrets in the platform store—rollback is redeploy previous tag.”*

## Code repo

_Document deploy in P9/P4 lab repo or `_TBD` `cloud-deploy-lab` wrapper._

## Stack

- **Docker Compose** — app + Postgres + Redis/NATS
- One cloud target (document choice in README)
- Optional: minimal GitHub Action or deploy script (no full CI curriculum)

## Success criteria

- [ ] `docker compose up` brings full capstone slice locally.
- [ ] One successful deploy to chosen platform documented step-by-step.
- [ ] Secrets never in git; `.env.example` lists keys only.
- [ ] Health URL returns 200; README lists rollback steps.

## Testing approach (lab)

Smoke test script post-deploy: hit health + one API path.

## Exploration scenarios

1. Bad deploy → rollback to previous tag documented.
2. Missing secret → fail fast at startup with clear log.
3. Queue URL switch local → managed documented.

## Stretch

- Terraform/Pulumi stub for queue + DB (single file, not full platform).
- Blue/green or canary note in README (theory OK if not implemented).

## Related

- [P9 Go lab](09-go-retrieval-worker-lab.md)
- [Engineering pillars — DevOps](../docs/paths/engineering-pillars.md#pillar-3--devops--cloud-go--rust)
