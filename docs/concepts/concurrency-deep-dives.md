# Concurrency deep dives (Part 2)

**Prerequisite:** [Concurrency runtime model (Part 1)](concurrency-runtime-model.md) — read the layered mental model first.

**Use this:** Interview depth and "how it actually works" for Go workers ([Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md)) and Node APIs ([Project 7](../../career-project-specs/07-node-typescript-lab.md), [Project 13](../../career-project-specs/13-realtime-dashboard-lab.md)).

**Next after this:** [Concurrency beyond syntax](../languages/language-fundamentals-comparison.md#concurrency-beyond-syntax) → [Concurrency basics](software-engineering.md#concurrency-basics) → ship a lab.

---

## Table of contents

- [Go M:N scheduler](#go-mn-scheduler)
- [Goroutines vs OS threads](#goroutines-vs-os-threads)
- [Node event loop at scale](#node-event-loop-at-scale)
- [CPU pipeline and switching](#cpu-pipeline-and-switching)
- [Code anchors](#code-anchors)

---

## Go M:N scheduler

Go uses an **M:N scheduler**: **M** goroutines multiplex onto **N** OS threads. You write `go fn()` freely; the runtime decides which goroutine runs on which thread and which thread sits on which core.

Conceptual mapping (names match Go runtime vocabulary):

| Piece | Role |
|-------|------|
| **G (goroutine)** | Your lightweight task |
| **M (machine)** | OS thread executing Go code |
| **P (processor)** | Logical CPU resource holding a run queue of G's |

When a goroutine **blocks** on I/O, the runtime can park it and run another goroutine on the same OS thread—so blocking syscalls do not necessarily waste a whole core. When a goroutine **blocks** in cgo or some syscalls, the runtime may spin up another M.

**`GOMAXPROCS`** (default: number of logical CPUs) caps how many P's run Go code **simultaneously**. That is how Go gets **parallelism** on multi-core machines. Setting it to 1 forces single-core behavior for debugging.

**Playbook tie-in:** [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) still needs a **bounded worker pool**—the scheduler makes goroutines cheap, not free. Unbounded `go handler()` per message exhausts memory and file descriptors under load.

**Interview one-liner:** "Go multiplexes many goroutines onto fewer OS threads via M:N scheduling; `GOMAXPROCS` controls parallel P's, but I still cap fan-out with semaphores or worker pools."

**See also:** [GOMAXPROCS](software-engineering-glossary.md#gomaxprocs) · [M:N scheduling](software-engineering-glossary.md#mn-scheduling)

---

## Goroutines vs OS threads

| | **OS thread** | **Goroutine** |
|---|---------------|---------------|
| **Created by** | OS / `pthread` | Go runtime (`go` keyword) |
| **Typical stack** | MB (fixed or large) | KB growing as needed |
| **Switch cost** | Kernel context switch | User-space, cheaper |
| **Blocking** | Blocks the OS thread unless runtime parks it | Runtime parks G, runs other G's on same M |
| **Communication** | Shared memory + locks | Prefer channels + `select`, `context` |

Goroutines are **not** "free threads." They are **cheap tasks** with cooperative scheduling and runtime integration. You still design for **cancellation** (`context.Context`), **backpressure** (semaphore, worker pool), and **avoid shared mutable state** without synchronization.

**Anti-pattern:** one goroutine per incoming message with no cap on a CPU-heavy loop—looks concurrent, melts memory, and may still serialize on the GIL-equivalent hot locks inside the runtime or your code.

**Interview one-liner:** "Goroutines are user-space tasks with small stacks and runtime scheduling—not one OS thread each—so I bound pools and propagate context cancel."

**See also:** [Goroutine](software-engineering-glossary.md#goroutine) · [Go stack map](../languages/go.md)

---

## Node event loop at scale

Node handles **many concurrent connections** on **one JavaScript thread** because I/O is **non-blocking** at the libuv layer: sockets register for readiness (`epoll` on Linux, `kqueue` on macOS, IOCP on Windows); when data is ready, libuv queues a callback on the event loop.

Rough flow for 10,000 idle HTTP connections:

1. Each connection is a **socket** watched by libuv—not a thread per connection.
2. When bytes arrive, the loop runs your callback (parse headers, `async` handler continuation).
3. While your handler **awaits** a database or upstream HTTP call, the loop serves other connections.
4. **Microtasks** (`Promise` continuations) run before the next I/O phase—ordering matters for starvation bugs.

**When parallelism appears in Node:**

| Mechanism | Use |
|-----------|-----|
| **libuv thread pool** | Some fs, dns, crypto offload (limited pool size) |
| **`worker_threads`** | CPU-heavy JS (hashing, compression) off main loop |
| **`cluster` module** | Multiple processes, one loop each—true multi-core for CPU |

**Playbook tie-in:** [Project 7](../../career-project-specs/07-node-typescript-lab.md) BFF and [Project 13](../../career-project-specs/13-realtime-dashboard-lab.md) SSE—keep handlers async; never sync-read large files on the hot path.

**Interview one-liner:** "Node scales concurrent I/O with one event loop and non-blocking sockets—not one thread per client; CPU work belongs in worker threads or another service."

**See also:** [Event loop](software-engineering-glossary.md#event-loop) · [Node + TypeScript stack map](../languages/node-typescript-backend.md)

---

## CPU pipeline and switching

Even on **one core**, you get **concurrency** because the OS **preempts** threads: save registers, load another thread's state, resume later. Each switch has **cost** (cache cold, TLB misses)—why "millions of threads" hurts.

Inside a core, **pipelines** overlap fetch/decode/execute stages for **one** instruction stream. **Hyper-threading** fills pipeline bubbles with a second logical stream on the same core—helpful, not a substitute for another core.

**Why I/O-bound systems love async runtimes:** while one task waits on network RTT (milliseconds), the CPU can run other tasks. **CPU-bound** work on the same thread **does not** yield those gaps—you need another core (process pool, worker thread, Go worker pool, Rust `rayon`).

**Interview one-liner:** "Context switches buy concurrency on limited cores; async helps when tasks wait on I/O, not when they're CPU-saturated on one thread."

---

## Code anchors

Minimal patterns—production labs add metrics, DLQ, and tests.

### Go — bounded fan-out

```go
sem := make(chan struct{}, maxConcurrent) // worker pool cap
for _, id := range ids {
    select {
    case <-ctx.Done():
        return ctx.Err()
    case sem <- struct{}{}:
        go func(id string) {
            defer func() { <-sem }()
            fetch(ctx, id)
        }(id)
    }
}
```

### Node — bounded parallel fetch

```typescript
async function mapConcurrent<T, R>(items: T[], limit: number, fn: (t: T) => Promise<R>): Promise<R[]> {
  const results: R[] = [];
  let i = 0;
  async function worker() {
    while (i < items.length) {
      const idx = i++;
      results[idx] = await fn(items[idx]);
    }
  }
  await Promise.all(Array.from({ length: limit }, () => worker()));
  return results;
}
```

### Python — asyncio semaphore

```python
sem = asyncio.Semaphore(10)
async def bounded_fetch(url: str) -> bytes:
    async with sem:
        async with httpx.AsyncClient(timeout=5.0) as client:
            return (await client.get(url)).content
```

**See also:** [Project 8 spec — context and bounded fan-out](../../career-project-specs/08-go-retrieval-worker-lab.md) · [Illustrative snippets](illustrative-snippets.md)

---

## See also

- [Concurrency runtime model (Part 1)](concurrency-runtime-model.md)
- [Memory and performance](memory-and-performance.md)
- [Software engineering — Concurrency basics](software-engineering.md#concurrency-basics)

---

## Technical reference

### Go scheduler (G / M / P)

| Symbol | Role |
|--------|------|
| **G** | Goroutine |
| **M** | OS thread (machine) |
| **P** | Logical processor holding a run queue |

### Node / libuv

| Piece | Role |
|-------|------|
| **Event loop** | Runs JavaScript callbacks when I/O completes |
| **libuv thread pool** | Some blocking syscalls off main thread |
| **epoll / kqueue / IOCP** | OS APIs for watching many sockets |

### Commands

```bash
# Go CPU profile (30s)
go tool pprof http://localhost:6060/debug/pprof/profile?seconds=30
```

### Glossary links

- [GOMAXPROCS](software-engineering-glossary.md#gomaxprocs) · [Goroutine](software-engineering-glossary.md#goroutine)
- [Event loop](software-engineering-glossary.md#event-loop) · [Bounded concurrency](software-engineering-glossary.md#bounded-concurrency--worker-pool)

### Interview one-liners

- "Go parks blocked goroutines and runs others on the same M; GOMAXPROCS caps parallel P's."
- "Node scales concurrent sockets on one loop; CPU work needs worker_threads or another service."
