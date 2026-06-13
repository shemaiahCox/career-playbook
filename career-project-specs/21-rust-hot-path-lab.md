# Project 21 — Rust hot-path reimplementation lab (advanced)

## Problem

After [P9](09-go-retrieval-worker-lab.md) Go core is green, **reimplement** the retrieval gateway or worker in **Rust** with the **same HTTP/queue contract**—then write a **Go vs Rust ADR** (latency, ops, safety, hiring, team fit).

## Career relevance

**Summary:** Formalizes **Tier‑2 Rust**—comparison with evidence, not “I rewrote it because Rust is cool.”

### In depth

**Wave 3.** Mandatory prerequisite: P9 success criteria complete in Go. Same idempotency and DLQ semantics—only the implementation language changes.

## Concept spotlight

**Pillars:** Security & Systems · DevOps & Cloud

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **Contract stability** | OpenAPI/JSON unchanged from Go P9; Python P4 needs no changes | AI/Automation, Full-Stack |
| **Ownership + errors** | `Result` propagation; no `unwrap` in worker hot path | Security/Systems |
| **Performance ADR** | Benchmark or p95 note; document when Rust wins vs Go ops cost | DevOps, Security |

**Interview line:** *“We reimplemented the retrieval gateway in Rust behind the same contract—ADR covers p95 gain vs build complexity and on-call familiarity.”*

## Code repo

_TBD — e.g. `rust-retrieval-lab` or sibling crate in P9 repo._ See [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/).

## Stack

- **Rust** — axum/actix or ureq/hyper (document choice)
- Same Postgres/Redis as P9
- [Rust ecosystem map](../docs/stacks/rust.md)

## Success criteria

- [ ] Passes same exploration scenarios as P9 (duplicate job, timeout, gateway SLA).
- [ ] Contract doc unchanged or versioned with no breaking change.
- [ ] ADR in [PROGRESS.md](../PROGRESS.md): Go vs Rust decision.
- [ ] `cargo test` for idempotency helper + one integration path.

## Testing approach (lab)

Port P9 table-driven cases; docker-compose integration optional.

## Exploration scenarios

1. Duplicate `job_id` → single side effect (match Go).
2. Context cancel → worker behavior matches documented Go policy.
3. Benchmark 1k chunk fan-out — note in ADR (optional).

## Stretch

- Share queue with Go producer during migration window.
- [P22](22-wasm-secure-component-lab.md) extract hot filter to WASM.

## Related

- [P9 Go lab](09-go-retrieval-worker-lab.md)
- [Learning journey — Rust Tier‑2](../docs/paths/learning-journey.md#rust-tier-2-after-p9-go)

**Wave:** 3 (advanced)
