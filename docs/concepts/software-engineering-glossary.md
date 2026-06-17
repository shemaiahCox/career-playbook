# Software engineering glossary (A–Z)

Short, **beginner-friendly** definitions for words you will hear in code reviews, interviews, and docs. For depth, follow the **See also** links into the [Software engineering handbook](software-engineering.md).

**Heard in a project spec and stuck?** This glossary covers playbook-heavy jargon (backpressure, hot path, p95, BFF, reconcile loop, …). Lifecycle context: [SDLC ↔ playbook map](sdlc-playbook-map.md).

**Related:** stack-specific blurbs live in [Stacks glossary](../languages/glossary.md) (links into ecosystem maps).

---

## Jump to letter

[A](#a) · [B](#b) · [C](#c) · [D](#d) · [E](#e) · [F](#f) · [G](#g) · [H](#h) · [I](#i) · [J](#j) · [K](#k) · [L](#l) · [M](#m) · [N](#n) · [O](#o) · [P](#p) · [Q](#q) · [R](#r) · [S](#s) · [T](#t) · [U](#u) · [V](#v) · [W](#w) · [X](#x) · [Y](#y) · [Z](#z)

---

## A

### ACID (databases)

**Beginner:** A checklist for safe database transactions: **A**tomicity (all steps succeed or none do), **C**onsistency (rules stay true), **I**solation (transactions do not step on each other’s half-finished work), **D**urability (committed data survives crashes). You will hear “ACID” when people talk about reliability of money-like updates.

**See also:** [Database design](database-design.md)

### ADR (Architecture Decision Record)

**Beginner:** A short write-up of an important technical choice: what you decided, why, and what you expect to trade off. It helps future you (and teammates) avoid re-litigating the same debate.

**See also:** [Code review and documentation — ADRs](software-engineering.md#code-review-and-documentation)

### API (Application Programming Interface)

**Beginner:** A **contract** for how software talks to other software—often over HTTP (JSON), but also libraries inside one app. If you “expose an API,” other code can call your functions or endpoints in the way you document.

**See also:** [REST](software-engineering.md#rest)

### Adapter (pattern)

**Beginner:** A small layer that translates one interface into another so two pieces of code can work together without rewriting either side—like a travel plug adapter.

**See also:** [Design patterns](software-engineering.md#design-patterns-gof-style-survey)

### Anti-pattern

**Beginner:** A common "solution" that looks reasonable but reliably causes pain (god object, anemic domain, premature microservices, N+1 queries). Recognizing them by name is half the fix—but most are context-dependent, so name the tradeoff rather than cargo-culting the rule.

**See also:** [Anti-patterns (what NOT to do)](software-engineering.md#anti-patterns-what-not-to-do)

### At-least-once delivery

**Beginner:** A messaging guarantee: a message might arrive **more than once** (retries are common), so your handler must not break if it sees a duplicate—usually by **idempotency** or **deduplication**.

**See also:** [Integration: sync, async, and messaging](software-engineering.md#integration-sync-async-and-messaging)

### At-most-once delivery

**Beginner:** A messaging guarantee: a message is processed **zero or one** time—**loss** is possible if the consumer crashes after work but before ack. Fine only when missing an event is acceptable (telemetry, best-effort cache warm).

**See also:** [Message queues and delivery semantics](software-engineering.md#message-queues-and-delivery-semantics)

### Authentication (Authn) vs authorization (Authz)

**Beginner:** **Authentication** answers “who are you?” (login, tokens). **Authorization** answers “what are you allowed to do?” (roles, permissions). Mixing them up causes security bugs.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

---

## B

### Backoff (exponential)

**Beginner:** When retries wait longer each time (for example 1s, 2s, 4s) so a struggling service gets relief instead of a stampede of requests.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Backpressure

**Beginner:** When a **slow consumer** signals upstream to **slow down or drop** work instead of buffering forever—unbounded queues or DOM updates cause memory blow-ups and latency cliffs.

**See also:** [Memory and performance](memory-and-performance.md); [Project 8 — Go worker](../../career-project-specs/08-go-retrieval-worker-lab.md); [Project 13 — Real-time dashboard](../../career-project-specs/13-realtime-dashboard-lab.md)

### BFF (Backend for Frontend)

**Beginner:** A **thin server** tailored to one UI: it calls backend services, holds secrets, and shapes responses—so the browser never stores API keys or talks to every microservice directly.

**See also:** [Project 11 — LLM web app](../../career-project-specs/11-llm-web-app-lab.md)

### Big-O notation

**Beginner:** A shorthand for how work grows as input size grows—for example “O(n)” means roughly proportional to n. Used to compare algorithms at a high level.

**See also:** [Algorithms and data structures](algorithms-and-data-structures.md)

### Blue-green deployment

**Beginner:** Running two production environments (“blue” and “green”); you switch traffic to the new version so you can roll back quickly by switching back.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Blast radius

**Beginner:** How much of the system or how many users break if a change fails—**canary** deploys and **feature flags** shrink blast radius.

**See also:** [Canary deployment](#canary-deployment); [Feature flag](#feature-flag)

### Bounded concurrency / worker pool

**Beginner:** A **fixed cap** on how many jobs or requests run at once (pool, semaphore, max workers)—prevents unbounded goroutines or threads from exhausting memory under load.

**See also:** [Concurrency basics](software-engineering.md#concurrency-basics); [Project 8 — Go worker](../../career-project-specs/08-go-retrieval-worker-lab.md)

---

## C

### Canary deployment

**Beginner:** Sending a **small slice** of real traffic to a new version first. If metrics look good, you increase the slice; if not, you stop before everyone is affected.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Cardinality (metrics)

**Beginner:** The number of **distinct label values** on a metric—for example one time series per user id. **High cardinality** (millions of unique labels) breaks many metrics systems and dashboards.

**See also:** [Observability — metrics](software-engineering.md#observability-logs-metrics-traces)

### CI/CD (Continuous Integration / Continuous Delivery or Deployment)

**Beginner:** **CI** means frequently merging work and automatically building and testing it. **CD** means keeping the app in a **releasable** state (Delivery) or automatically shipping it (Deployment), depending on team setup.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Circuit breaker

**Beginner:** A pattern that **stops calling** a failing dependency for a while so your service fails fast instead of piling up waiting requests.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Code review

**Beginner:** A teammate reads your change before it merges to catch bugs, share knowledge, and align on style and design.

**See also:** [Code review and documentation](software-engineering.md#code-review-and-documentation)

### Connection pooling

**Beginner:** **Reusing** open database or HTTP connections instead of opening a new one per request—faster, but **pool exhaustion** looks like latency even when SQL is fine.

**See also:** [Project 18 — Proxy / load balancer](../../career-project-specs/18-proxy-load-balancer-lab.md); [Memory and performance](memory-and-performance.md)

### Correlation ID / request_id

**Beginner:** A unique id attached to **one request or business event** and copied into every log and downstream call—so you can grep or trace one failure across services.

**See also:** [Project 3 — Observability](../../career-project-specs/03-observability-lab.md); [Production readiness](../../checklists/production-readiness.md)

### CORS (Cross-Origin Resource Sharing)

**Beginner:** Browser rules for whether a web page on one origin may read responses from another. **CORS is not a substitute for real authorization** on the server.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### Clean / Onion architecture

**Beginner:** Concentric layers (entities → use cases → interface adapters → frameworks) governed by the **Dependency Rule**: source-code dependencies point **only inward**, so the domain never imports the web framework or database. Same instinct as hexagonal/ports-adapters; easy to over-engineer for small apps.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns); [Hexagonal architecture](#hexagonal-architecture-ports-and-adapters)

### CQRS (Command Query Responsibility Segregation)

**Beginner:** Splitting **writes** (commands) from **reads** (queries), sometimes with different models or databases for each. Useful at scale; overkill for tiny CRUD apps. The read side is often updated asynchronously, so it is eventually consistent.

**See also:** [CQRS and Event Sourcing](software-engineering.md#cqrs-and-event-sourcing)

### CRD (Custom Resource Definition)

**Beginner:** A Kubernetes extension that adds **your own resource types** to the API (beyond built-in Deployments, Services, …)—often paired with a **controller** that reconciles desired state.

**See also:** [Project 17 — K8s controller](../../career-project-specs/17-k8s-controller-lab.md)

### CSRF (Cross-Site Request Forgery)

**Beginner:** An attack that tricks a **logged-in** user’s browser into submitting a request your site will accept (often with cookies). Defenses include tokens and same-site cookies.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

---

## D

### DAST (Dynamic Application Security Testing)

**Beginner:** Security testing that hits a **running** app (often black-box), looking for issues like misconfigurations or injectable inputs.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### Dead letter queue (DLQ)

**Beginner:** A holding area for messages that **failed processing** too many times so they do not block the main queue and can be inspected or replayed later.

**See also:** [Integration hardening](../../checklists/integration-hardening.md)

### Debugging

**Beginner:** Narrowing why the program’s **actual** behavior differs from what you expected—using reproduction, smaller cases, logs, traces, and tests.

**See also:** [Debugging (workflow)](software-engineering.md#debugging-workflow)

### Deduplication / dedupe

**Beginner:** Detecting and **ignoring duplicate** messages or requests—often via a stored idempotency key or unique constraint—so **at-least-once** delivery does not double-apply effects.

**See also:** [Idempotency](#idempotency); [Example: idempotent webhook](software-engineering.md#example-idempotent-webhook-or-job-consumer)

### Dependency injection

**Beginner:** Passing dependencies (like a database client or clock) **into** a component from outside instead of creating them inside—makes code easier to test and swap.

**See also:** [SOLID — dependency inversion](software-engineering.md#solid)

### DDD (Domain-Driven Design)

**Beginner:** Designing software around the **business domain** and a **ubiquitous language** shared with domain experts. Key terms: **bounded context** (a boundary where one model is consistent), **entity** (identity over time), **value object** (defined by attributes, immutable), **aggregate** (a consistency unit accessed through its **root**), and **domain event**. Powerful for complex domains; overkill for CRUD.

**See also:** [Domain-Driven Design (DDD)](software-engineering.md#domain-driven-design-ddd)

### DRY (Don’t Repeat Yourself)

**Beginner:** Each piece of knowledge should have **one clear home**; avoid copy-paste logic that will diverge. **Exception:** sometimes a little duplication is better than the wrong shared abstraction.

**See also:** [DRY and when duplication wins](software-engineering.md#dry-and-when-duplication-wins)

---

## E

### E2E (end-to-end) test

**Beginner:** A test that exercises the **whole system** (or most of it)—often through the UI or public API. High confidence but slower and can be flaky if overused.

**See also:** [Testing](software-engineering.md#testing)

### Encapsulation

**Beginner:** Hiding internal details behind a clear surface so outside code cannot accidentally break invariants—core to object-oriented design.

**See also:** [Programming paradigms](software-engineering.md#programming-paradigms)

### Event-driven architecture

**Beginner:** Components react to **events** (messages) instead of calling each other directly. Enables loose coupling but you must think about ordering, duplicates, and consistency.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

### Event sourcing

**Beginner:** Store the **append-only log of events** that produced state (`MoneyDeposited`, `MoneyWithdrawn`) rather than only the current row; rebuild state by **replaying** events, with **snapshots** to keep replay fast. Gives a perfect audit trail and temporal queries, at the cost of event versioning and replay complexity. Often paired with CQRS.

**See also:** [CQRS and Event Sourcing](software-engineering.md#cqrs-and-event-sourcing)

### Eventual consistency

**Beginner:** After a write, **reads may be stale for a while** before all replicas or consumers catch up—common in event-driven systems; design for it with idempotency and clear user expectations.

**See also:** [Architectural patterns — event-driven](software-engineering.md#architectural-patterns)

### Eval / eval regression

**Beginner:** A **fixed test set** (often JSONL) of prompts and expected behaviors for an LLM/RAG feature—re-run after model or prompt changes to catch **answer drift** before production.

**See also:** [Project 2 — RAG / LLM service](../../career-project-specs/02-rag-llm-service.md); [LLM feature ship checklist](../../checklists/llm-feature-ship.md)

### Exactly-once (and why people say “effectively-once”)

**Beginner:** Marketing often promises **exactly-once** delivery; in distributed systems you usually implement **at-least-once** delivery plus **idempotent** handling so duplicates do not cause extra side effects.

**See also:** [Message queues and delivery semantics](software-engineering.md#message-queues-and-delivery-semantics)

---

## F

### Factory (pattern)

**Beginner:** A central place to **create** objects so construction rules stay consistent and callers do not scatter `new` everywhere.

**See also:** [Design patterns](software-engineering.md#design-patterns-gof-style-survey)

### Fake (test double)

**Beginner:** A test double with a **working in-memory implementation** (fake database, fake clock)—prefer over mocks when you need realistic behavior without real I/O.

**See also:** [Testing — doubles](software-engineering.md#testing)

### Fast ack

**Beginner:** Responding **HTTP 2xx quickly** on webhooks or ingress while **slow work** runs in a queue—partners time out and retry if you block on PDFs, ML, or long chains.

**See also:** [Example: idempotent webhook](software-engineering.md#example-idempotent-webhook-or-job-consumer); [Project 1 — Webhook receiver](../../career-project-specs/01-integration-webhook-receiver.md)

### Feature flag

**Beginner:** A switch that turns code paths on/off **without deploying again**—useful for gradual rollouts or hiding unfinished work.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Fan-out

**Beginner:** One incoming event or request triggers **many downstream** calls or notifications—watch for latency, partial failure, and need for idempotency on each branch.

**See also:** [Project 24 — Notification fanout](../../career-project-specs/24-notification-fanout-lab.md)

---

## G

### Graceful shutdown

**Beginner:** On deploy or SIGTERM, **stop accepting new work**, **finish or time out in-flight** requests, then exit—avoids cutting clients mid-request.

**See also:** [Project 18 — Proxy / load balancer](../../career-project-specs/18-proxy-load-balancer-lab.md)

### GraphQL

**Beginner:** An API style where clients ask for specific **fields** in one query. Flexible for clients; servers must watch performance (for example resolver **N+1** issues).

**See also:** [GraphQL, gRPC, and webhooks](software-engineering.md#graphql-grpc-and-webhooks)

### gRPC

**Beginner:** A high-performance **RPC** framework (often protobuf + HTTP/2) common for **service-to-service** calls inside a backend.

**See also:** [GraphQL, gRPC, and webhooks](software-engineering.md#graphql-grpc-and-webhooks)

### Guardrails (LLM)

**Beginner:** Policy limits on model behavior—citations required, refusals on sensitive topics, output filters—so AI features fail safely instead of hallucinating confidently.

**See also:** [Project 2 — RAG / LLM service](../../career-project-specs/02-rag-llm-service.md); [LLMs handbook](llms.md)

---

## H

### HMAC

**Beginner:** A **cryptographic signature** over a message (often webhook raw body + shared secret)—proves the sender knew the secret; verify **before** trusting payload or enqueueing work.

**See also:** [Integration hardening](../../checklists/integration-hardening.md); [Project 1 — Webhook receiver](../../career-project-specs/01-integration-webhook-receiver.md)

### Hot path

**Beginner:** Code that runs on **every request** or in the tight loop—optimize and measure **here first**; avoid heavy work, extra allocations, or blocking I/O on the hot path.

**See also:** [Memory and performance](memory-and-performance.md); [Project 19 — Rust hot-path](../../career-project-specs/19-rust-hot-path-lab.md)

### Hexagonal architecture (ports and adapters)

**Beginner:** Keep **domain logic** in the middle; put HTTP, databases, and queues on the **outside** as adapters. Makes swapping infrastructure easier.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

---

## I

### I/O-bound vs CPU-bound

**Beginner:** **I/O-bound** work waits on network, disk, or DB (CPU idle); **CPU-bound** work is compute-heavy. Fix I/O with fewer round trips, pooling, async; fix CPU with algorithms, profiling, or moving work off the hot path.

**See also:** [Memory and performance](memory-and-performance.md)

### Idempotency

**Beginner:** Doing the same operation **twice** has the **same effect** as once—for example “set balance to $10” vs “add $10” (which is not naturally idempotent). Critical for retries and webhooks.

**See also:** [Example: idempotent webhook](software-engineering.md#example-idempotent-webhook-or-job-consumer)

### Integration test

**Beginner:** A test that uses **real** pieces working together—a database, HTTP server, queue—usually slower than unit tests but catches wiring issues.

**See also:** [Testing](software-engineering.md#testing)

### Injection (SQL injection)

**Beginner:** An attack where attacker-controlled input becomes part of a **database query**. Prevent with parameterized queries / ORMs used correctly—not string concatenation of SQL.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

---

## J

### Jitter

**Beginner:** **Random extra wait** added to retry backoff so many clients do not retry at the same instant—a **thundering herd** on a recovering service.

**See also:** [Backoff (exponential)](#backoff-exponential); [Sync HTTP callers](software-engineering.md#sync-http-callers)

### JSON (JavaScript Object Notation)

**Beginner:** A common text format for APIs—structured like objects and arrays. Despite the name it is language-agnostic.

**See also:** [REST](software-engineering.md#rest)

---

## K

### Keyset (cursor) pagination

**Beginner:** Paging with a **stable cursor** (last seen id/timestamp) instead of **offset** (`LIMIT 20 OFFSET 1000`)—avoids skipped or duplicate rows when data changes during paging.

**See also:** [Pagination (cursor / offset)](#pagination-cursor--offset); [Project 4 — SQL performance](../../career-project-specs/04-sql-performance-lab.md)

### Kubernetes (K8s)

**Beginner:** A **container orchestrator**: it schedules app containers across machines, restarts failed ones, exposes services, and scales replicas. You often meet it as **YAML** manifests and “pods / deployments / services” vocabulary.

**See also:** [Servers and networking](servers-and-networking.md)

---

## L

### Lint / linter

**Beginner:** A tool that statically checks code for style issues and common mistakes **without running** the full app.

**See also:** [CI/CD — pipeline](software-engineering.md#cicd-and-delivery)

### Load balancer

**Beginner:** A component that spreads incoming requests across multiple servers so one machine does not get overwhelmed.

**See also:** [Servers and networking](servers-and-networking.md)

### Liveness vs readiness

**Beginner:** **Liveness** = “is the process alive?” (restart if not). **Readiness** = “can this instance take traffic?” (remove from load balancer if DB is down). Both are common **health check** types.

**See also:** [Production readiness — health checks](../../checklists/production-readiness.md); [Project 16 — Cloud deploy](../../career-project-specs/16-cloud-deploy-lab.md)

---

## M

### Message queue

**Beginner:** A buffer that lets producers **enqueue** work and consumers **process** later—decouples “now” from “when we have capacity.”

**See also:** [Integration: sync, async, and messaging](software-engineering.md#integration-sync-async-and-messaging)

### Metrics

**Beginner:** Numeric measurements over time—request rates, latency percentiles, error counts—cheap to aggregate for dashboards and alerts.

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

### Microservices

**Beginner:** Many small independently deployable services instead of one big app (“monolith”). Tradeoff: operational and network complexity for team autonomy.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

### Mock (test double)

**Beginner:** A test double that records **whether** collaborators were called—and often **how**—so you assert interactions. Prefer **real or fake** collaborators when feasible; over-mocking couples tests to implementation.

**See also:** [Testing — doubles](software-engineering.md#testing)

### Modular monolith

**Beginner:** One deployable app with **clean internal modules/boundaries**—a pragmatic default before splitting into microservices.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

---

## N

### N+1 query problem

**Beginner:** A performance bug where code runs **one query per row** instead of fetching in bulk—for example loading 100 authors with 101 database round trips.

**See also:** [Database design — N+1](database-design.md#orms-and-the-n1-query-pattern)

---

## O

### Object-oriented programming (OOP)

**Beginner:** Organizing programs around **objects** with data and behavior, using ideas like encapsulation and polymorphism—not the only paradigm teams use day to day.

**See also:** [Programming paradigms](software-engineering.md#programming-paradigms)

### Observability

**Beginner:** How well you can understand a system’s insides from **outside signals**—mainly logs, metrics, and traces—with correlation across requests.

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

### OpenAPI

**Beginner:** A standard way to **describe REST-style HTTP APIs** (endpoints, request/response shapes) so humans and tools can agree on contracts.

**See also:** [REST](software-engineering.md#rest); [Contract-first API](../../career-project-specs/05-contract-first-api.md)

### OpenTelemetry

**Beginner:** A **vendor-neutral** standard (and libraries) for **traces, metrics, and logs**—one instrumentation style for many backends (Jaeger, Datadog, …).

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

### Outbox pattern

**Beginner:** Write **DB changes and an outbox row** in one transaction; a separate process publishes to the queue—avoids “DB committed but message never sent” (or the reverse).

**See also:** [Event-driven integration](software-engineering.md#event-driven-integration)

### OWASP

**Beginner:** A well-known catalogue of common **web application risks**—useful checklist language for XSS, injection, broken access control, and more.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

---

## P

### Pagination (cursor / offset)

**Beginner:** Returning large lists in **chunks**. **Offset** pages can drift if data changes; **cursor** pagination is often more stable for APIs.

**See also:** [REST](software-engineering.md#rest)

### p50 / p95 / p99 (latency percentiles)

**Beginner:** If **p95 latency is 300ms**, 95% of requests finished within 300ms—the **slow tail** (p99) is what SLOs and users often feel; **averages hide outliers**.

**See also:** [Memory and performance](memory-and-performance.md); [Project 3 — Observability](../../career-project-specs/03-observability-lab.md)

### Poison message

**Beginner:** A queue job that **always fails** (bad payload, bug)—after max retries it should land in a **DLQ** instead of blocking the queue forever.

**See also:** [Dead letter queue (DLQ)](#dead-letter-queue-dlq); [Project 6 — Async worker](../../career-project-specs/06-async-worker-stretch.md)

### Polymorphism

**Beginner:** Treating different concrete types through the **same interface**—callers depend on behavior, not the exact class.

**See also:** [SOLID — Liskov](software-engineering.md#solid)

### Process vs thread

**Beginner:** A **process** has its own memory space; **threads** inside one process share memory and need careful synchronization to avoid data races.

**See also:** [Concurrency basics](software-engineering.md#concurrency-basics)

---

## Q

### Queue (see message queue)

**Beginner:** Often means a **message queue**—work waiting for a consumer—or a **FIFO** data structure in algorithms.

**See also:** [Message queue](#message-queue)

---

## R

### Regression test

**Beginner:** A test that locks in a **fix** so the same bug cannot return unnoticed.

**See also:** [Debugging — safety net](software-engineering.md#debugging-workflow)

### RAG (Retrieval-Augmented Generation)

**Beginner:** **Retrieve** relevant documents from a store, then **generate** an answer with the model grounded in those chunks—reduces pure hallucination vs naked LLM prompts.

**See also:** [Project 2 — RAG / LLM service](../../career-project-specs/02-rag-llm-service.md); [LLMs handbook](llms.md)

### Rate limiting (429)

**Beginner:** Rejecting excess traffic with **HTTP 429 Too Many Requests** (often plus **Retry-After**)—protects your service and upstreams; per IP, tenant, or API key.

**See also:** [Project 23 — Rate limiter gateway](../../career-project-specs/23-rate-limiter-gateway-lab.md); [Production readiness — rate limits](../../checklists/production-readiness.md)

### Reconcile loop

**Beginner:** A control loop: **observe** current state → **diff** vs desired → **act** → **requeue** until stable—core of Kubernetes **controllers** and many operators.

**See also:** [Project 17 — K8s controller](../../career-project-specs/17-k8s-controller-lab.md)

### REST

**Beginner:** A common style for HTTP APIs: **resources** at URLs, using HTTP methods (GET, POST, …) and status codes with meaning. Often paired with JSON.

**See also:** [REST](software-engineering.md#rest)

### Retry

**Beginner:** Trying a failed operation again—must pair with **timeouts**, **backoff**, and **idempotency** for mutating calls.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Reverse proxy

**Beginner:** A server in front of your app that terminates TLS, routes paths, buffers slow clients, and may **load-balance** to multiple upstreams—nginx, Envoy, your Project 18 lab.

**See also:** [Project 18 — Proxy / load balancer](../../career-project-specs/18-proxy-load-balancer-lab.md); [Servers and networking](servers-and-networking.md)

---

## S

### SAST (Static Application Security Testing)

**Beginner:** Security scanning of **source code** (and sometimes configs) without executing the app—finds classes of bugs early (“shift left”).

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### Saga

**Beginner:** A **long business process** split into local steps with **compensating actions** (refund if shipment fails)—distributed transactions without one giant two-phase commit.

**See also:** [Event-driven integration — saga](software-engineering.md#event-driven-integration)

### SemVer (semantic versioning)

**Beginner:** Version numbers like `MAJOR.MINOR.PATCH`—bump **major** when you break compatibility for consumers who rely on the contract.

**See also:** [Versioning and compatibility](software-engineering.md#versioning-and-compatibility)

### SLA / SLO / SLI

**Beginner:** **SLI** = what you measure (latency, errors). **SLO** = internal target (“99.9% under 300ms”). **SLA** = customer-facing promise with consequences.

**See also:** [Observability — SLI / SLO / SLA](software-engineering.md#observability-logs-metrics-traces)

### Shift-left

**Beginner:** Catching defects **earlier** in the lifecycle (design, CI, SAST) when they are cheaper to fix than in production.

**See also:** [Security for applications — SAST/DAST](software-engineering.md#security-for-applications)

### Sliding window (rate limiting)

**Beginner:** Count requests in a **rolling time window**—smoother than a fixed window that resets abruptly at each minute boundary.

**See also:** [Project 23 — Rate limiter gateway](../../career-project-specs/23-rate-limiter-gateway-lab.md)

### SOAP

**Beginner:** An older **XML-heavy** style of web services, still common in some enterprises; compared often with **REST** + JSON.

**See also:** [SOAP and WS-style services](software-engineering.md#soap-and-ws-style-services)

### Stateless (service)

**Beginner:** The server does not rely on **in-memory session** tied to one machine between requests; session data lives in a store or token so any instance can handle the next request.

**See also:** [REST — stateless](software-engineering.md#rest); [12-factor](software-engineering.md#cicd-and-delivery)

### Stub (test double)

**Beginner:** A test double that returns **canned answers** without a full implementation—lighter than a fake; unlike a **mock**, it usually does not assert how it was called.

**See also:** [Testing — doubles](software-engineering.md#testing)

---

## T

### Technical debt

**Beginner:** Work you **postpone** (often for speed) that carries ongoing cost—like financial debt, interest compounds until you pay it down.

**See also:** [Complexity, change, and technical debt](software-engineering.md#complexity-change-and-technical-debt)

### Tail latency

**Beginner:** The **slow end** of your latency distribution (p95, p99)—often dominates user experience and SLO breaches even when the average looks fine.

**See also:** [p50 / p95 / p99](#p50--p95--p99-latency-percentiles)

### Thundering herd

**Beginner:** Many clients **retry at once** when a service recovers—overwhelming it again. **Jittered backoff** and **circuit breakers** reduce the stampede.

**See also:** [Jitter](#jitter); [Circuit breaker](#circuit-breaker)

### Timeout

**Beginner:** A limit on how long to wait for an I/O call. Without timeouts, slow dependencies can **pile up** threads or connections and take down your service.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Trace (distributed tracing)

**Beginner:** A tree of **spans** showing how a request moved through services—essential for finding latency in microservice setups.

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

### Token bucket (rate limiting)

**Beginner:** A rate limiter that **refills tokens** at a steady rate; each request spends a token—allows **controlled bursts** while capping average rate.

**See also:** [Project 23 — Rate limiter gateway](../../career-project-specs/23-rate-limiter-gateway-lab.md)

---

## U

### Unit test

**Beginner:** A fast, narrow test of one module or function, usually **without** real network or database—pinpoints logic bugs quickly.

**See also:** [Testing](software-engineering.md#testing)

### UTF-8

**Beginner:** The **encoding** you should usually use for text on the web and in modern systems—variable-width, supports many languages.

**See also:** [Internationalization and encoding](software-engineering.md#internationalization-and-encoding)

---

## V

### Versioning (API)

**Beginner:** How you signal **breaking changes**—for example `/v1/` in the URL or version headers—so clients can migrate safely.

**See also:** [Versioning and compatibility](software-engineering.md#versioning-and-compatibility)

---

## W

### Webhook

**Beginner:** An HTTP **callback** another system calls on your URL when something happens. Treat deliveries as **at-least-once**: verify **signatures**, respond quickly, process **idempotently**.

**See also:** [GraphQL, gRPC, and webhooks](software-engineering.md#graphql-grpc-and-webhooks)

### Worker

**Beginner:** A process that **pulls jobs** from a queue or scheduler and does slow work outside the request/response path.

**See also:** [Integration: sync, async, and messaging](software-engineering.md#integration-sync-async-and-messaging)

---

## X

### XSS (Cross-Site Scripting)

**Beginner:** Injecting **script** into pages other users see—often via unsanitized user input. Defenses include escaping, CSP, and safe templating.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### XML

**Beginner:** A verbose text format with tags; common in **SOAP** and some enterprise integrations; compared with **JSON** for REST.

**See also:** [SOAP and WS-style services](software-engineering.md#soap-and-ws-style-services)

---

## Y

### YAML

**Beginner:** A human-readable config format (indentation-based) often used for CI pipelines and Kubernetes manifests—watch indentation mistakes.

**See also:** [Command-line tooling](command-line-tooling.md)

---

## Z

### Zero-downtime deployment

**Beginner:** Shipping new versions **without** taking the service offline for users—often via **blue-green**, **canary**, or rolling updates.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)
