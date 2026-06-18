# Project 23 — Distributed rate limiter + API gateway slice (optional)

## Progress

| | |
|---|---|
| **Step** | Optional — after [Project 8](08-go-retrieval-worker-lab.md) |
| **Previous** | [Project 8 — Go retrieval gateway and worker](08-go-retrieval-worker-lab.md) |
| **Next** | [Project 24 — Notification fan-out](24-notification-fanout-lab.md) (optional) |

**Not in the linear spine.** One active project rule still applies.

## What you will learn

- Token bucket and sliding window rate limiting
- Distributed counters with Redis (or in-memory for local demo)
- Gateway middleware: `429`, `Retry-After`, per-API-key limits

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 2. Integration & messaging | Gateway middleware, 429/Retry-After, per-client limits (secondary) |
| 4. Performance & language boundaries | Token bucket vs sliding window; Redis atomic counters |
| 5. Reliability, security, operations | Hot-key sharding, edge failure modes |

**Required ADR(s):** tag each ADR with pillar (e.g. token bucket vs sliding window — **Pillar 4**; Redis vs in-memory — **Pillar 2**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

## Before you start

- **Requires:** [Project 8](08-go-retrieval-worker-lab.md) HTTP gateway patterns; Redis familiarity from [Project 6](06-async-worker-stretch.md)
- **Go-first track:** Optional performance depth after P8 — pick **this** or [Project 25](25-search-autocomplete-lab.md), not both required. Replaces Rust P19 gateway benchmark angle.
- **Career context:** [System design interview map](../docs/career/system-design-interview-map.md#rate-limiter) · [Big Tech benchmark](../docs/career/big-tech-benchmark.md)
- **Related:** [Project 18](18-proxy-load-balancer-lab.md) proxy timeouts and graceful shutdown

## Problem

Add a **rate limiting gateway** in front of an existing API (your Project 8 `/retrieve` or a minimal mock upstream): enforce **per-client limits** (API key or IP), return **`429 Too Many Requests`** with **`Retry-After`**, and document **token bucket vs sliding window** in an architecture decision record (ADR).

## Career relevance

**Summary:** Rate limiting is a **top-five system design question** at Google/Meta. This lab turns vocabulary into working middleware with measurable behavior.

### In depth

Gateway middleware sits at the edge before expensive upstream work—same backpressure thinking as bounded goroutines in [Project 8](08-go-retrieval-worker-lab.md). Optional performance depth on the Go-first track; pick this **or** [Project 25](25-search-autocomplete-lab.md), not both required.

**Why learning this moves the needle**

- **System design interviews:** Token bucket vs sliding window is nearly always on the menu; working code beats whiteboard-only answers.
- **Distributed correctness:** Redis atomic counters and race awareness separate toy limiters from production-shaped ones.
- **Operator UX:** `429 Too Many Requests` with `Retry-After` gives clients a backoff signal—not ambiguous 500s.

**Real-world situations this project mirrors**

- **API key abuse:** per-client limits on `/retrieve` or similar hot paths.
- **Redis outage:** fail open vs fail closed policy documented and tested.
- **Hot keys:** shard by hashing API key prefix when one tenant dominates traffic.

### How to talk about this

You use a sliding window in Redis with Lua for atomic increment; hot keys shard by prefixing API key hash—same backpressure thinking as bounded goroutines in Project 8. When interviewers compare algorithms, explain token bucket burst tolerance vs sliding window smoothness. When interviewers ask about placement, describe limiting at the gateway before upstream retrieval or LLM work runs.

## Important concepts

### Token bucket

Steady refill rate allows short bursts up to bucket capacity. Good when occasional spikes are acceptable but sustained overage must be rejected.

### Sliding window

Count requests in a rolling time window; smoother than fixed windows that reset abruptly at interval boundaries. Often implemented with Redis sorted sets or Lua scripts for atomicity.

### Distributed limiter

Use Redis `INCR` with TTL or a dedicated limiter service; be explicit about races under parallel clients. Document single-node vs cluster capacity for benchmark tier.

### Gateway placement

Enforce limits at the edge before expensive upstream work—retrieval, LLM calls, or database fan-out. Timeouts remain independent of rate limits ([Project 18](18-proxy-load-balancer-lab.md)).

## Code repo

_TBD — create sibling repo (e.g. `rate-limiter-gateway-lab`) or extend Project 8 repo._

Suggested local folder: [`../career-projects/23-rate-limiter-gateway-lab`](../career-projects/23-rate-limiter-gateway-lab).

## Stack

- **Go 1.22+** — default on Go-first track (chi or echo middleware chain)
- **Redis** — distributed counter store
- Upstream: [Project 8](08-go-retrieval-worker-lab.md) retrieval or static mock handler

**Go-first track:** This lab is optional performance depth after P8 — replaces Rust hot-path evidence with measurable gateway middleware behavior. Rust is not required.

## Success criteria

- [ ] Middleware enforces configurable limit (e.g. 100 req/min per API key).
- [ ] Under limit → request proxied to upstream; over limit → **429** + **Retry-After** header.
- [ ] **Two algorithms implemented or documented:** token bucket AND sliding window (one in code, one in ADR comparison).
- [ ] Integration test proves 101st request in window returns 429.
- [ ] README includes capacity note: single Redis node vs cluster for benchmark tier.
- [ ] Structured logs: `api_key_hash`, `remaining`, `limit_exceeded` events.

## Testing approach (lab)

**Primary:** Integration — burst N+1 requests; assert 429 on last.

**Secondary:** Unit tests for bucket refill math and window boundary edge cases.

**Exploration scenarios**

1. Burst at bucket capacity → allowed; sustained over refill → 429.
2. Clock skew simulation — document window boundary behavior.
3. Missing API key → 401 or global IP limit (document policy).
4. Upstream slow — gateway timeout independent of rate limit ([Project 18](18-proxy-load-balancer-lab.md) tie-in).

## Stretch

- **Sharding** hot keys — hash API key to Redis slot prefix.
- **Global vs per-endpoint** limits — stricter on `POST` than `GET`.
- Compose stack: gateway + Redis + Project 8 upstream.
- **Big Tech benchmark:** rate limit decision in <1ms p99; document Redis RTT budget.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md).

- [ ] **Architecture diagram** — client → gateway → Redis → upstream.
- [ ] **ADR** — token bucket vs sliding window; Redis vs in-memory.
- [ ] **Performance numbers** — commit `docs/portfolio/performance.md`: middleware overhead p95; 429 accuracy under parallel clients.
- [ ] **Failure modes** — Redis down (fail open vs closed); clock skew; hot key.
- [ ] **Observability evidence** — log or metric for limit exceeded rate.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [per-project testing guide](../docs/concepts/per-project-testing.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **See also:** [System design interview map — rate limiter](../docs/career/system-design-interview-map.md#rate-limiter)
