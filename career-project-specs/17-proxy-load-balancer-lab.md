# Project 17 — Proxy / load-balancer lab (advanced)

## Progress

| | |
|---|---|
| **Step** | 17 of 21 |
| **Previous** | [Project 16 — Kubernetes controller-lite lab](16-k8s-controller-lab.md) |
| **Next** | [Project 18 — Rust hot-path reimplementation lab](18-rust-hot-path-lab.md) |

## What you will learn

- Connection pooling, timeouts, graceful shutdown
- Reverse-proxy behavior under load
- Network-layer failure modes

## Before you start

- **Handbook:** [Servers and networking](../docs/concepts/servers-and-networking.md) · [Memory and performance — timeouts and load testing](../docs/concepts/memory-and-performance.md)

## Problem

Implement a **small reverse proxy or load balancer** in Go (Rust stretch): forward HTTP to upstream pool, enforce timeouts, connection limits, graceful shutdown, and structured access logs.

## Career relevance

**Summary:** Proxies teach **network-level reliability**—timeouts, pooling, and backpressure—that application code alone cannot fix.

### In depth

**Advanced.** Complements [Project 8](08-go-retrieval-worker-lab.md) gateway work and [Project 18](18-rust-hot-path-lab.md) performance comparisons.

## Important concepts

### Concept spotlight

| **Timeout budgets** | Client, upstream, and idle timeouts configured and tested |
| **Graceful shutdown** | Drain connections on SIGTERM before exit |
| **Connection pooling** | Reuse upstream connections; cap max concurrent |

**Interview line:** *“Our proxy enforces upstream timeouts and graceful drain on deploy so slow backends don’t wedge the whole edge.”*


**Interview line:** *“Our proxy enforces upstream timeouts and graceful drain on deploy so slow backends don’t wedge the whole edge.”*

## Code repo

_TBD — e.g. `proxy-lab`._ Suggested folder: [`../career-projects/17-proxy-load-balancer-lab`](../career-projects/17-proxy-load-balancer-lab).

## Stack

- **Go** — `net/http` ReverseProxy or **Rust** hyper (stretch)
- Two upstream mock servers in docker-compose
- Access logs with request_id

## Success criteria

- [ ] Round-robin or least-conn to ≥2 upstreams.
- [ ] Upstream timeout returns 502/504 with log line.
- [ ] Graceful shutdown test documented (in-flight completes or times out).
- [ ] README compares to putting proxy in nginx/cloud LB (when to use which).

## Testing approach (lab)

Integration: kill upstream; assert failover or error behavior.

## Exploration scenarios

1. One upstream slow → timeout fires; other upstream healthy.
2. SIGTERM during load → drain behavior observed.
3. Malformed client request → 400 without upstream call.
4. *(Optional)* `hey` or `k6` smoke load—record p95 and error rate under slow upstream ([Memory and performance](../docs/concepts/memory-and-performance.md#light-load-testing)).

## Stretch

- TLS termination stub (local certs).
- Rust reimplementation benchmark vs Go ([Project 18](18-rust-hot-path-lab.md)).

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — client → proxy → upstream pool with timeout budgets.
- [ ] **ADR** — connection pool sizing and graceful shutdown approach.
- [ ] **Performance numbers** — p95 with vs without proxy; upstream timeout behavior.
- [ ] **Failure modes** — retry storm; pool exhaustion; slow upstream blocking all clients.
- [ ] **Observability evidence** — access log with status, duration, upstream timing.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 17)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 18 — Rust hot-path reimplementation lab](18-rust-hot-path-lab.md)
