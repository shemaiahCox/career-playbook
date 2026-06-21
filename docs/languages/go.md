# Ecosystem map: Go

**Use this:** **Go** is your **performance and concurrency** lane—queue workers, retrieval gateways, integration microservices—beside **Python** (LLM/RAG) and **PHP/Node** (HTTP ingress).

**Companion:** [docs README](../README.md) · [Project 8 Go lab](../../career-project-specs/08-go-retrieval-worker-lab.md) · [Language fundamentals — Go](language-fundamentals-comparison.md)

**New here?** [Plain language (bottom)](#plain-language-terms-used-on-this-page) · [Stacks glossary](glossary.md)

---

## Best for, alternatives, and playbook fit

| Best for | Use instead when | Primary projects |
|----------|------------------|------------------|
| Queue consumers, retrieval gateway, strict latency/timeouts on chunk fetch | Python for LLM calls, eval harness, orchestration; Node/PHP for spec-named HTTP ingress | [Project 6](../../career-project-specs/06-async-worker-stretch.md), [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md), [Project 15 CLI](../../career-project-specs/15-devops-cli-lab.md) |

**In scope vs defer** (playbook filter—not a generic “learn all Go” list):

| Go is used for (in scope) | Practice in | Defer (not playbook spine) |
|---------------------------|-------------|----------------------------|
| Queue workers, dead-letter queue (DLQ), ingest jobs | Project 6, Project 8 | Full e‑commerce/blog API in Go (use Project 5/7) |
| Retrieval gateway, chunk fan-out | Project 8 | LLM/evals in Go (use [Project 2](../../career-project-specs/02-rag-llm-service.md)) |
| Small HTTP service boundaries | Project 8 `/retrieve`, health | Greenfield chat apps unless capstone stretch |
| CLI / ops probes | Project 8, Project 15 | Backup utilities unrelated to labs |
| Event bus / streams (stretch) | Project 8 after Project 6 queues | Building a Boomi/n8n clone |
| Cloud-native habits | Docker Compose, managed queue in README | K8s/AWS cert curriculum |

**Easy follow path:** [Project catalog](../../README.md#progression-step-1--22) · [Project 8 capstone stretch](../../career-project-specs/08-go-retrieval-worker-lab.md#stretch-connect-your-labs) · [Project 19 Rust](../../career-project-specs/19-rust-hot-path-lab.md) (after Project 8 Go is green—not parallel).

Industry context: many **vector DBs**, **workflow engines**, and **K8s tooling** are Go—useful reading fluency, not a requirement to memorize every project.

---

## How it runs

| Execution | Typing | Memory / concurrency |
|-----------|--------|----------------------|
| **Ahead-of-time (AOT) compiled** binary (`go build`) | Static typing; structs + methods + **implicit interfaces** | Garbage collection (GC); **goroutines** + channels + **`context`** for cancel/timeouts—prefer explicit over shared mutable state |

---

## Environment setup

1. Install: [go.dev/dl](https://go.dev/dl/) or `brew install go`; verify `go version` (1.21+ typical).
2. New module: `go mod init example.com/myworker` in an empty directory.
3. Add deps as you import; run `go mod tidy` before commit.
4. Commit **`go.sum`** with **`go.mod`**—CI and prod must resolve the same graph.
5. Project 8 lab clone under [`career-projects/`](../../career-projects/) per spec.

---

## Project layout

```
myworker/
├── cmd/
│   └── worker/
│       └── main.go      # package main — entry
├── internal/            # private packages (not importable outside module)
│   ├── queue/
│   └── retrieve/
├── go.mod
├── go.sum
└── *_test.go            # tests alongside code
```

---

## Commands you'll use often

| Intent | Command | Notes |
|--------|---------|-------|
| Run | `go run ./cmd/worker` or `go run .` | From module root |
| Test | `go test ./...` | `-race` under load paths |
| Build | `go build -o bin/worker ./cmd/worker` | Static binary for deploy |
| Vet / lint | `go vet ./...` | CI baseline; add `staticcheck` if project uses it |
| Tidy deps | `go mod tidy` | After import changes |

---

## How concepts show up

**Errors**

- `(T, error)` return—caller checks every time; `if err != nil`. Same boundary discipline as Rust `Result` at integration edges.

**HTTP / workers**

- **`net/http`** stdlib server/client; common pattern for Project 8 gateway and health checks.
- Queue consumers: **idempotency**, **dead-letter queue (DLQ)**, **max retries** aligned with [Project 6](../../career-project-specs/06-async-worker-stretch.md) semantics.

**Observability**

- Structured logs + **correlation IDs**; **pprof** before tuning goroutine pools ([Memory and performance](../concepts/memory-and-performance.md)).

---

## Footguns

- **Ignoring `err`** — silent failures in workers poison queues.
- **Unbounded goroutines** — one goroutine per message without a worker pool → OOM under load.
- **Skipping pprof** — tune fan-out blindly; capture CPU + heap under load before changing pool sizes ([Memory and performance](../concepts/memory-and-performance.md)).
- **Slice sharing** — passing subslices that alias backing arrays unexpectedly; preallocate with `make([]T, 0, n)` when batch size is known.
- **No generics confusion** — Go 1.18+ has generics; still idiomatic to keep APIs simple.

---

## Plain language: terms used on this page

| Term | Means |
|------|--------|
| **Goroutine** | Lightweight concurrent task scheduled by the Go runtime—not an OS thread per goroutine. See [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md) and [Go M:N scheduler (Part 2)](../concepts/concurrency-deep-dives.md#go-mn-scheduler). |
| **`context`** | Carries deadlines and cancellation through API calls—use in HTTP handlers and workers. |
| **Module** | Your project’s import path root (`go.mod`). |
| **Interface** | Set of methods; types satisfy interfaces **implicitly** (no `implements` keyword). |

### Read next (handbook)

- [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md) · [Deep dives (Part 2)](../concepts/concurrency-deep-dives.md)
- [Concurrency basics](../concepts/software-engineering.md#concurrency-basics)
- [Memory and performance](../concepts/memory-and-performance.md)
- [Integration: sync, async, messaging](../concepts/software-engineering.md#integration-sync-async-and-messaging)
- [Algorithms study path](../concepts/algorithms-study-path.md)

---

## See also

- [Language fundamentals comparison — Go](language-fundamentals-comparison.md) — syntax side-by-side
- [Python stack map](python.md) — LLM/RAG lane beside Go
- [Rust stack map](rust.md) — second growth lane after Project 8 Go
