# Software engineering glossary (A–Z)

Short, **beginner-friendly** definitions for words you will hear in code reviews, interviews, and docs. For depth, follow the **See also** links into the [Software engineering handbook](software-engineering.md).

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

### At-least-once delivery

**Beginner:** A messaging guarantee: a message might arrive **more than once** (retries are common), so your handler must not break if it sees a duplicate—usually by **idempotency** or **deduplication**.

**See also:** [Integration: sync, async, and messaging](software-engineering.md#integration-sync-async-and-messaging)

### Authentication (Authn) vs authorization (Authz)

**Beginner:** **Authentication** answers “who are you?” (login, tokens). **Authorization** answers “what are you allowed to do?” (roles, permissions). Mixing them up causes security bugs.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

---

## B

### Backoff (exponential)

**Beginner:** When retries wait longer each time (for example 1s, 2s, 4s) so a struggling service gets relief instead of a stampede of requests.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Big-O notation

**Beginner:** A shorthand for how work grows as input size grows—for example “O(n)” means roughly proportional to n. Used to compare algorithms at a high level.

**See also:** [Algorithms and data structures](algorithms-and-data-structures.md)

### Blue-green deployment

**Beginner:** Running two production environments (“blue” and “green”); you switch traffic to the new version so you can roll back quickly by switching back.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

---

## C

### Canary deployment

**Beginner:** Sending a **small slice** of real traffic to a new version first. If metrics look good, you increase the slice; if not, you stop before everyone is affected.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### CI/CD (Continuous Integration / Continuous Delivery or Deployment)

**Beginner:** **CI** means frequently merging work and automatically building and testing it. **CD** means keeping the app in a **releasable** state (Delivery) or automatically shipping it (Deployment), depending on team setup.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Circuit breaker

**Beginner:** A pattern that **stops calling** a failing dependency for a while so your service fails fast instead of piling up waiting requests.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Code review

**Beginner:** A teammate reads your change before it merges to catch bugs, share knowledge, and align on style and design.

**See also:** [Code review and documentation](software-engineering.md#code-review-and-documentation)

### CORS (Cross-Origin Resource Sharing)

**Beginner:** Browser rules for whether a web page on one origin may read responses from another. **CORS is not a substitute for real authorization** on the server.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### CQRS (Command Query Responsibility Segregation)

**Beginner:** Splitting **writes** (commands) from **reads** (queries), sometimes with different models or databases for each. Useful at scale; overkill for tiny CRUD apps.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

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

### Dependency injection

**Beginner:** Passing dependencies (like a database client or clock) **into** a component from outside instead of creating them inside—makes code easier to test and swap.

**See also:** [SOLID — dependency inversion](software-engineering.md#solid)

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

### Exactly-once (and why people say “effectively-once”)

**Beginner:** Marketing often promises **exactly-once** delivery; in distributed systems you usually implement **at-least-once** delivery plus **idempotent** handling so duplicates do not cause extra side effects.

**See also:** [Message queues and delivery semantics](software-engineering.md#message-queues-and-delivery-semantics)

---

## F

### Factory (pattern)

**Beginner:** A central place to **create** objects so construction rules stay consistent and callers do not scatter `new` everywhere.

**See also:** [Design patterns](software-engineering.md#design-patterns-gof-style-survey)

### Feature flag

**Beginner:** A switch that turns code paths on/off **without deploying again**—useful for gradual rollouts or hiding unfinished work.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

---

## G

### GraphQL

**Beginner:** An API style where clients ask for specific **fields** in one query. Flexible for clients; servers must watch performance (for example resolver **N+1** issues).

**See also:** [GraphQL, gRPC, and webhooks](software-engineering.md#graphql-grpc-and-webhooks)

### gRPC

**Beginner:** A high-performance **RPC** framework (often protobuf + HTTP/2) common for **service-to-service** calls inside a backend.

**See also:** [GraphQL, gRPC, and webhooks](software-engineering.md#graphql-grpc-and-webhooks)

---

## H

### Hexagonal architecture (ports and adapters)

**Beginner:** Keep **domain logic** in the middle; put HTTP, databases, and queues on the **outside** as adapters. Makes swapping infrastructure easier.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

---

## I

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

### JSON (JavaScript Object Notation)

**Beginner:** A common text format for APIs—structured like objects and arrays. Despite the name it is language-agnostic.

**See also:** [REST](software-engineering.md#rest)

---

## K

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

### OWASP

**Beginner:** A well-known catalogue of common **web application risks**—useful checklist language for XSS, injection, broken access control, and more.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

---

## P

### Pagination (cursor / offset)

**Beginner:** Returning large lists in **chunks**. **Offset** pages can drift if data changes; **cursor** pagination is often more stable for APIs.

**See also:** [REST](software-engineering.md#rest)

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

### REST

**Beginner:** A common style for HTTP APIs: **resources** at URLs, using HTTP methods (GET, POST, …) and status codes with meaning. Often paired with JSON.

**See also:** [REST](software-engineering.md#rest)

### Retry

**Beginner:** Trying a failed operation again—must pair with **timeouts**, **backoff**, and **idempotency** for mutating calls.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

---

## S

### SAST (Static Application Security Testing)

**Beginner:** Security scanning of **source code** (and sometimes configs) without executing the app—finds classes of bugs early (“shift left”).

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### SemVer (semantic versioning)

**Beginner:** Version numbers like `MAJOR.MINOR.PATCH`—bump **major** when you break compatibility for consumers who rely on the contract.

**See also:** [Versioning and compatibility](software-engineering.md#versioning-and-compatibility)

### SLA / SLO / SLI

**Beginner:** **SLI** = what you measure (latency, errors). **SLO** = internal target (“99.9% under 300ms”). **SLA** = customer-facing promise with consequences.

**See also:** [Observability — SLI / SLO / SLA](software-engineering.md#observability-logs-metrics-traces)

### SOAP

**Beginner:** An older **XML-heavy** style of web services, still common in some enterprises; compared often with **REST** + JSON.

**See also:** [SOAP and WS-style services](software-engineering.md#soap-and-ws-style-services)

### Stateless (service)

**Beginner:** The server does not rely on **in-memory session** tied to one machine between requests; session data lives in a store or token so any instance can handle the next request.

**See also:** [REST — stateless](software-engineering.md#rest); [12-factor](software-engineering.md#cicd-and-delivery)

---

## T

### Technical debt

**Beginner:** Work you **postpone** (often for speed) that carries ongoing cost—like financial debt, interest compounds until you pay it down.

**See also:** [Complexity, change, and technical debt](software-engineering.md#complexity-change-and-technical-debt)

### Timeout

**Beginner:** A limit on how long to wait for an I/O call. Without timeouts, slow dependencies can **pile up** threads or connections and take down your service.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Trace (distributed tracing)

**Beginner:** A tree of **spans** showing how a request moved through services—essential for finding latency in microservice setups.

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

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
