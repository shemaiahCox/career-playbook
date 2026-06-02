# Ecosystem map: Go

**Use this:** **Go** is your **performance and concurrency** lane—queue workers, retrieval gateways, integration microservices—beside **Python** (LLM/RAG) and **PHP/Node** (HTTP ingress).

**Companion:** [term cards](README.md) · [Project 9 Go lab](../../career-project-specs/09-go-retrieval-worker-lab.md) · [Language fundamentals — Go](../handbook/language-fundamentals-comparison.md)

**New here?** [Plain language (bottom)](#plain-language-terms-used-on-this-page) · [Stacks glossary](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | Compiled binary, **GC**, goroutines (lightweight threads), **no classes**—structs + methods + interfaces. |
| **Modules** | `go.mod` / `go.sum`; import path = module path + package dir. |
| **Errors** | `(T, error)` return—caller checks every time; `if err != nil`. |
| **Concurrency** | `go fn()` + channels + `context` for cancel/timeouts; prefer **explicit** over shared mutable state. |
| **HTTP** | `net/http` stdlib server/client; common pattern for workers and small services. |

---

## When Go vs Python in this playbook

| Use Go | Use Python |
|--------|------------|
| Queue consumers, high fan-out retrieval | LLM calls, eval harness, orchestration libraries |
| Strict latency/timeouts on chunk fetch | Prompt design, citation policy, rapid iteration |
| Small static binaries for workers | FastAPI product API with rich ML ecosystem |

Industry context: many **vector DBs**, **workflow engines**, and **K8s tooling** are Go—useful reading fluency, not a requirement to memorize every project.

---

## Footguns

- **Ignoring `err`** — silent failures in workers poison queues.
- **Unbounded goroutines** — one goroutine per message without a worker pool → OOM under load.
- **Slice sharing** — passing subslices that alias backing arrays unexpectedly.
- **No generics confusion** — Go 1.18+ has generics; still idiomatic to keep APIs simple.

---

## Read next (handbook)

- [Concurrency basics](../handbook/software-engineering.md#concurrency-basics)
- [Integration: sync, async, messaging](../handbook/software-engineering.md#integration-sync-async-and-messaging)
- [Algorithms study path](../paths/algorithms-study-path.md)

**Sandbox:** [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/README.md)

---

## Plain language: terms used on this page

| Term | Means |
|------|--------|
| **Goroutine** | Lightweight concurrent task scheduled by the Go runtime—not an OS thread per goroutine. |
| **`context`** | Carries deadlines and cancellation through API calls—use in HTTP handlers and workers. |
| **Module** | Your project’s import path root (`go.mod`). |
| **Interface** | Set of methods; types satisfy interfaces **implicitly** (no `implements` keyword). |
