# Ecosystem map: Go

**Use this:** **Go** is your **performance and concurrency** lane—queue workers, retrieval gateways, integration microservices—beside **Python** (LLM/RAG) and **PHP/Node** (HTTP ingress).

**Companion:** [docs README](../README.md) · [Project 8 Go lab](../../career-project-specs/08-go-retrieval-worker-lab.md) · [Language fundamentals — Go](language-fundamentals-comparison.md)

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

## What to practice here vs defer

Generic “build anything in Go” lists are broader than this playbook. Use this filter so **AI + automation + cloud** stay on one spine:

| Go is used for (in scope) | Practice in | Defer (not playbook spine) |
|---------------------------|-------------|----------------------------|
| Queue workers, DLQ, ingest jobs | [Project 6](../../career-project-specs/06-async-worker-stretch.md), [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) | Full e‑commerce/blog API in Go (use Project 5/Project 7) |
| Retrieval gateway, chunk fan-out | [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) | LLM/evals in Go (use [Project 2](../../career-project-specs/02-rag-llm-service.md)) |
| Small HTTP service boundaries | Project 8 `/retrieve`, health | Greenfield chat apps unless capstone stretch |
| CLI / ops probes | [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md), [Project 14](../../career-project-specs/14-devops-cli-lab.md) | Backup utilities unrelated to labs |
| Event bus / streams (stretch) | Project 8 after Project 6 queues | Building a Boomi/n8n clone |
| Cloud-native habits | Docker Compose, managed queue in README | K8s/AWS cert curriculum |

**Easy follow path:** [Project catalog](../../README.md#progression-step-1--20) · [Project 8 capstone stretch](../../career-project-specs/08-go-retrieval-worker-lab.md#stretch-connect-your-labs) · [Project 18 Rust](../../career-project-specs/18-rust-hot-path-lab.md) (after Project 8, not parallel).

---

## Footguns

- **Ignoring `err`** — silent failures in workers poison queues.
- **Unbounded goroutines** — one goroutine per message without a worker pool → OOM under load.
- **Skipping pprof** — tune fan-out blindly; capture CPU + heap under load before changing pool sizes ([Memory and performance](../concepts/memory-and-performance.md)).
- **Slice sharing** — passing subslices that alias backing arrays unexpectedly; preallocate with `make([]T, 0, n)` when batch size is known.
- **No generics confusion** — Go 1.18+ has generics; still idiomatic to keep APIs simple.

---

## Read next (handbook)

- [Concurrency basics](../concepts/software-engineering.md#concurrency-basics)
- [Memory and performance](../concepts/memory-and-performance.md)
- [Integration: sync, async, messaging](../concepts/software-engineering.md#integration-sync-async-and-messaging)
- [Algorithms study path](../concepts/algorithms-study-path.md)

---

## Plain language: terms used on this page

| Term | Means |
|------|--------|
| **Goroutine** | Lightweight concurrent task scheduled by the Go runtime—not an OS thread per goroutine. |
| **`context`** | Carries deadlines and cancellation through API calls—use in HTTP handlers and workers. |
| **Module** | Your project’s import path root (`go.mod`). |
| **Interface** | Set of methods; types satisfy interfaces **implicitly** (no `implements` keyword). |
