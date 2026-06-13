# Project 15 — Cloud deploy + infra automation lab

## Progress

| | |
|---|---|
| **Step** | 15 of 20 |
| **Previous** | [Project 14 — DevOps CLI / ops tool lab](14-devops-cli-lab.md) |
| **Next** | [Project 16 — Kubernetes controller-lite lab](16-k8s-controller-lab.md) |

## What you will learn

- Compose-based deploy with secrets and health checks
- Managed queue or cloud-shaped ops
- Rollback and env parity habits

## Before you start

- **Requires:** [Project 8](08-go-retrieval-worker-lab.md) or [Project 6](06-async-worker-stretch.md) runnable stack

## Problem

Take [Project 8](08-go-retrieval-worker-lab.md) (or Project 6+Project 4 stack) to **deployable** shape: `docker compose` locally, documented path to **one managed environment** (Fly, Railway, ECS, or similar), secrets outside git, health checks, and managed queue option.

## Career relevance

**Summary:** You close the loop from **works on my machine** to **runs with rollback and secrets**—cloud-shaped ops without a certification detour.

### In depth

Employers hiring for Go/Python/TS backends expect **Docker literacy** and basic deploy hygiene. This lab is prerequisite for [Project 16](16-k8s-controller-lab.md) (K8s assumes you already ship containers).

## Important concepts

### Concept spotlight

| **Immutable deploy** | Image or artifact per release; tagged deploy; rollback story |
| **Secrets management** | Env from platform secret store; `.env.example` only in git |
| **Health checks** | Liveness/readiness endpoints; compose `healthcheck` blocks |

**Interview line:** *“We deploy the worker and API as containers with health checks and secrets in the platform store—rollback is redeploy previous tag.”*


**Interview line:** *“We deploy the worker and API as containers with health checks and secrets in the platform store—rollback is redeploy previous tag.”*

## Code repo

_Document deploy in Project 8/Project 6 lab repo or `_TBD` `cloud-deploy-lab` wrapper._

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

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 16 — Kubernetes controller-lite lab](16-k8s-controller-lab.md)
