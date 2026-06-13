# Ecosystem map: Rust

**Use this:** **Rust** is a **Tier‑2 growth lane**—after you ship [Project 9 Go](../../career-project-specs/09-go-retrieval-worker-lab.md)—for comparing hot-path implementations, edge/IoT-adjacent stretches, and systems literacy. **Go remains the primary throughput lane** on the playbook spine; **Python** owns LLM logic.

**Companion:** [term cards](README.md) · [Project 9 — optional Rust stretch](../../career-project-specs/09-go-retrieval-worker-lab.md#stretch) · [Language fundamentals — Rust](../handbook/language-fundamentals-comparison.md)

**New here?** [Plain language (bottom)](#plain-language-terms-used-on-this-page) · [Stacks glossary](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Ownership** | Each value has one owner; **borrow** (`&T`) for read-only access; **mut borrow** (`&mut T`) exclusive. Compiler enforces at compile time—no GC. |
| **Result / Option** | Errors and absence are explicit: `Result<T, E>`, `Option<T>`—`?` propagates errors like Go’s `if err != nil` chain. |
| **Crates** | `Cargo.toml` + `cargo build` / `cargo test`; crates.io for dependencies (unlike Go stdlib-first probes). |
| **Async** | `async`/`await` + runtimes (**tokio** common)—learn **after** a sync HTTP/worker path unless your lab README commits to async. |
| **HTTP / workers** | **axum**, **actix-web**, **reqwest**/**ureq**—same integration boundaries as Go P9; same idempotency/DLQ semantics. |

---

## When Rust vs Go vs Python in this playbook

| Use Rust | Use Go | Use Python |
|----------|--------|------------|
| Optional **reimplementation** of P9 gateway/worker (compare ADR) | **Primary** queue workers, retrieval gateway on spine | LLM, evals, orchestration |
| Edge/IoT **stretch** reading (MQTT, embedded) after spine green | Day-to-day throughput practice first | Rapid eval iteration |
| Systems literacy for roles listing Rust | Smaller team ops surface, fast compile cycles | Rich ML ecosystem |

**Order:** Ship P9 in **Go** first. Rust sandbox ([rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/README.md)) for syntax anytime **before or after** P9—but **do not** run Go + Rust reimplementation as parallel spines.

---

## What to practice here vs defer

| Rust is used for (in scope) | Practice in | Defer (not playbook spine) |
|-----------------------------|-------------|----------------------------|
| HTTP/CLI probe, ownership + `Result` | [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/README.md) | Greenfield Rust API replacing P2/P6 |
| P9 gateway or worker **reimplementation** | [P21](../../career-project-specs/21-rust-hot-path-lab.md) | Second concurrent worker engine while P9 Go unfinished |
| IoT / edge ingest (optional) | Future stretch note + side project in [PROGRESS.md](../../PROGRESS.md) | Full embedded/robotics curriculum |
| WASM / CLI tools | Side demos tied to one load-bearing property | Blockchain, game engines |

**Easy follow path:** [Learning journey — Rust Tier‑2](../paths/learning-journey.md#rust-tier-2-after-p9-go) · [Go map](go.md) (primary throughput lane).

---

## Footguns

- **Fighting the borrow checker** in large AI-generated dumps—start small; one binary, one crate.
- **Unbounded `tokio::spawn`** — same as unbounded goroutines; use semaphores/worker pools.
- **`.unwrap()` in workers** — panics poison async tasks; propagate `Result` and map to DLQ/retry policy.
- **Duplicate logic** — Rust reimplementation must share **same HTTP/queue contract** as Go P9, not a divergent API.

---

## Read next (handbook)

- [Concurrency basics](../handbook/software-engineering.md#concurrency-basics)
- [Integration: sync, async, messaging](../handbook/software-engineering.md#integration-sync-async-and-messaging)
- [Language fundamentals comparison — Rust](../handbook/language-fundamentals-comparison.md)

**Sandbox:** [rust-cli-http-probe](../../exploration-projects/rust-cli-http-probe/README.md)

---

## Plain language: terms used on this page

| Term | Means |
|------|--------|
| **Ownership** | Rust tracks who may read/write memory; prevents use-after-free and data races at compile time. |
| **Borrow** | Temporary access to data without taking ownership (`&foo`). |
| **Crate** | Rust package (library or binary) built by Cargo. |
| **Tier‑2 growth lane** | Practice **after** the Go spine milestone—not in parallel with it as a second active lab. |
