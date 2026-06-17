# Software engineering

Concepts for building maintainable systems, shipping safely, and communicating in interviews—from **paradigms** and **patterns** to **APIs**, **testing**, **debugging**, **DSA**, and **observability**. Language syntax comparisons live in [Language fundamentals comparison](../languages/language-fundamentals-comparison.md).

**Companion docs:** [Command-line tooling](command-line-tooling.md) · [Servers and networking](servers-and-networking.md) · [Database design](database-design.md) · [Algorithms and data structures](algorithms-and-data-structures.md) · [Language fundamentals comparison](../languages/language-fundamentals-comparison.md) · [Software engineering glossary (A–Z)](software-engineering-glossary.md) · [SDLC ↔ playbook map](sdlc-playbook-map.md)

**If jargon-dense stack notes feel overwhelming first:** skim **[docs README — stack maps](../README.md#languages-new-to-a-stack)** and **[glossary](../languages/glossary.md)**; come back here for **longer narratives and worked patterns** (delivery semantics, idempotent handlers, N+1). For ORM query shapes, see **[Database design — N+1 pattern](database-design.md#orms-and-the-n1-query-pattern)**.

---

## Table of contents

- [How to use this doc and skill bands](#how-to-use-this-doc-and-skill-bands)
- [Complexity, change, and technical debt](#complexity-change-and-technical-debt)
- [SOLID](#solid)
- [DRY and when duplication wins](#dry-and-when-duplication-wins)
- [Programming paradigms](#programming-paradigms)
- [Scripting versus programming](#scripting-versus-programming)
- [Design patterns (GoF-style survey)](#design-patterns-gof-style-survey)
- [Patterns across languages (Go vs PHP vs TS vs Python)](#patterns-across-languages-go-vs-php-vs-ts-vs-python)
- [Architectural patterns](#architectural-patterns)
- [Domain-Driven Design (DDD)](#domain-driven-design-ddd)
- [CQRS and Event Sourcing](#cqrs-and-event-sourcing)
- [Anti-patterns (what NOT to do)](#anti-patterns-what-not-to-do)
- [Integration: sync, async, and messaging](#integration-sync-async-and-messaging)
- [Example: idempotent webhook or job (Integration)](#example-idempotent-webhook-or-job-consumer)
- [REST](#rest)
- [SOAP and WS-style services](#soap-and-ws-style-services)
- [OData](#odata)
- [GraphQL, gRPC, and webhooks](#graphql-grpc-and-webhooks)
- [Testing](#testing)
- [Debugging (workflow)](#debugging-workflow)
- [CI/CD and delivery](#cicd-and-delivery)
- [Versioning and compatibility](#versioning-and-compatibility)
- [Code review and documentation](#code-review-and-documentation)
- [Observability: logs, metrics, traces](#observability-logs-metrics-traces)
- [Security for applications](#security-for-applications)
- [Cross-language concepts and gotchas](#cross-language-concepts-and-gotchas) → see [Language fundamentals comparison](../languages/language-fundamentals-comparison.md)
- [Data structures and algorithms](#data-structures-and-algorithms)
- [Concurrency basics](#concurrency-basics)
- [Internationalization and encoding](#internationalization-and-encoding)
- [Licenses (developer awareness)](#licenses-developer-awareness)
- [Interview checklist](#interview-checklist)

---

## How to use this doc and skill bands

| Level | Focus |
|--------|--------|
| **Basic** | Definitions, “when would I use this,” one example. |
| **Intermediate** | Tradeoffs, failure modes, how teams apply this in practice. |
| **Advanced** | Distributed pitfalls, formal edges (named, not fully proved here). |

**Newcomer bridge:** If stack maps felt like alphabet soup, read **[Integration + idempotent example](#integration-sync-async-and-messaging)** and **[Concurrency basics](#concurrency-basics)** before interviews; ORM access patterns live under **[Database design — N+1](database-design.md#orms-and-the-n1-query-pattern)**.

---

## Complexity, change, and technical debt

**Basic:** Software **cost to change** rises when structure obscures intent and tests are missing. **Technical debt** is postponed work (often deliberate short-term) with carrying cost—like financial debt, interest compounds.

**Intermediate:** Prefer **small, reversible steps**; align refactors with **product risk**.

```mermaid
flowchart LR
  change[Change_request]
  design[Design_fit]
  tests[Safety_net]
  change --> design --> tests
```

---

## SOLID

**Single responsibility:** One reason to change per unit (class/module).

**Open/closed:** Extend behavior without editing stable core—often interfaces/strategy.

**Liskov substitution:** Subtypes must honor contracts of supertypes (surprises break polymorphism).

**Interface segregation:** Many small interfaces beat one fat interface clients must stub.

**Dependency inversion:** Depend on **abstractions**, not concrete low-level modules—eases testing (inject fakes).

**Tiny pseudocode (dependency inversion):**

```text
interface Clock { now(): Timestamp }
class SystemClock implements Clock { ... }
class OrderService(Clock clock) { ... }  // test injects FixedClock
```

**Intermediate:** SOLID is a **lens**, not a checklist to maximize—**YAGNI** applies.

---

## DRY and when duplication wins

**Basic:** Don’t Repeat Yourself—one authoritative place for each piece of knowledge.

**Intermediate:** **Duplication beats wrong abstraction.** If two similar pieces evolve differently, extract **after** the pattern stabilizes (Rule of Three often cited).

---

## Programming paradigms

| Paradigm | Idea | Typical strengths |
|----------|------|-------------------|
| **Imperative** | Statements mutate state | Straightforward control flow |
| **Object-oriented** | Encapsulation, messages, polymorphism | Modeling domains with nouns |
| **Functional** | Immutability, pure functions, higher-order fns | Easier reasoning about data flow |
| **Declarative** | Describe *what*, not *how* | SQL, many DSLs |

#### Paradigms (going deeper)

- **Imperative** — You write **steps** that change program state (`loop`, assignments). Easy to follow for straight-line scripts; shared mutable state can get hard to test.
- **Object-oriented** — **Encapsulation** hides invariants; **polymorphism** lets you substitute implementations. Fits domain nouns; watch for **god objects** and deep inheritance trees.
- **Functional** — Prefer **immutable** data and **pure** functions; higher-order functions (`map`, `filter`) compose pipelines. Easier reasoning in parallel; real apps still need side effects at the edges.
- **Declarative** — You state **desired outcome**; the engine decides steps (**SQL**, Terraform-style config, many UI frameworks’ templates). Debugging is “why didn’t the engine pick the plan I expected?”

**Intermediate:** Most production systems are **multi-paradigm** (e.g. FP + OOP in modern languages).

---

## Scripting versus programming

**Basic:** **“Script”** usually means a file run by an interpreter without a separate compile step; **“scripting language”** often implies fast iteration and dynamic typing—but **boundary is fuzzy**. A 5k-line “script” is still **software engineering** if it has tests and deployment.

**Intermediate:** Judge by **maintainability**, **observability**, and **risk**—not labels.

---

## Design patterns (GoF-style survey)

**Creational:** **Factory** centralizes construction; **Builder** for stepwise complex objects; **Singleton**—often overused; **global mutable state** is the gotcha.

**Structural:** **Adapter** translates interfaces; **Decorator** adds behavior wrappers; **Facade** simplifies subsystems.

**Behavioral:** **Strategy** swaps algorithms; **Observer** pub/sub; **Command** encapsulates invocations (undo queues).

**Intermediate:** Patterns are **shared vocabulary**—misapplied patterns add complexity.

---

## Patterns across languages (Go vs PHP vs TS vs Python)

**Basic:** Most GoF patterns were written for class-heavy OO languages. In dynamic or interface-light languages, the same intent is often expressed with a **function**, a **closure**, or **duck typing**—forcing the textbook class hierarchy is itself an anti-pattern.

| Pattern intent | Go | PHP (Laravel) | TypeScript / Node | Python |
|----------------|----|---------------|-------------------|--------|
| **Dependency injection** | Accept an **interface**, inject a struct; no container needed | **Service container** + constructor injection | Constructor injection, often a DI container (NestJS) | Pass callables/objects; **duck typing**, optional `Protocol` |
| **Strategy** | Func type or small interface | Class implementing an interface | First-class function passed in | Plain callable / `lambda` |
| **Singleton** | Package-level `var` + `sync.Once` | Container-bound singleton; **per-request reset** under FPM | **Module cache** makes a module a de-facto singleton | Module-level object; import caches it |
| **Iterator** | `for range` / channels | `Iterator` interface / generators | Iterables + generators (`function*`) | Generators (`yield`), iterator protocol |
| **Decorator** | Wrap a func/interface | Class wrapping + interface | Higher-order function or TS decorator syntax | Function decorators (`@wraps`) |

**Intermediate:** Key idiom differences that bite in interviews:

- **Go** has no inheritance—favor **composition** and **small interfaces** satisfied implicitly; "where's the abstract base class?" is the wrong question.
- **PHP-FPM** resets memory **per request**, so a "singleton" lives only for one request—not a cross-request cache (that needs Redis/APCu).
- **Node/TS** modules are **cached on first import**, so top-level state is effectively a singleton for the process—handy and a footgun (shared mutable state across requests).
- **Python** leans on **duck typing**; you rarely need an explicit interface—`Protocol` adds static checking when you want it.

**Cross-stack syntax:** [Language fundamentals comparison](../languages/language-fundamentals-comparison.md) · concurrency idioms in [Concurrency basics](#concurrency-basics).

---

## Architectural patterns

```mermaid
flowchart TB
  monolith[Modular_monolith]
  micro[Microservices]

  monolith -->|"split later if needed"| micro
```

| Style | Notes |
|-------|--------|
| **Layered / N-tier** | UI → app → data; simple but can hide domain model |
| **Hexagonal / ports-adapters** | Domain core; adapters for DB and HTTP |
| **Clean / Onion** | Concentric layers; **Dependency Rule**—source dependencies point **inward** |
| **Event-driven** | Loose coupling; **eventual consistency** and idempotency matter |
| **CQRS** | Different read/write models; pairs with event sourcing in some systems |
| **Microservices** | Independent deploy; **distributed complexity** (network, observability) |

#### Architectural styles (going deeper)

- **Layered / N-tier** — Clear separation (presentation / business / data) but can become **anemic domain** if “real” rules leak into stored procedures or the UI.
- **Hexagonal / ports-adapters** — **Domain** stays free of HTTP/ORM details; adapters translate. Strong fit for testability and swapping infrastructure.
- **Clean / Onion** — Same instinct as hexagonal, drawn as **concentric rings**: **entities** (enterprise rules) → **use cases** (application rules) → **interface adapters** (controllers, presenters, gateways) → **frameworks/drivers** (web, DB). The **Dependency Rule**: source-code dependencies point **only inward**, so inner layers never import outer ones—I/O is injected via interfaces the inner layers own. Easy to over-engineer for small apps; the payoff is a domain you can test without a web server or database.
- **Event-driven** — **Loose coupling** via messages; you trade simplicity for **ordering**, **duplicates**, and **eventual consistency**—design idempotent consumers.
- **CQRS** — Splits **commands** (writes) from **queries** (reads); read models can be optimized separately. Often paired with events; avoid overkill for simple CRUD. Deeper: [CQRS and Event Sourcing](#cqrs-and-event-sourcing).
- **Microservices** — **Independent deploy** and scaling; cost is **network latency**, **distributed transactions**, and **operational** load—need observability and clear boundaries.

**Intermediate:** **Modular monolith** first is a valid default—extract services when boundaries are clear.

---

## Domain-Driven Design (DDD)

**Basic:** **DDD** is a way to keep complex business rules at the center of the design instead of scattering them across controllers, SQL, and UI. The core moves are about **language** and **boundaries**.

- **Ubiquitous language** — One shared vocabulary between engineers and domain experts; the same words appear in conversations, code, and tests (an `Invoice` is `Invoice`, not `BillingRow`).
- **Bounded context** — An explicit boundary where a model and its language are consistent. `Customer` in *Billing* and `Customer` in *Support* can be different models—don't force one global schema.
- **Entity vs value object** — An **entity** has identity that persists through change (`Order #123`); a **value object** is defined only by its attributes and is immutable (`Money{amount, currency}`, `Address`).
- **Aggregate and aggregate root** — A cluster of entities/value objects treated as **one consistency unit**; outside code touches it only through the **root**, which enforces invariants. You load and save the whole aggregate, not its innards.
- **Repository** — A collection-like abstraction for loading/saving aggregates; hides persistence so the domain doesn't depend on the ORM.
- **Domain event** — A fact the domain emits (`OrderPlaced`)—the bridge from DDD to [event-driven integration](#event-driven-integration).

**Tiny example (aggregate enforces an invariant):**

```text
class Order {            // aggregate root
  private lines: OrderLine[]
  addLine(item, qty):
    if this.status != DRAFT: throw "cannot modify a submitted order"
    this.lines.push(OrderLine(item, qty))   // invariant lives in the root, not the caller
}
```

**Intermediate:** DDD shines when the **domain is genuinely complex** (rich rules, many edge cases, domain experts to talk to). It is **overkill for CRUD**—a thin layered app is cheaper. **Bounded contexts** also guide service boundaries: a context is a strong candidate seam if you later split a monolith. Watch for the **anemic domain model** anti-pattern (data-only classes with all logic in services)—see [Anti-patterns](#anti-patterns-what-not-to-do).

---

## CQRS and Event Sourcing

**Basic — CQRS (Command Query Responsibility Segregation):** Split the **write** model (commands that change state and enforce invariants) from the **read** model (queries shaped for display). They can use different schemas, even different stores—reads can be denormalized for speed while writes stay normalized and validated.

**Basic — Event Sourcing:** Instead of storing only the **current** state, store the **append-only log of events** that produced it (`AccountOpened`, `MoneyDeposited`, `MoneyWithdrawn`). Current state is derived by **replaying** events; **snapshots** cache state periodically so replay stays cheap.

```text
Traditional:  UPDATE account SET balance = 90 WHERE id = 1
Event-sourced: append MoneyWithdrawn{account:1, amount:10}   -- balance = fold(events)
```

**Intermediate (tradeoffs):**

- **CQRS** buys independent scaling and tuned read models, at the cost of **two models to keep in sync**—the read side is usually updated asynchronously, so it is **eventually consistent**. Avoid it for simple CRUD; reach for it when read and write shapes genuinely diverge.
- **Event sourcing** gives a perfect **audit trail** and **temporal queries** ("what did this look like last Tuesday?"), but adds real complexity: **schema/versioning of events**, replay performance, and the fact that you can never just "edit a row." It often pairs with CQRS (events feed read projections).

**Playbook stance:** This is **interview vocabulary** here, not a spine skill. Event sourcing at trading-firm scale is explicitly **out of scope**—see [target-alignment.md](../career/target-alignment.md). Know the definitions and tradeoffs; reach for CQRS only when read/write divergence justifies it.

---

## Anti-patterns (what NOT to do)

**Basic:** An **anti-pattern** is a common "solution" that looks reasonable but reliably causes pain. Recognizing them by name is half the fix.

| Anti-pattern | Smell | Fix |
|--------------|-------|-----|
| **God object / god class** | One class knows and does everything; every change touches it | Split by responsibility ([SOLID](#solid)); extract cohesive units |
| **Deep inheritance tree** | Behavior scattered across 5 superclasses; fragile base class | Prefer **composition** and small interfaces |
| **Anemic domain model** | Data-only classes; all rules live in "service" procedures | Put invariants on the [aggregate/entity](#domain-driven-design-ddd) |
| **Singleton / global mutable state** | Hidden shared state, hard to test, race-prone | Inject dependencies ([dependency inversion](#solid)); pass collaborators |
| **Premature / wrong abstraction** | One interface forced over two things that diverge | Tolerate duplication until the pattern stabilizes ([DRY](#dry-and-when-duplication-wins)) |
| **N+1 queries** | One query per row in a loop; latency balloons | Batch/join or eager-load—see [Database design — N+1](database-design.md#orms-and-the-n1-query-pattern) |
| **Unbounded concurrency** | `go handler()` per message; memory/connection spike | Bound with worker pool/semaphore—see [Concurrency basics](#concurrency-basics) |
| **Premature microservices** | Distributed monolith before boundaries are clear | [Modular monolith](#architectural-patterns) first; split on proven seams |
| **Blocking the main path** | Sync CPU/IO on event loop or UI thread → freezes/starvation | Move heavy work off the hot path—see [Concurrency basics](#ui-threads-and-dont-block-the-main-path) |

**Intermediate:** Most anti-patterns are **context-dependent**—a singleton config loader is fine; a singleton mutable cache shared across requests is a trap. Name the tradeoff, don't cargo-cult the rule.

---

## Integration: sync, async, and messaging

**Companion in this playbook:** [Integration hardening](../../checklists/integration-hardening.md); [Project 1 — webhook receiver](../../career-project-specs/01-integration-webhook-receiver.md); [integration-automation stack map](integration-automation.md); [docs README](../README.md) (PHP, Node, Go, Python, SQL).

### Sync HTTP callers

**Basic:** **Synchronous HTTP** means your code **waits** for the other service’s response. That is simple to reason about, but if the peer is slow or down and you have **no timeouts**, your **threads, connection pools, or event loop** fill up and failures **cascade** through the system.

**Intermediate:** Combine **timeouts**, **bounded retries with jittered backoff**, and **idempotency keys** for mutating calls so a **retry** does not double-apply an effect. Add **circuit breakers** when a dependency is clearly unhealthy so you **fail fast** instead of queuing work that will never succeed.

### Message queues and delivery semantics

**Basic:** **Queues** decouple **when** work is produced from **when** it is processed—the producer can finish while messages wait for an available worker.

**Delivery names (what product people really mean):**

| Name | Plain English | What your code must guarantee |
|------|---------------|-------------------------------|
| **At-most-once** | A message may be processed **zero or one** time; **loss** is possible on crash | Fine only when missing an event is acceptable (telemetry, best-effort cache warm) |
| **At-least-once** | **Common default** after retries: the **same logical message** may arrive **twice** | Consumer must be **idempotent** or **dedupe** with a **stable id** |
| **Exactly-once** (end-to-end) | Marketed promise; in distributed systems you usually build **effectively-once** from **at-least-once** + **idempotent writes** + careful **outbox/transaction** patterns | Design for **duplicate delivery** first; then narrow the window where it hurts |

**Message queues (reminder):** **At-least-once** delivery is the usual mental model—**consumers must be idempotent**. See also [GraphQL, gRPC, and webhooks](#graphql-grpc-and-webhooks) for **webhook**-specific notes (signatures, fast ack vs slow work). **Career context:** [Messaging and RPC](messaging-and-rpc.md) (Kafka vs Redis, REST vs gRPC).

### Example: idempotent webhook or job consumer

**Scenario:** A partner sends `POST /webhooks/orders` with JSON including `"event_id": "evt_123"`. Their side **retries** if your server is slow or returns 5xx—so your handler may see **`evt_123` twice**.

**Fragile pattern (duplicate side effects):**

```text
on POST /webhooks/orders:
  parse JSON body
  INSERT INTO orders (...) VALUES (...)      -- retry → duplicate orders
  RETURN 200
```

**Safer pattern (record idempotency before side effects):**

```text
on POST /webhooks/orders:
  parse JSON → ev = body.event_id
  BEGIN TRANSACTION
    INSERT INTO processed_webhook_events (event_id)
      VALUES (ev)
      ON CONFLICT (event_id) DO NOTHING           -- dialect varies: upsert / unique constraint
    IF inserted_or_conflict_means_already_done:
       COMMIT ; RETURN 200                       -- replay: harmless
    APPLY business change (same tx if possible): -- e.g. upsert order by partner_order_id
      INSERT INTO orders (...) ON CONFLICT (partner_order_id) DO UPDATE ...
  COMMIT
  RETURN 200
```

**Takeaways:**

- **Verify signatures** where the integration provides them—before you trust payloads or enqueue work (**[integration hardening](../../checklists/integration-hardening.md)**).
- Return **success only after** you have durably expressed “this **`event_id`** is handled” or applied an equivalent **business-key upsert**.
- Slow work (**PDFs, ML, third-party chaining**) belongs in **async jobs** keyed by the same **`event_id`** or business id—the HTTP handler acknowledges **intent recorded**, not “world finished.”

### Event-driven integration

**Basic:** An **event** announces that something already happened (“OrderPlaced”, “InvoicePaid”). A **command** asks something to happen (“ChargeCustomer”). Integration platforms (Boomi, n8n, custom buses) chain **steps** that react to events or commands. Your code mirrors this with **webhooks → queue → worker**.

**Events vs commands (failure modes):**

- **Events** are often **immutable facts**—consumers must tolerate **duplicate delivery** and **out-of-order** arrival when multiple partitions or retries exist. Design **idempotent** handlers keyed by `event_id` or business natural key.
- **Commands** imply **intent**—duplicates can **double-charge** if you only check HTTP success. Use **idempotency keys**, unique constraints, or “insert processed_commands first” patterns like the webhook example above.

**Outbox pattern (one paragraph):** When you must **write DB state and publish a message atomically**, write both intent to an **outbox table** in the same transaction; a separate **relay process** publishes to the queue. Failure mode without outbox: DB commits, message never sent—or message sent, DB rolls back—partners see inconsistent worlds.

**Saga (one paragraph):** A **long-running business process** split into **local transactions** with **compensating steps** (cancel shipment if payment fails). Failure mode: you compensate late or skip compensation—money and inventory diverge. Prefer explicit saga state machine or workflow engine when steps cross teams; do not hide saga logic in ad-hoc nested callbacks.

**Playbook mapping:** [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) (ingress) → [Project 6](../../career-project-specs/06-async-worker-stretch.md) (durable steps) → [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) (concurrent workers). Vocabulary: [integration-automation stack map](integration-automation.md).

---

## REST

**Basic:** Resources identified by URIs; **stateless** server between requests (session state externalized). Uses HTTP semantics.

**Intermediate:** **OpenAPI** documents contracts. **Pagination** (`cursor`), **filtering**, **errors** with stable problem formats (e.g. RFC 7807 style).

---

## SOAP and WS-style services

**Basic:** **XML** payloads, often **WSDL** for contract; strong tooling in some enterprises; **verbose** on the wire.

**Intermediate:** **REST vs SOAP** tradeoffs: SOAP has **WS-* standards** (security, transactions) in heavy integrations; REST often easier for browsers and mobile JSON.

| | REST (typical JSON API) | SOAP |
|---|-------------------------|------|
| Format | JSON common | XML |
| Contract | OpenAPI common | WSDL |
| Transport | HTTP | HTTP + SOAP envelope |

---

## OData

**Basic:** **OData** exposes entity sets with uniform query options (`$filter`, `$orderby`, `$expand`) over HTTP—good for **readable** data APIs behind Power BI / Excel-like clients.

**Intermediate:** Contrast with **hand-crafted REST query params** and **GraphQL** (client-shaped fields vs server-driven OData model).

---

## GraphQL, gRPC, and webhooks

| Style | Notes |
|-------|--------|
| **GraphQL** | Client selects fields; watch **N+1** query issues and resolvers performance |
| **gRPC** | HTTP/2, protobuf, strong typing; common **service-to-service** |
| **Webhooks** | Server pushes to your URL—verify **signatures**, handle **retries** idempotently |

#### GraphQL, gRPC, webhooks (going deeper)

- **GraphQL** — Clients request exactly the fields they need; the cost is **resolver** performance and **N+1** database access unless you batch/dataloader. Schema evolution and auth live in the graph layer.
- **gRPC** — **Protobuf** contracts, HTTP/2, strong typing—excellent **service-to-service** on internal networks; browsers need a gateway (gRPC-Web) for typical web apps. Hands-on stretch: [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md); career context: [Messaging and RPC](messaging-and-rpc.md).
- **Webhooks** — Outbound HTTP callbacks; treat every delivery as **at-least-once**—verify **HMAC signatures**, respond quickly (queue work), and make handlers **idempotent** on event IDs.

**Optional:** **SSE** for one-way server streams; **WebSockets** for bidirectional—see [Servers and networking](servers-and-networking.md).

---

## Testing

```mermaid
flowchart TB
  unit[Unit_tests]
  integ[Integration]
  e2e[E2E]

  unit --> integ --> e2e
```

**Pyramid:** Many **unit** tests (fast, narrow), fewer **integration** (DB, HTTP), few **E2E** (slow, brittle if overused).

**Test doubles:** **Fake** working implementation; **stub** canned answers; **mock** asserts calls.

#### Testing layers (going deeper)

- **Unit** — One module or function, **no** real DB/network; failures pinpoint logic bugs quickly—mock only when necessary (over-mocking couples tests to implementation).
- **Integration** — Real **DB**, queue, or HTTP to a test container; catches SQL, migrations, and wiring issues—slower but closer to production.
- **E2E** — Full stack through UI or public API; highest confidence, slowest and **flakiest**—reserve for critical paths and smoke suites.

**Intermediate:** **Flaky tests** erode trust—quarantine, fix or delete.

For **lab-by-lab** emphasis (which layers to use per initiative, optional AI prompt patterns), see [Per-project testing (labs + AI)](per-project-testing.md).

When behavior in prod or CI disagrees with what you thought you shipped, use a tight **debugging loop** before you only add more tests—see **[Debugging (workflow)](#debugging-workflow)**. After you understand the failure, **lock the fix** with a regression test so the failure mode stays visible.

---

## Debugging (workflow)

**Basic:** **Debugging** means shrinking the gap between **expected** and **actual** behavior—not guessing, and not changing three things at once. A workable loop: **reproduce** (same inputs, same environment class) → **shrink** the case (smallest command, smallest data) → **hypothesis** → **one** cheap **experiment** (breakpoint, log line, assertion in a test, trace filter, SQL plan) → confirm or falsify → repeat.

**Intermediate:**

- **Local vs production:** A **debugger** (step, inspect stack and locals) shines when control flow or invariants are wrong in code you can run. **Structured logs** and **traces** shine when the bug is timing, concurrency, or multi-service—often you cannot attach a debugger to production; treat **[Observability: logs, metrics, traces](#observability-logs-metrics-traces)** as the default production tool and narrow locally once you can reproduce.

- **Binary search:** **`git bisect`** (or equivalent) between known-good and known-bad commits when a regression appears and the diff space is large.

- **Safety net:** After you find root cause, add or extend **[Testing](#testing)** so the same class of bug fails fast next time (unit or integration, whichever catches the boundary you fixed).

**Not the same as testing:** **Tests** assert intent up front; **debugging** explains a mismatch after failure. They meet at the regression test.

---

## CI/CD and delivery

**Pipeline:** lint → test → build → artifact → deploy to envs.

**Patterns:** **Blue/green** and **canary** reduce blast radius. **Feature flags** decouple deploy from release.

**12-factor app (basics):** One codebase; **config in environment**; **stateless processes**; **logs as streams**; **admin tasks as one-off processes**.

---

## Versioning and compatibility

**SemVer:** MAJOR.MINOR.PATCH—**breaking** API changes bump major when consumers rely on semver.

**API versioning:** URL (`/v1/`) vs header—team convention matters.

---

## Code review and documentation

**Good review:** Precise, kind, teaches **why**. Small PRs review faster with higher quality.

**ADRs:** Record significant architecture decisions—**context, decision, consequences**.

---

## Observability: logs, metrics, traces

| Signal | Use when… |
|--------|------------|
| **Logs** | Discrete events, debugging narratives |
| **Metrics** | Rates, histograms, SLIs (request latency percentiles) |
| **Traces** | Latency across services—**distributed tracing** IDs |

#### Observability signals (going deeper)

- **Logs** — Human-readable **events** with timestamps; best for “what happened to this request ID?” when fields are structured (**JSON**) and levels are used consistently.
- **Metrics** — Cheap **aggregates** (rates, percentiles, counters); ideal for dashboards and alerting—**cardinality** explosion (unique label per user) breaks many systems.
- **Traces** — **Spans** linked across services show where latency hides; requires **instrumentation** (OpenTelemetry) and sampling at scale.

**SLI / SLO / SLA:** SLI = measurement; **SLO** = internal target; **SLA** = customer-facing promise with consequences.

Signals tell you **where** time went or **which** request failed; they rarely replace thinking through **why** application logic is wrong—narrow with correlation IDs and traces, then reproduce locally and use **[Debugging (workflow)](#debugging-workflow)** when you need stepping or smaller reproducers.

For the **measure → profile → fix → verify** workflow (latency, throughput, memory), see [Memory and performance](memory-and-performance.md).

---

## Security for applications

**OWASP-style categories to recognize:** **Injection**, **broken authentication**, **sensitive data exposure**, **XXE**, **broken access control**, **security misconfiguration**, **XSS**, **insecure deserialization**, **known vulnerable components**, **insufficient logging**, **SSRF**.

**Authn vs authz:** **who you are** vs **what you may do**.

**Supply chain:** lockfiles, **Dependabot**, review upgrades; **pin CI actions** to SHAs if policy requires.

**SAST/DAST:** static vs dynamic testing—**shift-left** reduces cost of defects.

**Intermediate:** **CSRF** for cookie sessions; **CORS** is not authorization.

---

## Cross-language concepts and gotchas

Syntax fundamentals (variables, functions, classes, collections, errors, nulls, async) live in one place: **[Language fundamentals comparison](../languages/language-fundamentals-comparison.md)**. Use that doc for side-by-side snippets across JavaScript, TypeScript, PHP, Go, Rust, C#, Java, Kotlin, and Swift.

This handbook file keeps **delivery-shaped** topics (integration, observability, concurrency under load). For equality/`===` vs PHP `==`, truthiness, and async spelling, see the comparison doc—especially [Null, optionals, equality, and truthiness](../languages/language-fundamentals-comparison.md#null-optionals-equality-and-truthiness) and [Async and concurrency (fundamentals)](../languages/language-fundamentals-comparison.md#async-and-concurrency-fundamentals). For **mentor-depth** explanations of the 20 core-stack tripwires (why, production bugs, senior habits), see [Language gotchas deep dive](../languages/language-gotchas-deep-dive.md).

---

## Data structures and algorithms

For complexity, core structures, pattern recognition, and interview flow, use the dedicated handbook note—**[Algorithms and data structures](algorithms-and-data-structures.md)**—so this file stays a breadth index. You still want Big-O vocabulary for reviews and screens even when libraries (or generated code) implement the details.

---

## Concurrency basics

**Processes** run in **separate memory**; **threads** inside one process share memory—without rules, **data races** (two writers, one reader without synchronization) corrupt state. Prefer **immutable data**, **message passing**, or **documented locking** over ad-hoc shared mutable heaps.

### UI threads and “don't block the main path”

**Basic:** Interactive apps (desktop, mobile, browser) expose a **main** or **UI thread** users feel as “the app responding.” Long **CPU work**, blocking **disk**, or naive **network** calls on that path cause **freezes**. Move heavy work to **background threads**, **worker pools**, or **async awaits** **that do not stall** the UI (exact API depends on framework—Swift **MainActor**, Android **Dispatchers**, browser **workers**, …).

**Intermediate:** Backend services less often have a literal “main thread,” but they still have **scarce resources**: **bounded thread pools**, **event loops**, **DB pool connections**. **Blocking** inside an async-only stack (FastAPI/asyncio; Node)—or **blocking the UI thread on mobile**—are the same **class** of mistake: starvation under load.

### Concurrency on your core stack

| Runtime | Model | Typical mistake |
|---------|--------|-----------------|
| **PHP (FPM)** | One request ≈ one worker process; memory resets | Long CPU work in webhook handler → partner retries flood you |
| **Node / TS** | Single-threaded event loop + thread pool for some I/O | Blocking sync file/DB call stalls all requests |
| **Python (asyncio)** | Event loop + `async def` | Calling blocking libraries without `to_thread` / executor |
| **Go** | Goroutines + channels + `context` | Unbounded `go handler()` per message → memory spike |

**Go worker guidance:** bound concurrency with a **worker pool** or **semaphore**; propagate **context cancel** from HTTP timeout or job deadline. See [Go stack map](../languages/go.md) and [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md). For heap growth, profiling, and backpressure patterns, see [Memory and performance](memory-and-performance.md).

**Where each language expresses async:** [Language fundamentals comparison — Async](../languages/language-fundamentals-comparison.md#async-and-concurrency-fundamentals).

---

## Internationalization and encoding

Store text as **UTF-8**. Separate **locale** from **language**; never assume single-byte encodings for user text.

---

## Licenses (developer awareness)

**Permissive** (MIT, Apache): few obligations. **Copyleft** (GPL): share-alike obligations on distribution—**not legal advice**; involve counsel for products.

---

## Interview checklist

- Name and motivate **SOLID** (one sentence each).
- **DDD** vocabulary: bounded context, aggregate, value object vs entity; **Clean/Onion** Dependency Rule.
- **CQRS** vs **event sourcing**; when each is overkill.
- One **anti-pattern** you have removed and how ([Anti-patterns](#anti-patterns-what-not-to-do)).
- **REST vs SOAP** at a high level.
- **Idempotency** and HTTP methods.
- **Testing pyramid**; difference **mock** vs **fake**.
- **Microservices** vs **monolith** tradeoffs.
- **Observability** three pillars; **SLI vs SLO**.
- **OWASP** top-level categories you have mitigated in code.
- **Big-O** of a nested loop; when **hash map** helps ([Algorithms and data structures](algorithms-and-data-structures.md)).
- One **cross-language** bug (e.g. `==` in PHP vs `===` — [comparison doc](../languages/language-fundamentals-comparison.md#null-optionals-equality-and-truthiness)).
