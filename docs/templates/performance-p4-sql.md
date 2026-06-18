# Performance — SQL lab (Project 4)

Copy to your lab repo as `docs/portfolio/performance.md` and fill in measured values.

## Context

This file captures data-layer performance evidence for Go-first backend/systems positioning (replaces Rust hot-path SQL angle).

## Measurements

| Metric | Before | After | How measured |
|--------|--------|-------|--------------|
| Hot list query execution time | _e.g. 820ms_ | _e.g. 14ms_ | `EXPLAIN (ANALYZE, BUFFERS)` on exercise 2 or 5 |
| Plan shape | _seq scan_ | _index scan_ | Paste one-line plan excerpt below |
| Index write cost (optional) | _insert p95_ | _insert p95 with new index_ | Note tradeoff in ADR |

## Plan excerpt (before)

```text
(paste EXPLAIN ANALYZE excerpt)
```

## Plan excerpt (after)

```text
(paste EXPLAIN ANALYZE excerpt)
```

## How to explain this in an interview

Describe the index change in plain terms: you added a composite index aligned to `tenant_id` and `created_at`, the plan moved from sequential scan to index scan, and p95 latency dropped from X to Y — with write amplification noted in the ADR (Architecture Decision Record).
