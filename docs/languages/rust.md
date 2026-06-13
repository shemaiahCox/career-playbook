# Ecosystem map: Rust

**Use this:** **Rust** is a **Tier‑2 growth lane**—after you ship [Project 9 Go](../../career-project-specs/08-go-retrieval-worker-lab.md)—for comparing hot-path implementations, edge/IoT-adjacent stretches, and systems literacy. **Go remains the primary throughput lane** on the playbook spine; **Python** owns LLM logic.

**Companion:** [docs README](../README.md) · [Project 8 — optional Rust stretch](../../career-project-specs/08-go-retrieval-worker-lab.md#stretch) · [Language fundamentals — Rust](language-fundamentals-comparison.md)

**New here?** [Plain language (bottom)](#plain-language-terms-used-on-this-page) · [Stacks glossary](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Ownership** | Each value has one owner; **borrow** (`&T`) for read-only access; **mut borrow** (`&mut T`) exclusive. Compiler enforces at compile time—no GC. |
| **Result / Option** | Errors and absence are explicit: `Result<T, E>`, `Option<T>`—`?` propagates errors like Go’s `if err != nil` chain. |
| **Crates** | `Cargo.toml` + `cargo build` / `cargo test`; crates.io for dependencies (unlike Go stdlib-first probes). |
| **Async** | `async`/`await` + runtimes (**tokio** common)—learn **after** a sync HTTP/worker path unless your lab README commits to async. |
| **HTTP / workers** | **axum**, **actix-web**, **reqwest**/**ureq**—same integration boundaries as Go Project 8; same idempotency/DLQ semantics. |

---

## When Rust vs Go vs Python in this playbook

| Use Rust | Use Go | Use Python |
|----------|--------|------------|
| Optional **reimplementation** of Project 8 gateway/worker (compare ADR) | **Primary** queue workers, retrieval gateway on spine | LLM, evals, orchestration |
| Edge/IoT **stretch** reading (MQTT, embedded) after spine green | Day-to-day throughput practice first | Rapid eval iteration |
| Systems literacy for roles listing Rust | Smaller team ops surface, fast compile cycles | Rich ML ecosystem |

**Order:** Ship Project 8 in **Go** first. Use [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) for Rust syntax and hot-path ADR **after** Project 8 Go is green—**do not** run Go + Rust reimplementation as parallel spines.

---

## What to practice here vs defer

| Rust is used for (in scope) | Practice in | Defer (not playbook spine) |
|-----------------------------|-------------|----------------------------|
| HTTP/CLI probe, ownership + `Result` | [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) | Greenfield Rust API replacing Project 5/Project 7 |
| Project 8 gateway or worker **reimplementation** | [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) | Second concurrent worker engine while Project 8 Go unfinished |
| IoT / edge ingest (optional) | Future stretch note + side project in [PROGRESS.md](../../PROGRESS.md) | Full embedded/robotics curriculum |
| WASM / CLI tools | Side demos tied to one load-bearing property | Blockchain, game engines |

**Easy follow path:** [Project 18 — Rust hot-path](../../career-project-specs/18-rust-hot-path-lab.md) (after Project 8) · [Go map](go.md) (primary throughput lane).

---

## Footguns

- **Fighting the borrow checker** in large AI-generated dumps—start small; one binary, one crate.
- **Unbounded `tokio::spawn`** — same as unbounded goroutines; use semaphores/worker pools.
- **`.unwrap()` in workers** — panics poison async tasks; propagate `Result` and map to DLQ/retry policy.
- **Duplicate logic** — Rust reimplementation must share **same HTTP/queue contract** as Go Project 8, not a divergent API.
- **Unnecessary `.clone()` in hot paths** — measure peak RSS and alloc/op in [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) ADR vs Go baseline.

---

## Read next (handbook)

- [Concurrency basics](../concepts/software-engineering.md#concurrency-basics)
- [Memory and performance](../concepts/memory-and-performance.md)
- [Integration: sync, async, messaging](../concepts/software-engineering.md#integration-sync-async-and-messaging)
- [Language fundamentals comparison — Rust](language-fundamentals-comparison.md)

---

## Plain language: terms used on this page

| Term | Means |
|------|--------|
| **Ownership** | Rust tracks who may read/write memory; prevents use-after-free and data races at compile time. |
| **Borrow** | Temporary access to data without taking ownership (`&foo`). |
| **Crate** | Rust package (library or binary) built by Cargo. |
| **Tier‑2 growth lane** | Practice **after** the Go spine milestone—not in parallel with it as a second active lab. |
