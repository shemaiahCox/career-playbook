# Project 18 — Rust hot-path reimplementation lab (advanced)

## Progress

| | |
|---|---|
| **Step** | 18 of 21 |
| **Previous** | [Project 17 — Proxy / load-balancer lab](17-proxy-load-balancer-lab.md) |
| **Next** | [Project 19 — WASM / secure network component lab](19-wasm-secure-component-lab.md) |

## What you will learn

- Reimplement Project 8 contract in Rust
- Write a Go vs Rust ADR with tradeoffs
- Compare ownership, errors, and latency

## Before you start

- **Requires:** [Project 8](08-go-retrieval-worker-lab.md) green first
- **New to Rust?** → [Rust map](../docs/languages/rust.md)
- **Cross-stack depth:** [Ownership and iterators](../docs/languages/language-fundamentals-comparison.md#ownership-borrowing-and-memory-models) · [Error philosophy](../docs/languages/language-fundamentals-comparison.md#error-philosophy-and-control-flow) · [Lazy evaluation](../docs/languages/language-fundamentals-comparison.md#lazy-evaluation-generators-and-iterators)
- **Handbook:** [Memory and performance](../docs/concepts/memory-and-performance.md)

## Problem

After [Project 8](08-go-retrieval-worker-lab.md) Go core is green, **reimplement** the retrieval gateway or worker in **Rust** with the **same HTTP/queue contract**—then write a **Go vs Rust ADR** (latency, ops, safety, hiring, team fit).

## Career relevance

**Summary:** Formalizes **Tier‑2 Rust**—comparison with evidence, not “I rewrote it because Rust is cool.”

### In depth

**Advanced tier.** Mandatory prerequisite: Project 8 success criteria complete in Go.

## Important concepts

### Concept spotlight

| **Contract stability** | OpenAPI/JSON unchanged from Go Project 8; Python Project 2 needs no changes |
| **Ownership + errors** | `Result` propagation; no `unwrap` in worker hot path |
| **Performance ADR** | Benchmark p95 **and** peak RSS (or alloc/op); document when Rust wins vs Go ops cost |
| **Clone vs borrow** | Avoid unnecessary `.clone()` in fan-out hot path; justify copies in ADR |

**Interview line:** *“We reimplemented the retrieval gateway in Rust behind the same contract—ADR covers p95 gain vs build complexity and on-call familiarity.”*


**Interview line:** *“We reimplemented the retrieval gateway in Rust behind the same contract—ADR covers p95 gain vs build complexity and on-call familiarity.”*

## Code repo

_TBD — e.g. `rust-retrieval-lab` or sibling crate in Project 8 repo._

## Stack

- **Rust** — axum/actix or ureq/hyper (document choice)
- Same Postgres/Redis as Project 8
- [Rust ecosystem map](../docs/languages/rust.md)

## Success criteria

- [ ] Passes same exploration scenarios as Project 8 (duplicate job, timeout, gateway SLA).
- [ ] Contract doc unchanged or versioned with no breaking change.
- [ ] ADR in [PROGRESS.md](../PROGRESS.md): Go vs Rust decision **including p95 and peak RSS** (or alloc/op) for the same benchmark.
- [ ] `cargo test` for idempotency helper + one integration path.
- [ ] **Tokio** (or documented sync-first path) for async HTTP/worker—name runtime choice in README.

## Testing approach (lab)

Port Project 8 table-driven cases; docker-compose integration optional.

## Exploration scenarios

1. Duplicate `job_id` → single side effect (match Go).
2. Context cancel → worker behavior matches documented Go policy.
3. Benchmark 1k chunk fan-out — note in ADR (optional).

## Stretch

- Share queue with Go producer during migration window.
- [Project 19](19-wasm-secure-component-lab.md) extract hot filter to WASM.
- **`proptest`** on idempotency helper — property: duplicate `job_id` never double-applies side effect.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — same contract as Project 8 Go; Rust service in parallel or swap.
- [ ] **ADR** — **required:** Go vs Rust with p95 **and** peak RSS (or alloc/op) on same benchmark.
- [ ] **Performance numbers** — benchmark table in ADR (before Go / after Rust on same workload).
- [ ] **Failure modes** — ops complexity of dual stack; `.clone()` hot path without measurement.
- [ ] **Observability evidence** — Rust service log matching Project 8 request/job correlation.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 18)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 19 — WASM / secure network component lab](19-wasm-secure-component-lab.md)
