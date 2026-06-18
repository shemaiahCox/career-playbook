# Project 20 — WASM / secure network component lab (advanced)

## Progress

| | |
|---|---|
| **Step** | 20 of 22 |
| **Track** | **Optional — future Rust track.** Requires [Project 19](19-rust-hot-path-lab.md) or strong Rust comfort. Skip entirely when Rust is paused; not needed for Go-first backend/systems positioning. |
| **Previous** | [Project 19 — Rust hot-path reimplementation lab](19-rust-hot-path-lab.md) |
| **Next** | [Project 21 — IoT / edge ingest + local inference lab](21-iot-edge-lab.md) |

## What you will learn

- Sandboxed logic with WASM components
- FFI and trust boundaries
- Secure composition of network tools

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 1. System shape | WASM sandbox vs native host; trust boundary placement |
| 4. Performance & language boundaries | What runs in WASM vs native; FFI costs |
| 5. Reliability, security, operations | Sandboxed logic, capability limits |

**Required ADR(s):** tag each ADR with pillar (e.g. WASM vs native for hot logic — **Pillar 1 + 4**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

## Before you start

- **Requires:** [Project 19](19-rust-hot-path-lab.md) or strong Rust comfort · [Rust map](../docs/languages/rust.md)
- **Go-first alternative:** Skip when Rust is paused. Sandboxing and trust-boundary thinking can be documented as an ADR in [Project 9](09-application-security-lab.md) or the capstone without a WASM build.
- **Handbook:** [Memory and performance — WASM linear memory](../docs/concepts/memory-and-performance.md#memory-patterns)

## Problem

Ship a **small Rust component** compiled to **WASM** (or a hardened network micro-module) with strict FFI/boundary rules: sandboxed logic, no panics in prod paths, documented trust boundary with the host.

## Career relevance

**Summary:** Systems depth—**safe composition** of untrusted or performance-critical code without rewriting the whole stack.

### In depth

**Wave 3 — advanced.** Optional after [Project 19](19-rust-hot-path-lab.md). Scope small: one function (e.g. payload normalizer, hash-based message authentication code (HMAC) verify helper) not a full service.

**Why learning this moves the needle**

- **Trust boundaries:** Sandboxed modules limit blast radius when parsing hostile or third-party payloads.
- **Composition over rewrite:** One hot function in WebAssembly (WASM) beats re-platforming an entire service for a narrow security or latency win.
- **Interview differentiation:** Explaining host ABI versioning and sandbox limits shows systems thinking beyond application CRUD.

**Real-world situations this project mirrors**

- **Payload normalization:** untrusted JSON or binary normalized in WASM before the host touches business logic.
- **ABI evolution:** version field in the foreign function interface (FFI) contract so host and module stay compatible across releases.
- **Latency tradeoff:** compare WASM invoke overhead vs native Rust for one hot function—document when sandbox cost is acceptable.

### How to talk about this

You isolate payload normalization in WASM with a versioned host application binary interface (ABI) so the module cannot escape the sandbox. When interviewers ask what WASM can do, explain explicit host imports for filesystem or network—default deny. When they ask about failures, describe `Result` to host with documented error codes and no panic in production paths.

## Important concepts

### Sandbox boundary

A WASM module cannot access host filesystem or network unless you expose explicit host imports. Default deny keeps untrusted logic contained.

### No panic in prod path

Return `Result` to the host with documented error codes; never panic across the FFI boundary—a WASM trap should not take down the host process.

### FFI contract

Version the ABI between host (Go/TypeScript) and module. Breaking changes require a new ABI version; hosts reject mismatched loads.

### Linear memory and latency

Bound hostile input size before copy into linear memory. Compare WASM vs native call latency for one hot function in README ([Memory and performance](../docs/concepts/memory-and-performance.md)).

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
