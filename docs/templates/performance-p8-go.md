# Performance — Go retrieval + worker (Project 8)

Copy to your lab repo as `docs/portfolio/performance.md` and fill in measured values.

**Go-first track:** This artifact replaces [Project 19](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) Rust comparison — Python↔Go architecture decision record (ADR) + pprof evidence is enough.

## Context

This file captures application-layer performance: retrieval fan-out and optional worker throughput.

## Measurements

| Metric | Before (Python baseline) | After (Go gateway) | How measured |
|--------|--------------------------|--------------------|--------------|
| `/retrieve` p95 | _ms_ | _ms_ | `hey -n 1000 -c 50` or scripted curl loop |
| Peak RSS / heap | _MB_ | _MB_ | `go tool pprof` heap profile or `docker stats` |
| Goroutine count under load | _unbounded vs pool_ | _with worker pool_ | `pprof` goroutine profile or runtime metric |
| Worker jobs/sec (optional) | — | _jobs/sec_ | Enqueue N jobs; measure drain time |

## Profiling evidence

- CPU profile command: `go tool pprof -http=:8081 http://localhost:6060/debug/pprof/profile?seconds=30`
- Heap profile command: `go tool pprof http://localhost:6060/debug/pprof/heap`
- One sentence: dominant hotspot before fix → change applied → verified in after column

## ADR pointer

Link to `docs/portfolio/adr-001-python-go-boundary.md` (or equivalent) — decision based on **profile**, not language hype.

## How to explain this in an interview

You profiled Python retrieval, moved fan-out to Go with bounded concurrency, and validated p95 latency and RSS (Resident Set Size) with pprof.

## How to capture numbers

1. Baseline Python `/retrieve` (or equivalent) with `hey -n 1000 -c 50`; record p95 and error rate.
2. Enable `net/http/pprof`; capture CPU + heap during same load test.
3. Add bounded worker pool + `context` timeouts; re-run identical load.
4. Fill **Before/After** table; link ADR explaining profile evidence—not “Go is faster.”
