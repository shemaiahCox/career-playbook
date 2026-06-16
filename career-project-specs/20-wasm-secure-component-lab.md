# Project 20 — WASM / secure network component lab (advanced)

## Progress

| | |
|---|---|
| **Step** | 20 of 22 |
| **Previous** | [Project 19 — Rust hot-path reimplementation lab](19-rust-hot-path-lab.md) |
| **Next** | [Project 21 — IoT / edge ingest + local inference lab](21-iot-edge-lab.md) |

## What you will learn

- Sandboxed logic with WASM components
- FFI and trust boundaries
- Secure composition of network tools

## Before you start

- **Requires:** [Project 19](19-rust-hot-path-lab.md) or strong Rust comfort · [Rust map](../docs/languages/rust.md)
- **Handbook:** [Memory and performance — WASM linear memory](../docs/concepts/memory-and-performance.md#memory-patterns)

## Problem

Ship a **small Rust component** compiled to **WASM** (or a hardened network micro-module) with strict FFI/boundary rules: sandboxed logic, no panics in prod paths, documented trust boundary with the host.

## Career relevance

**Summary:** Systems depth—**safe composition** of untrusted or performance-critical code without rewriting the whole stack.

### In depth

**Wave 3 — advanced.** Optional after [Project 19](19-rust-hot-path-lab.md). Scope small: one function (e.g. payload normalizer, HMAC verify helper) not a full service.

## Important concepts

### Concept spotlight

| **Sandbox boundary** | WASM module cannot access host FS/network unless explicit host imports |
| **No panic in prod path** | `Result` to host; documented error codes |
| **FFI contract** | Versioned ABI between host (Go/TS) and module |
| **Linear memory + latency** | Hostile input bounded; compare WASM vs native latency in README ([Memory and performance](../docs/concepts/memory-and-performance.md)) |

**Interview line:** *“We isolate payload normalization in WASM with a versioned host ABI so the module can’t escape the sandbox.”*


**Interview line:** *“We isolate payload normalization in WASM with a versioned host ABI so the module can’t escape the sandbox.”*

## Code repo

_TBD — e.g. `wasm-component-lab`._ Suggested folder: [`../career-projects/20-wasm-secure-component-lab`](../career-projects/20-wasm-secure-component-lab).

## Stack

- **Rust** → `wasm32-wasi` or `wasm-bindgen` (document target)
- **Host:** Go or Node smoke test invoking module
- wasmtime/wasmer or browser test harness

## Success criteria

- [ ] Module builds; host invokes with sample input/output.
- [ ] Invalid input returns error to host, no panic.
- [ ] README trust diagram: what WASM can/cannot do.
- [ ] Version field in ABI for future changes.

## Testing approach (lab)

Rust unit tests + host integration test with golden vectors.

## Exploration scenarios

1. Hostile input size → error, bounded memory.
2. ABI version mismatch → host rejects load.
3. Compare latency vs native Rust fn (note in README).

## Stretch

- Wire into [Project 1](01-integration-webhook-receiver.md) signature verify path as experiment.
- wasi preview2 note for edge deployment story.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — host runtime → WASM sandbox → narrow function boundary.
- [ ] **ADR** — what runs in WASM vs native (e.g. HMAC helper, normalizer).
- [ ] **Performance numbers** — WASM vs native call overhead for one hot function.
- [ ] **Failure modes** — sandbox escape assumptions; FFI panic taking down host.
- [ ] **Observability evidence** — log on WASM invoke success/failure with input hash only.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 20)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 21 — IoT / edge ingest + local inference lab](21-iot-edge-lab.md)
