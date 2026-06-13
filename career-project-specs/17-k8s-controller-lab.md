# Project 17 — Kubernetes controller-lite lab (advanced)

## Problem

Build a **minimal Kubernetes controller or operator pattern** in Go: watch a resource (Deployment, ConfigMap, or simple CRD), reconcile desired vs actual state **idempotently**, and log structured reconcile events.

## Career relevance

**Summary:** K8s operators are Go/Rust territory—this lab proves you understand **reconcile loops**, not only `kubectl apply`.

### In depth

**Wave 3 — advanced.** Complete [P16](16-cloud-deploy-lab.md) first. Start with **controller-lite** (informers + sync loop) before a full CRD operator if time-boxed.

## Concept spotlight

**Pillars:** DevOps & Cloud

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **Reconcile loop** | Observe → diff → act → requeue; no infinite hot loops | DevOps |
| **Idempotent apply** | Same spec applied twice → stable cluster state | DevOps, AI/Automation |
| **Level-triggered, not edge-only** | Handle missed events; periodic resync | DevOps |

**Interview line:** *“Our controller reconciles desired replicas idempotently—level-triggered sync, not one-shot edge handlers.”*

## Code repo

_TBD — e.g. `k8s-controller-lab`._ Suggested folder: [`../career-projects/17-k8s-controller-lab`](../career-projects/17-k8s-controller-lab).

## Stack

- **Go** — `controller-runtime` or client-go informers (document choice)
- **kind** or **minikube** for local cluster
- Deploy target from [P16](16-cloud-deploy-lab.md)

## Success criteria

- [ ] Watches at least one resource type; logs reconcile with resource name/namespace.
- [ ] Idempotent: repeated reconcile without drift does not spam side effects.
- [ ] README: architecture diagram + failure modes (RBAC denied, API unavailable).
- [ ] `go test` for pure reconcile logic where possible.

## Testing approach (lab)

Envtest or fake client unit tests for reconcile function.

## Exploration scenarios

1. Manual drift in cluster → controller corrects or logs conflict policy.
2. API server unavailable → backoff documented.
3. Duplicate events → stable outcome.

## Stretch

- Full CRD + status subresource.
- Prometheus metrics on reconcile duration/errors.

## Related

- [P16 Cloud deploy](16-cloud-deploy-lab.md)
- [Go ecosystem map](../docs/stacks/go.md)

**Wave:** 3 (advanced)
