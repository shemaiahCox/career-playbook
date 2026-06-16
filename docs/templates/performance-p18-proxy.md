# Performance — Proxy / load balancer (Project 18)

Copy to your lab repo as `docs/portfolio/performance.md` and fill in measured values.

## Context

Edge-layer performance: timeouts, pooling, and graceful shutdown under load.

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

## Interview line

_“Our proxy enforces upstream timeouts and graceful drain on deploy — slow backends don’t wedge the whole edge.”_
