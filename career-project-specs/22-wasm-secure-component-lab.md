# Project 22 — WASM / secure network component lab (advanced)

## Problem

Ship a **small Rust component** compiled to **WASM** (or a hardened network micro-module) with strict FFI/boundary rules: sandboxed logic, no panics in prod paths, documented trust boundary with the host.

## Career relevance

**Summary:** Systems depth—**safe composition** of untrusted or performance-critical code without rewriting the whole stack.

### In depth

**Wave 3 — advanced.** Optional after [P21](21-rust-hot-path-lab.md). Scope small: one function (e.g. payload normalizer, HMAC verify helper) not a full service.

## Concept spotlight

**Pillars:** Security & Systems

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **Sandbox boundary** | WASM module cannot access host FS/network unless explicit host imports | Security/Systems |
| **No panic in prod path** | `Result` to host; documented error codes | Security/Systems |
| **FFI contract** | Versioned ABI between host (Go/TS) and module | Full-Stack, DevOps |

**Interview line:** *“We isolate payload normalization in WASM with a versioned host ABI so the module can’t escape the sandbox.”*

## Code repo

_TBD — e.g. `wasm-component-lab`._ Suggested folder: [`../career-projects/22-wasm-secure-component-lab`](../career-projects/22-wasm-secure-component-lab).

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

- Wire into [P1](01-integration-webhook-receiver.md) signature verify path as experiment.
- wasi preview2 note for edge deployment story.

## Related

- [Rust map](../docs/stacks/rust.md)
- [P8 Application security](08-application-security-lab.md)

**Wave:** 3 (advanced)
