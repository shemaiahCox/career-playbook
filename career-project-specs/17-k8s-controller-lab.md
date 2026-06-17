# Project 17 — Kubernetes controller-lite lab (advanced)

## Progress

| | |
|---|---|
| **Step** | 17 of 22 |
| **Previous** | [Project 16 — Cloud deploy + infra automation lab](16-cloud-deploy-lab.md) |
| **Next** | [Project 18 — Proxy / load-balancer lab](18-proxy-load-balancer-lab.md) |

## What you will learn

- Reconcile loop and desired-state apply
- Idempotent cluster operations
- Controller patterns without full operator complexity

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 1. System shape | Desired vs actual state; reconcile loop as system shape |
| 2. Integration & messaging | Idempotent cluster apply; at-least-once reconcile semantics |
| 5. Reliability, security, operations | RBAC failure modes, API unavailable paths |

**Required ADR(s):** tag each ADR with pillar (e.g. controller-lite vs full CRD — **Pillar 1**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

## Before you start

- **Requires:** [Project 16](16-cloud-deploy-lab.md)

## Problem

Build a **minimal Kubernetes controller or operator pattern** in Go: watch a resource (Deployment, ConfigMap, or simple CRD), reconcile desired vs actual state **idempotently**, and log structured reconcile events.

## Career relevance

**Summary:** K8s operators are Go/Rust territory—this lab proves you understand **reconcile loops**, not only `kubectl apply`.

### In depth

**Wave 3 — advanced.** Complete [Project 16](16-cloud-deploy-lab.md) first. Start with **controller-lite** (informers + sync loop) before a full CRD operator if time-boxed.

## Important concepts

### Concept spotlight

| **Reconcile loop** | Observe → diff → act → requeue; no infinite hot loops |
| **Idempotent apply** | Same spec applied twice → stable cluster state |
| **Level-triggered, not edge-only** | Handle missed events; periodic resync |

**Interview line:** *“Our controller reconciles desired replicas idempotently—level-triggered sync, not one-shot edge handlers.”*


**Interview line:** *“Our controller reconciles desired replicas idempotently—level-triggered sync, not one-shot edge handlers.”*

## Code repo

_TBD — e.g. `k8s-controller-lab`._ Suggested folder: [`../career-projects/17-k8s-controller-lab`](../career-projects/17-k8s-controller-lab).

## Stack

- **Go** — `controller-runtime` or client-go informers (document choice)
- **kind** or **minikube** for local cluster
- Deploy target from [Project 16](16-cloud-deploy-lab.md)

## Success criteria

- [ ] Watches at least one resource type; logs reconcile with resource name/namespace.
- [ ] Idempotent: repeated reconcile without drift does not spam side effects.
- [ ] README: architecture diagram + failure modes (RBAC denied, API unavailable).
- [ ] `go test` for pure reconcile logic where possible.

## Bash scripting milestone

Ship `scripts/kubectl-wait-ready.sh` — poll readiness with timeout and clear exit codes for deploy hooks.

## Testing approach (lab)

Envtest or fake client unit tests for reconcile function.

## Exploration scenarios

1. Manual drift in cluster → controller corrects or logs conflict policy.
2. API server unavailable → backoff documented.
3. Duplicate events → stable outcome.

## Stretch

- Full CRD + status subresource.
- Prometheus metrics on reconcile duration/errors.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — informer → reconcile loop → desired vs actual state.
- [ ] **ADR** — controller-lite scope vs full CRD operator.
- [ ] **Performance numbers** — reconcile loop latency or queue depth under drift.
- [ ] **Failure modes** — RBAC denied silent failure; hot loop without backoff; non-idempotent apply.
- [ ] **Observability evidence** — controller log on successful reconcile with resource id.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 17)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 18 — Proxy / load-balancer lab](18-proxy-load-balancer-lab.md)
