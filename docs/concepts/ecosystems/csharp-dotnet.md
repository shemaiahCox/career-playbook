# Ecosystem map: C# / .NET (backend-shaped)

**Use this:** You design, review, or ship **HTTP APIs**, **workers**, or **libraries** on **.NET** (minimal APIs, ASP.NET Core, generic host). UI stacks (MAUI, WPF) are out of scope here except **thread affinity** notes.

**Companion:** [term cards](../README.md) · [unfamiliar-stack ship](../../../checklists/unfamiliar-stack-ship.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **CLR** + **GC**; reference types vs `struct` / `record` value semantics matter for **alloc pressure** and correctness. |
| **Project system** | **SDK-style** `.csproj`; **NuGet** packages; **target frameworks** (`net8.0`, etc.) pin APIs. |
| **Hosting** | **Generic Host** / **WebApplication** — **DI**, **configuration**, **logging** are first-class. |
| **API surface** | **Minimal APIs** vs **Controllers** — both valid; pick **one style per service** for consistency. |

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

## See also

- [Software engineering breadth](../../reference/software-engineering.md) — REST, versioning, security.
- **ASP.NET Core** middleware ordering (auth, exception handler, endpoints) — order changes behavior.
