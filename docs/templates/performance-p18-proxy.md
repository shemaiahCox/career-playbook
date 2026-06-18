# Performance — Proxy / load balancer (Project 18)

Copy to your lab repo as `docs/portfolio/performance.md` and fill in measured values.

## Context

This file captures edge-layer performance: timeouts, connection pooling, and graceful shutdown under load.

## Measurements

| Metric | Value | Notes |
|--------|-------|-------|
| p95 via proxy (healthy upstream) | _ms_ | `hey -n 1000 -c 50 http://localhost:PORT/` |
| p95 with one slow upstream | _ms_ | Timeout fires at configured budget |
| Error rate under slow upstream | _%_ | 502/504 vs wedged connections |
| Graceful shutdown drain | _seconds_ | SIGTERM during in-flight load |

## Load test command

```bash
hey -n 1000 -c 50 -m GET http://localhost:8080/health
```

## How to explain this in an interview

The proxy enforces upstream timeouts and graceful drain on deploy — slow backends do not wedge the whole edge.

## How to capture numbers

1. Run `hey` against proxy with two healthy upstreams; record p95 baseline.
2. Configure one upstream with artificial delay; verify 502/504 within timeout budget.
3. Send SIGTERM during load; measure drain time until process exits.
4. Compare putting same logic in nginx vs app proxy in ADR (when to use which).
