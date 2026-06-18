# Ecosystem map: Rust

**Use this:** **Rust** is a **second growth lane**—after you ship [Project 8 Go](../../career-project-specs/08-go-retrieval-worker-lab.md)—for comparing hot-path implementations, edge/IoT-adjacent stretches, and systems literacy. **Go remains the primary throughput lane** on the playbook spine; **Python** owns LLM logic.

**Companion:** [docs README](../README.md) · [Project 8 — optional Rust stretch](../../career-project-specs/08-go-retrieval-worker-lab.md#stretch) · [Language fundamentals — Rust](language-fundamentals-comparison.md)

**New here?** [Plain language (bottom)](#plain-language-terms-used-on-this-page) · [Stacks glossary](glossary.md)

---

## Best for, alternatives, and playbook fit

| Best for | Use instead when | Primary projects |
|----------|------------------|------------------|
| Hot-path ADR reimplementation after Go baseline; WASM/edge stretch reading | Go for day-to-day queue workers and retrieval gateway; Python for LLM/evals | [Project 19 — Rust hot-path](../../career-project-specs/19-rust-hot-path-lab.md); optional stretch in Projects 20–21 |

**In scope vs defer:**

| Rust is used for (in scope) | Practice in | Defer (not playbook spine) |
|-----------------------------|-------------|----------------------------|
| HTTP/CLI probe, ownership + `Result` | [Project 18](../../career-project-specs/19-rust-hot-path-lab.md) | Greenfield Rust API replacing Project 5/7 |
| Project 8 gateway or worker **reimplementation** | Project 18 | Second concurrent worker engine while Project 8 Go unfinished |
| IoT / edge ingest (optional) | Future stretch + [PROGRESS.md](../../PROGRESS.md) notes | Full embedded/robotics curriculum |
| WASM / CLI tools | Side demos tied to one load-bearing property | Blockchain, game engines |

**Order:** Ship Project 8 in **Go** first. Use Project 18 for Rust syntax and hot-path ADR **after** Project 8 Go is green—**do not** run Go + Rust reimplementation as parallel spines.

---

## How it runs

| Execution | Typing | Memory / concurrency |
|-----------|--------|----------------------|
| **Ahead-of-time (AOT) compiled** via `cargo build`; no runtime interpreter | Static typing; **ownership** + **borrow checker** enforce memory safety at compile time | No garbage collection (GC); **`Result`/`Option`** for errors/absence; **`async`/`await`** + **tokio** after sync path is solid |

---

## Environment setup

1. Install: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh` then `rustc --version`.
2. New project: `cargo new myworker --bin` (or `--lib`).
3. Optional pin: `rust-toolchain.toml` with `channel = "stable"` for CI parity.
4. Commit **`Cargo.lock`** for binaries; library crates may omit per team policy—follow project README.
5. Project 18 lab clone under [`career-projects/`](../../career-projects/) per spec.

---

## Project layout

```
myworker/
├── src/
│   ├── main.rs          # binary entry (or lib.rs for library crate)
│   └── ...
├── Cargo.toml           # deps + package metadata
├── Cargo.lock
└── target/              # build artifacts — gitignored
```

---

## Commands you'll use often

| Intent | Command | Notes |
|--------|---------|-------|
| Run | `cargo run` | Dev binary |
| Test | `cargo test` | Unit + integration |
| Release build | `cargo build --release` | Deploy artifact |
| Lint | `cargo clippy` | Stricter than `cargo check` |
| Format | `cargo fmt` | CI formatting gate |

---

## How concepts show up

**Ownership / errors**

- Each value has one owner; **borrow** (`&T`) for read-only access; **`Result<T,E>`** + **`?`** at integration boundaries—map to HTTP 500 / dead-letter queue (DLQ) like Go workers.

**HTTP / workers**

- **axum**, **actix-web**, **reqwest**/**ureq**—same integration boundaries as Go Project 8; same idempotency/DLQ semantics.

**Async**

- **`async fn`** + **`.await`** on **tokio**—learn **after** a sync HTTP/worker path unless your lab README commits to async ([Language fundamentals — async Rust](language-fundamentals-comparison.md)).

---

## Footguns

- **Fighting the borrow checker** in large AI-generated dumps—start small; one binary, one crate.
- **Unbounded `tokio::spawn`** — same as unbounded goroutines; use semaphores/worker pools.
- **`.unwrap()` in workers** — panics poison async tasks; propagate `Result` and map to DLQ/retry policy.
- **Duplicate logic** — Rust reimplementation must share **same HTTP/queue contract** as Go Project 8, not a divergent API.
- **Unnecessary `.clone()` in hot paths** — measure peak RSS and alloc/op in [Project 18](../../career-project-specs/19-rust-hot-path-lab.md) ADR vs Go baseline.

---

## Plain language: terms used on this page

| Term | Means |
|------|--------|
| **Ownership** | Rust tracks who may read/write memory; prevents use-after-free and data races at compile time. |
| **Borrow** | Temporary access to data without taking ownership (`&foo`). |
| **Crate** | Rust package (library or binary) built by Cargo. |
| **Second growth lane** | Practice **after** the Go spine milestone—not in parallel with it as a second active lab. |

### Read next (handbook)

- [Concurrency basics](../concepts/software-engineering.md#concurrency-basics)
- [Memory and performance](../concepts/memory-and-performance.md)
- [Integration: sync, async, messaging](../concepts/software-engineering.md#integration-sync-async-and-messaging)
- [Language fundamentals comparison — Rust](language-fundamentals-comparison.md)

---

## Career positioning

**Target profile:** Backend & Systems Engineer (Rust + Go) in the UK £70k–£100k band — not HFT/trading or blockchain OMS unless you pivot deliberately.

| Playbook milestone | Interview signal |
|--------------------|-------------------|
| [Project 8 Go](../../career-project-specs/08-go-retrieval-worker-lab.md) green | Throughput, idempotency, Python↔Go boundary |
| [Project 18 Rust](../../career-project-specs/19-rust-hot-path-lab.md) + ADR | Hot-path evidence with p95 + peak RSS; Tokio async |
| [Project 21 capstone](../../career-project-specs/22-integrated-platform-capstone.md) | Distributed system narrative |

**Pre-Project 19 CLI practice:** [Project 14 shell automation](../../career-project-specs/14-shell-automation-lab.md) (bash glue) · formal ops CLI in [Project 15](../../career-project-specs/15-devops-cli-lab.md) (Go; Rust stretch after P19).

Full mapping: [Career targeting — UK market](../career/target-alignment.md)

---

## See also

- [Go stack map](go.md) — primary throughput lane before Rust
- [Python stack map](python.md) — LLM lane
- [Career targeting — UK market](../career/target-alignment.md)
- [Language fundamentals comparison](language-fundamentals-comparison.md) — syntax side-by-side (includes Rust column)
