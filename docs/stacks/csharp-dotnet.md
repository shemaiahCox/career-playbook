# Ecosystem map: C# / .NET (backend-shaped)

**Use this:** You design, review, or ship **HTTP APIs**, **workers**, or **libraries** on **.NET** (minimal APIs, ASP.NET Core, generic host). UI stacks (MAUI, WPF) are out of scope here except **thread affinity** notes.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **CLR** executes managed code under a **garbage collector (GC)**; **classes vs structs/records** differ in copying vs referencing—shows up whenever you chase **allocation pressure**. |
| **Project system** | **SDK-style** `.csproj` files list dependencies; **NuGet** restores packages when you restore/build; **target frameworks** (`net8.0`, …) declare which APIs exist. |
| **Hosting** | **Generic Host** / **WebApplication** wires dependency injection (**DI**), configuration, structured logging—you rarely invent wiring from scratch. |
| **API surface** | **Minimal APIs** (lambda-style routes) vs **controllers** (`ControllerBase`)—different ergonomics but same runtime; harmonize inside one codebase. |

---

## How concepts show up

**Async**

- **`async`/`await`** compiles to state machines; **`ConfigureAwait(false)`** matters mainly in **library code**; **ASP.NET Core** sync context differs from UI frameworks.
- **CancellationToken** is threaded through stack **by convention** — dropping it loses cooperative shutdown.

**DI (built-in)**

- **Constructor injection**; **service lifetimes** (**Singleton / Scoped / Transient**). Common bug: **scoped service captured by singleton** → **captive dependency** (wrong lifetime / stale state).

**Data**

- **EF Core** migrations, **connection resilience**, **transactions** — architect-level same as any ORM: **N+1**, lazy load surprises, **isolation** expectations.

**Observability**

- **`ILogger<T>`**, **Activity**/OpenTelemetry tracing — wire **correlation IDs** at request edge.

---

## Footgun checklist

- [ ] **Async all the way** — avoid **sync-over-async** (`Result`, `.GetAwaiter().GetResult()` in request path) unless you fully understand deadlocks.
- [ ] **DI lifetimes** — no scoped dependencies in singletons; watch **DbContext** scope.
- [ ] **Culture / serialization** — `DateTime` vs `DateTimeOffset`, timezone in APIs; **invariant culture** for stable wire formats.
- [ ] **Exception swallowing** in middleware — you lose **signals** in production.

---

## Plain language: terms used on this page

If “DI lifetime” sounded like furniture assembly, pause here—this is decoding, not trivia.

- **CLR** — Virtual machine/runtime that executes .NET **IL** bytecode.
- **GC** — Garbage collector frees unused objects—fewer manual leaks, still watch huge retained graphs.
- **Reference type vs struct/record value semantics** — “Copy vs share” pitfalls when structs embed references and vice versa.
- **NuGet / .csproj / target framework** — Package restore + declarations of `.NET` version & dependencies.
- **Generic Host / WebApplication** — Bootstrap standard services (logging, options, hosted services): your app hooks into pipes instead of rewriting plumbing.
- **Minimal API vs controllers** — Two authoring styles over the same ASP.NET Core stack.
- **`async` / `await`** — Sugar over state machines cooperative with the thread pool (`Task`).
- **`ConfigureAwait(false)`** — Tells awaited code **not** to resume on capturing sync context—mainly libraries avoid UI deadlock footguns (**less critical in ASP.NET Core** vs desktop UI).
- **CancellationToken** — Cooperative “please stop soon” signal—pass it through awaits or shutdown becomes rude.
- **DI — Dependency Injection** — Framework resolves concrete services constructors need.
- **Singleton / Scoped / Transient lifetimes** — How long DI keeps instances—singleton outliving scoped objects creates **stale captive state** (**captive dependency**).
- **`DbContext`** — EF Core database session/unit-of-work-ish object—normally **scoped per HTTP request**.
- **`ILogger<T>` / Activity / OpenTelemetry** — Structured logs + spans for diagnosing production traffic (**correlation id** threading links events).
- **EF Core / migrations** — Database mapping + scripted schema bumps—relationship to raw SQL echoes other ORM maps here.

### Read next (handbook)

- **[Async sketch — C# row](../handbook/software-engineering.md#async-sketch)** and **[Concurrency basics](../handbook/software-engineering.md#concurrency-basics)** — `Task`, pools, blocking pitfalls.
- **[Example: idempotent webhook or job](../handbook/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — HTTP APIs + queues you ship or consume.
- **[ORMs and the N+1 pattern](../handbook/database-design.md#orms-and-the-n1-query-pattern)** — EF Core lazy loading surprises.
- **[Observability: logs, metrics, traces](../handbook/software-engineering.md#observability-logs-metrics-traces)** — `ILogger`, `Activity`, OpenTelemetry named in depth.

---

## See also

- [Software engineering breadth](../handbook/software-engineering.md) — REST, versioning, security.
- **ASP.NET Core** middleware ordering (auth, exception handler, endpoints) — order changes behavior.
