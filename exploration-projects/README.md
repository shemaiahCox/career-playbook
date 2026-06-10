# Exploration projects

Commented **language sandboxes** for your **core stack** (PHP, Node/TypeScript, Go, Rust). They stay **inside** this playbook repo. **Career labs** (**webhook**, **RAG**, **SQL**, **Go worker**, …) live under [`career-projects/`](../career-projects/README.md)—not here.

Specs and ordering: [`career-project-specs/`](../career-project-specs/) · [FOCUS.md](../FOCUS.md) · [PROGRESS.md](../PROGRESS.md).

## How these map to your stack

| Sandbox | Stack | Career spec tie-in |
|---------|--------|-------------------|
| [laravel-route-slice](laravel-route-slice/) | PHP / Laravel | [P1 webhook](../career-project-specs/01-integration-webhook-receiver.md), [P2 API](../career-project-specs/02-contract-first-api.md) |
| [node-ts-http-probe](node-ts-http-probe/) | Node + TypeScript | [P6 Node/TS lab](../career-project-specs/06-node-typescript-lab.md) |
| [go-cli-http-probe](go-cli-http-probe/) | Go | [P9 Go retrieval/worker](../career-project-specs/09-go-retrieval-worker-lab.md), [P5 async worker](../career-project-specs/05-async-worker-stretch.md) |
| [rust-cli-http-probe](rust-cli-http-probe/) | Rust (Tier‑2) | [P9 Rust stretch](../career-project-specs/09-go-retrieval-worker-lab.md#stretch) **after** Go core; syntax anytime |

**Fundamentals reference:** [Language fundamentals comparison](../docs/handbook/language-fundamentals-comparison.md) (JS/TS, PHP, Go, Python, Rust, SQL pointer).

## Suggested order

1. **[laravel-route-slice](laravel-route-slice/)** — Composer, routes, controllers (PHP ingress mental model).
2. **[node-ts-http-probe](node-ts-http-probe/)** — `fetch`, typed CLI, ESM/TS config.
3. **[go-cli-http-probe](go-cli-http-probe/)** — `(value, error)`, `context`, HTTP client—stepping stone to P9 workers.
4. **[rust-cli-http-probe](rust-cli-http-probe/)** — ownership, `Result`, Cargo—**after P9 Go green** for stretch, or earlier for syntax only (not a second spine).

## Why four (not every language)

The playbook focuses on **integrations + automation + AI** on **JS/TS, PHP, SQL, Go, Python, Rust (Tier‑2)**. Breadth sandboxes for Java, mobile, or full-stack React frameworks stay out of scope to keep practice aligned with where you ship.

## How to use the commented code

- Read **[Language fundamentals comparison](../docs/handbook/language-fundamentals-comparison.md)** for side-by-side syntax.
- Start with **file header comments**, then inline **why** comments in each sandbox.
- When a sandbox feels easy, return to the active **career-project-spec** and ship success criteria there.

## Git and artifacts

Tracked: Markdown + sandbox sources. **`node_modules/`**, **`vendor/`**, **`target/`**, binaries remain ignorable per [.gitignore](../.gitignore).

---

**Next:** Skim [Language fundamentals comparison](../docs/handbook/language-fundamentals-comparison.md), then open the sandbox for your **active spec**—or [rust-cli-http-probe](rust-cli-http-probe/README.md) only when exploring Tier‑2 after P9 Go.
