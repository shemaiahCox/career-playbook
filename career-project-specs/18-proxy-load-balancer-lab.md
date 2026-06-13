# Project 18 — Proxy / load-balancer lab (advanced)

## Problem

Implement a **small reverse proxy or load balancer** in Go (Rust stretch): forward HTTP to upstream pool, enforce timeouts, connection limits, graceful shutdown, and structured access logs.

## Career relevance

**Summary:** Proxies teach **network-level reliability**—timeouts, pooling, and backpressure—that application code alone cannot fix.

### In depth

**Wave 3 — advanced.** Complements [P9](09-go-retrieval-worker-lab.md) gateway work and [P21](21-rust-hot-path-lab.md) performance comparisons.

## Concept spotlight

**Pillars:** DevOps & Cloud · Security & Systems

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **Timeout budgets** | Client, upstream, and idle timeouts configured and tested | DevOps |
| **Graceful shutdown** | Drain connections on SIGTERM before exit | DevOps |
| **Connection pooling** | Reuse upstream connections; cap max concurrent | DevOps, Security |

**Interview line:** *“Our proxy enforces upstream timeouts and graceful drain on deploy so slow backends don’t wedge the whole edge.”*

## Code repo

_TBD — e.g. `proxy-lab`._ Suggested folder: [`../career-projects/18-proxy-load-balancer-lab`](../career-projects/18-proxy-load-balancer-lab).

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

## Stretch

- TLS termination stub (local certs).
- Rust reimplementation benchmark vs Go ([P21](21-rust-hot-path-lab.md)).

## Related

- [Servers and networking handbook](../docs/handbook/servers-and-networking.md)
- [P9 Go lab](09-go-retrieval-worker-lab.md)

**Wave:** 3 (advanced)
