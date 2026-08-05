# Software engineering glossary (A–Z)

Short, **beginner-friendly** definitions for words you will hear in code reviews, interviews, and docs. For depth, follow the **See also** links into the [Software engineering handbook](software-engineering.md).

**Heard in a project spec and stuck?** This glossary covers playbook-heavy jargon (backpressure, hot path, p95, BFF, reconcile loop, …). Lifecycle context: [SDLC ↔ playbook map](sdlc-playbook-map.md).

**Related:** stack-specific blurbs live in [Stacks glossary](../languages/glossary.md) (links into ecosystem maps).

**Azure certification overlay:** [Azure index](#azure-index) — AZ-900 / AI-200 terms mapped to playbook projects; depth in [Azure cloud and AI](azure-cloud-and-ai.md) and [certification track](../career/azure-certification-track.md).

**Architecture checklist terms:** vocabulary from the [real-world architecture checklist](../../checklists/architecture-checklist.md)—[Conway's law](#conway's-law) (org fit), [strangler-fig](#strangler-fig-pattern) (legacy migration), [C4 model](#c4-model) (diagram levels), [NFR](#non-functional-requirements-nfr) (latency, scale, compliance), [error budget](#sla--slo--sli) (SLO tradeoffs with shipping).

---

## Jump to letter

[A](#a) · [B](#b) · [C](#c) · [D](#d) · [E](#e) · [F](#f) · [G](#g) · [H](#h) · [I](#i) · [J](#j) · [K](#k) · [L](#l) · [M](#m) · [N](#n) · [O](#o) · [P](#p) · [Q](#q) · [R](#r) · [S](#s) · [T](#t) · [U](#u) · [V](#v) · [W](#w) · [X](#x) · [Y](#y) · [Z](#z)

---

## A

### ACID (databases)

ACID is a checklist for safe database transactions. **A**tomicity means all steps succeed or none do. **C**onsistency means business rules stay true before and after the transaction. **I**solation keeps transactions from stepping on each other's half-finished work, and **D**urability means committed data survives crashes. You will hear "ACID" when people talk about the reliability of money-like updates.

**See also:** [Database design](database-design.md)

### ADR (Architecture Decision Record)

An ADR (Architecture Decision Record) is a short write-up of an important technical choice: what you decided, why, and what you expect to trade off. It captures context that is easy to lose once the debate ends. Future you and your teammates can read it instead of re-litigating the same argument months later.

**See also:** [Code review and documentation — ADRs](software-engineering.md#code-review-and-documentation)

### AsyncAPI

AsyncAPI is a machine-readable standard for describing event-driven APIs—topics, channels, payloads—similar to how OpenAPI describes HTTP endpoints. Teams use it for contract review between event producers and consumers. Pair AsyncAPI with schema registries or shared protobuf/JSON schemas when many services subscribe to the same events.

**See also:** [OpenAPI](#openapi); [Event-driven architecture](#event-driven-architecture); [Architecture checklist — API/event contract](../../checklists/architecture-checklist.md)

### API (Application Programming Interface)

An API (Application Programming Interface) is a contract for how software talks to other software—often over HTTP with JSON, but also through libraries inside one app. It defines what callers can request, what they get back, and what errors mean. If you "expose an API," other code can call your functions or endpoints in the way you document.

**See also:** [REST](software-engineering.md#rest)

### Application Insights

Application Insights is Azure's application performance monitoring (APM) service—it collects request traces, dependencies, exceptions, and custom metrics from your running app. It is the Azure name for the same observability story you practice with structured logs and `request_id` in the playbook.

**See also:** [Project 3 — Observability](../../career-project-specs/03-observability-lab.md); [Azure cloud and AI](azure-cloud-and-ai.md#observability)

### Adapter (pattern)

An adapter is a small layer that translates one interface into another so two pieces of code can work together without rewriting either side. Think of it like a travel plug adapter: each device keeps its own plug shape, and the adapter bridges the gap. You reach for this pattern when integrating a third-party library or legacy module whose API does not match what your code expects.

**See also:** [Design patterns](software-engineering.md#design-patterns-gof-style-survey)

### Anti-pattern

An anti-pattern is a common "solution" that looks reasonable but reliably causes pain—examples include a god object, anemic domain, premature microservices, and the N+1 query problem. Recognizing them by name is half the fix, but most are context-dependent. Name the tradeoff you are making rather than cargo-culting the rule.

**See also:** [Anti-patterns (what NOT to do)](software-engineering.md#anti-patterns-what-not-to-do)

### At-least-once delivery

At-least-once delivery is a messaging guarantee where a message might arrive more than once because retries are common. Your handler must not break if it sees a duplicate. The usual defenses are idempotency (same effect no matter how many times you process it) or deduplication (track and skip messages you have already handled).

**See also:** [Integration: sync, async, and messaging](software-engineering.md#integration-sync-async-and-messaging)

### At-most-once delivery

At-most-once delivery is a messaging guarantee where a message is processed zero or one time. Loss is possible if the consumer crashes after doing work but before acknowledging the message. This is fine only when missing an event is acceptable—telemetry, best-effort cache warming, and similar non-critical paths.

**See also:** [Message queues and delivery semantics](software-engineering.md#message-queues-and-delivery-semantics)

### Authentication (Authn) vs authorization (Authz)

Authentication (Authn) answers "who are you?"—login flows, tokens, and identity checks. Authorization (Authz) answers "what are you allowed to do?"—roles, permissions, and access rules. Mixing them up is a common source of security bugs, because knowing someone's identity does not tell you what they may change or read.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### Availability zone (Azure)

An availability zone is an isolated datacenter within an Azure region—power, networking, and cooling are separate from other zones. Deploying across zones improves resilience when one facility fails. For labs, a single zone in one region is usually enough; AZ-900 asks when you would use multiple zones.

**See also:** [Azure cloud and AI — hierarchy](azure-cloud-and-ai.md#subscription-and-resource-hierarchy)

### Azure Blob Storage

Azure Blob Storage is object storage for files, backups, and unstructured data—think S3-style buckets and blobs. Web apps store uploads and ML pipelines store datasets here. In the playbook spine you more often use Postgres rows and local files; Blob Storage is AZ-900 vocabulary and capstone-scale artifact storage.

**See also:** [Servers and networking — storage](servers-and-networking.md)

### Azure Container Apps

Azure Container Apps runs containerized HTTP services and workers without you managing a Kubernetes control plane. It fits [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) deploy stretches—same Docker image as Compose, with scale rules and optional scale-to-zero.

**See also:** [Project 16 — Cloud deploy](../../career-project-specs/16-cloud-deploy-lab.md); [Azure certification track](../career/azure-certification-track.md)

### Azure Database for PostgreSQL

Azure Database for PostgreSQL is managed Postgres—Microsoft patches, backs up, and hosts the server. The Flexible Server tier supports the **pgvector** extension for embedding search, mapping directly to [Project 4](../../career-project-specs/04-sql-performance-lab.md) and RAG storage in [Project 2](../../career-project-specs/02-rag-llm-service.md).

**See also:** [Database design — vectors](database-design.md#vector-databases-and-embeddings); [Azure cloud and AI — data](azure-cloud-and-ai.md#data-for-ai-workloads)

### Azure Event Grid

Azure Event Grid routes events when something happens—a blob upload, a subscription change—to HTTP handlers or other Azure services. It is push notification for cloud resources; compare webhook ingress in [Project 1](../../career-project-specs/01-integration-webhook-receiver.md).

**See also:** [Azure cloud and AI — messaging](azure-cloud-and-ai.md#messaging-and-events)

### Azure Functions

Azure Functions runs small pieces of code triggered by HTTP, queues, or timers—serverless with scale-to-zero. Use for one workflow step instead of a full container when [Project 10](../../career-project-specs/10-automation-bot-lab.md) stretch calls for minimal compute.

**See also:** [Azure cloud and AI — compute](azure-cloud-and-ai.md#compute-choices-for-playbook-labs)

### Azure Key Vault

Azure Key Vault stores secrets, keys, and certificates outside your repo. Apps read values at runtime—often via managed identity—so git holds `.env.example` names only, matching [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) secrets hygiene.

**See also:** [Azure cloud and AI — secrets](azure-cloud-and-ai.md#secrets-and-identity)

### Azure Kubernetes Service (AKS)

Azure Kubernetes Service (AKS) is managed Kubernetes—Microsoft runs the control plane; you deploy pods and services. Optional target for [Project 17](../../career-project-specs/17-k8s-controller-lab.md) when AI-200 covers AKS deploy and monitor.

**See also:** [Project 17 — K8s controller](../../career-project-specs/17-k8s-controller-lab.md)

### Azure Load Balancer

Azure Load Balancer distributes traffic across VMs or virtual machine scale sets at Layer 4 (TCP/UDP). Application Gateway adds Layer 7 HTTP routing and WAF. Playbook [Project 18](../../career-project-specs/18-proxy-load-balancer-lab.md) teaches timeout and pooling concepts you can name on AZ-900.

**See also:** [Project 18 — Proxy / load balancer](../../career-project-specs/18-proxy-load-balancer-lab.md)

### Azure Managed Redis

Azure Managed Redis is a hosted Redis-compatible service—for cache, pub/sub, streams, and vector search helpers in AI-200. Same mental model as local Redis in [Project 6](../../career-project-specs/06-async-worker-stretch.md) and [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md); document an ADR when switching brokers.

**See also:** [Messaging and RPC](messaging-and-rpc.md); [Azure cloud and AI — data](azure-cloud-and-ai.md#data-for-ai-workloads)

### Azure OpenAI

Azure OpenAI hosts OpenAI models (chat, embeddings) in your Azure subscription with enterprise controls and regional deployment. Swap the inference endpoint in [Project 2](../../career-project-specs/02-rag-llm-service.md) or [Project 11](../../career-project-specs/11-llm-web-app-lab.md)—keep eval JSONL and `POST /query` contract unchanged.

**See also:** [LLMs handbook](llms.md); [Project 2](../../career-project-specs/02-rag-llm-service.md)

### Azure Policy

Azure Policy enforces organizational rules on resources—for example allowed regions, required tags, or banned SKUs. It complements RBAC: RBAC says who can act; Policy says what configurations are allowed. Mention both in deploy ADRs for [Project 16](../../career-project-specs/16-cloud-deploy-lab.md).

**See also:** [Azure cloud and AI — hierarchy](azure-cloud-and-ai.md#subscription-and-resource-hierarchy)

### Azure RBAC

Azure RBAC (Role-Based Access Control) assigns roles like Owner, Contributor, or Reader on subscriptions, resource groups, or individual resources. Least privilege for CI deploy identities is a [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) portfolio talking point.

**See also:** [AZ-900 study guide](https://aka.ms/AZ900-StudyGuide); [Azure certification track](../career/azure-certification-track.md)

### Azure Service Bus

Azure Service Bus is a managed message broker with queues, topics, sessions, and dead-letter subqueues. It implements the same at-least-once + poison-message story as Redis or SQS in [Project 6](../../career-project-specs/06-async-worker-stretch.md)—idempotent handlers still required.

**See also:** [Messaging and RPC](messaging-and-rpc.md); [Project 6](../../career-project-specs/06-async-worker-stretch.md)

### Azure index

Quick jump to Azure overlay terms for [AZ-900](https://learn.microsoft.com/en-us/credentials/certifications/azure-fundamentals/) and [AI-200T00](https://learn.microsoft.com/en-us/training/courses/ai-200t00):

| Term | Entry |
|------|-------|
| Fundamentals | [Subscription (Azure)](#subscription-azure) · [Resource group (Azure)](#resource-group-azure) · [Availability zone](#availability-zone-azure) · [Azure RBAC](#azure-rbac) · [Azure Policy](#azure-policy) |
| Compute | [Azure Container Apps](#azure-container-apps) · [AKS](#azure-kubernetes-service-aks) · [Azure Functions](#azure-functions) |
| Data / AI | [Azure Database for PostgreSQL](#azure-database-for-postgresql) · [Azure Managed Redis](#azure-managed-redis) · [Azure OpenAI](#azure-openai) |
| Integration | [Azure Service Bus](#azure-service-bus) · [Azure Event Grid](#azure-event-grid) |
| Ops | [Azure Key Vault](#azure-key-vault) · [Managed identity](#managed-identity) · [Application Insights](#application-insights) |

Full learning path: [Azure cloud and AI](azure-cloud-and-ai.md) · [Certification track](../career/azure-certification-track.md)

---

## B

### Backoff (exponential)

Exponential backoff means that when a retry fails, the client waits longer before each subsequent attempt—for example 1 second, then 2, then 4. The goal is to give a struggling service breathing room instead of a stampede of requests. It is almost always paired with a maximum wait cap and often with jitter so retries do not align across many clients.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Backpressure

Backpressure is what happens when a slow consumer signals upstream to slow down or drop work instead of buffering forever. Without it, unbounded queues or unbounded DOM updates can cause memory blow-ups and sudden latency cliffs. Well-designed pipelines propagate pressure so producers stop flooding a stage that cannot keep up.

**See also:** [Memory and performance](memory-and-performance.md); [Project 8 — Go worker](../../career-project-specs/08-go-retrieval-worker-lab.md); [Project 13 — Real-time dashboard](../../career-project-specs/13-realtime-dashboard-lab.md)

### BFF (Backend for Frontend)

A BFF (Backend for Frontend) is a thin server tailored to one UI. It calls backend services, holds secrets, and shapes responses so the browser never stores API keys or talks to every microservice directly. Each client platform—web, mobile, admin—can have its own BFF with the exact data shape that UI needs.

**See also:** [Project 11 — LLM web app](../../career-project-specs/11-llm-web-app-lab.md)

### Big-O notation

Big-O notation is shorthand for how work grows as input size grows—for example O(n) means roughly proportional to n. It compares algorithms at a high level without pinning down constant factors or hardware details. You use it in interviews and design discussions to reason about scalability before you profile.

**See also:** [Algorithms and data structures](algorithms-and-data-structures.md)

### Blue-green deployment

Blue-green deployment means running two production environments—traditionally called "blue" and "green." You deploy the new version to the idle environment, verify it, then switch traffic over in one step. Rollback is fast: switch traffic back to the previous environment if something goes wrong.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Blast radius

Blast radius is how much of the system or how many users break if a change fails. A bad deploy that takes down every region has a large blast radius; one that affects 1% of traffic has a small one. Canary deploys and feature flags exist largely to shrink blast radius while you learn from real traffic.

**See also:** [Canary deployment](#canary-deployment); [Feature flag](#feature-flag)

### Bounded concurrency / worker pool

Bounded concurrency means putting a fixed cap on how many jobs or requests run at once—implemented with a pool, semaphore, or max-workers setting. Without a cap, load spikes can spawn unbounded goroutines or threads and exhaust memory. A worker pool gives you predictable resource use at the cost of some requests waiting in line.

**See also:** [Concurrency basics](software-engineering.md#concurrency-basics); [Project 8 — Go worker](../../career-project-specs/08-go-retrieval-worker-lab.md)

### Bloom filter

A Bloom filter is a compact probabilistic structure that answers "maybe in the set" or "definitely not in the set"—it never gives a false negative but may give false positives you tune away. It saves memory when you only need approximate membership at huge scale, such as CDN edge caches or deduplication hints. When a false positive is acceptable, Bloom filters beat storing every key in a hash set.

**See also:** [Algorithms and data structures — Bloom filter](algorithms-and-data-structures.md#bloom-filter-and-bitmap-vocabulary)

---

## C

### Canary deployment

A canary deployment sends a small slice of real traffic to a new version first. If metrics look good, you increase the slice; if not, you stop before everyone is affected. The name comes from the canary in a coal mine—early warning before the whole crew is exposed.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Cardinality (metrics)

Cardinality in metrics is the number of distinct label values on a metric—for example one time series per user ID. High cardinality (millions of unique labels) breaks many metrics systems and dashboards because storage and query cost explode. Keep labels coarse—service, endpoint, status code—not unbounded IDs unless you have a system built for it.

**See also:** [Observability — metrics](software-engineering.md#observability-logs-metrics-traces)

### CI/CD (Continuous Integration / Continuous Delivery or Deployment)

CI/CD combines Continuous Integration (CI) and Continuous Delivery or Deployment (CD). CI means frequently merging work and automatically building and testing it on every change. CD means keeping the app in a releasable state (Delivery) or automatically shipping it to production (Deployment), depending on team setup and risk tolerance.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Circuit breaker

A circuit breaker stops calling a failing dependency for a while so your service fails fast instead of piling up waiting requests. After a cooldown it may probe with a single call to see if the dependency recovered—like an electrical breaker that trips under overload. Without this pattern, one slow downstream can tie up all your threads and cascade failure across the system.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Code review

Code review is when a teammate reads your change before it merges. It catches bugs, spreads knowledge, and aligns the team on style and design. Good reviews focus on correctness, clarity, and risk—not nitpicking for its own sake.

**See also:** [Code review and documentation](software-engineering.md#code-review-and-documentation)

### Connection pooling

Connection pooling means reusing open database or HTTP connections instead of opening a new one per request. It is faster because handshake and setup costs are amortized, but pool exhaustion can look like latency even when your SQL is fine. Size pools based on concurrency limits and what your database can sustain.

**See also:** [Project 18 — Proxy / load balancer](../../career-project-specs/18-proxy-load-balancer-lab.md); [Memory and performance](memory-and-performance.md)

### Contract testing

Contract testing verifies that an API provider and consumer still agree on request/response shapes without running the full system end to end. OpenAPI diff in CI is a lightweight form: fail the build when the spec changes without a version bump or consumer update. Consumer-driven contracts (Pact-style) go further by testing that each side honors the shared schema.

**See also:** [OpenAPI](#openapi); [Project 5 — Contract-first API](../../career-project-specs/05-contract-first-api.md)

### Correlation ID / request_id

A correlation ID (sometimes called request_id) is a unique identifier attached to one request or business event and copied into every log and downstream call. When something fails, you can grep or trace that single ID across services instead of guessing which log lines belong together. It is one of the cheapest wins in observability for distributed systems.

**See also:** [Project 3 — Observability](../../career-project-specs/03-observability-lab.md); [Production readiness](../../checklists/production-readiness.md)

### CORS (Cross-Origin Resource Sharing)

CORS (Cross-Origin Resource Sharing) is a browser mechanism that controls whether a web page on one origin may read responses from another. The server sends headers that tell the browser which cross-origin requests are allowed. CORS is not a substitute for real authorization on the server—any non-browser client can ignore it.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### Clean / Onion architecture

Clean architecture and Onion architecture organize code in concentric layers: entities, use cases, interface adapters, and frameworks. The Dependency Rule says source-code dependencies point only inward, so the domain never imports the web framework or database. The same instinct as hexagonal (ports and adapters) architecture; easy to over-engineer for small apps.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns); [Hexagonal architecture](#hexagonal-architecture-ports-and-adapters); [Clean Architecture folder layouts (reference)](clean-architecture-layouts.md)

### CQRS (Command Query Responsibility Segregation)

CQRS (Command Query Responsibility Segregation) splits writes (commands) from reads (queries), sometimes with different models or databases for each side. It helps at scale when read and write patterns diverge, but it is overkill for tiny CRUD apps. The read side is often updated asynchronously, so reads are eventually consistent with writes.

**See also:** [CQRS and Event Sourcing](software-engineering.md#cqrs-and-event-sourcing)

### CRD (Custom Resource Definition)

A CRD (Custom Resource Definition) is a Kubernetes extension that adds your own resource types to the API beyond built-in Deployments, Services, and the like. You define the schema in YAML, and the cluster stores instances like any other resource. CRDs are often paired with a controller that reconciles desired state into actual state.

**See also:** [Project 17 — K8s controller](../../career-project-specs/17-k8s-controller-lab.md)

### C4 model

The C4 model is a layered diagram vocabulary for software architecture: **C**ontext (system and users), **C**ontainers (apps and data stores), **C**omponents (modules inside a container), and optional **C**ode. Portfolio artifacts in this playbook expect at least context plus container views. It gives reviewers a shared zoom level without full Unified Modeling Language (UML) ceremony.

**See also:** [Architecture checklist — documentation deliverables](../../checklists/architecture-checklist.md); [Systems integration architect](systems-integration-architect.md)

### CSRF (Cross-Site Request Forgery)

CSRF (Cross-Site Request Forgery) is an attack that tricks a logged-in user's browser into submitting a request your site will accept—often using cookies the browser sends automatically. Defenses include anti-CSRF tokens, same-site cookies, and requiring re-authentication for sensitive actions. Any endpoint that mutates state via cookie-based auth needs CSRF protection.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### Cache stampede

A cache stampede happens when many requests miss a hot cache key at once—often because it expired—and all hammer the database or origin at the same time. Defenses include singleflight (only one refresh in flight), probabilistic early expiration, and locking around rebuild. It is a classic failure mode when read-heavy APIs rely on TTL-based caching without coordination.

**See also:** [Memory and performance — caching](memory-and-performance.md); [System design interview map — failure modes](../career/system-design-interview-map.md)

### CDN (Content Delivery Network)

A CDN (Content Delivery Network) is a geographically distributed cache of static or cacheable content—images, JavaScript bundles, short URL redirects—served from edge locations close to users. It reduces latency and origin load for read-heavy workloads. Pair a CDN with cache headers and invalidation strategy; do not treat it as a substitute for application-level authorization.

**See also:** [Servers and networking](servers-and-networking.md); [System design interview map — URL shortener](../career/system-design-interview-map.md)

### Change Data Capture (CDC)

Change Data Capture (CDC) streams row-level changes from a primary database to downstream consumers—search indexes, warehouses, analytics pipelines. Consumers operate under eventual consistency: they lag the source by some interval. CDC decouples OLTP from read models without polling every table on a schedule, and often pairs with Kafka or an outbox publisher.

**See also:** [Database design — Change data capture](database-design.md#change-data-capture); [Outbox pattern](#outbox-pattern)

### Consistent hashing

Consistent hashing maps keys to nodes on a ring so adding or removing a shard only remaps a fraction of keys—not the entire keyspace. Virtual nodes spread load more evenly across physical servers. You will hear it in URL shortener and sharding discussions when you need horizontal scale without rebalancing everything on every topology change.

**See also:** [Database design — Sharding and partitioning](database-design.md#sharding-and-partitioning); [System design interview map — URL shortener](../career/system-design-interview-map.md)

### Concurrency

Concurrency means many tasks making progress at once—even on one CPU core, through time-slicing or interleaved I/O waits. It is a structuring idea: goroutines, async tasks, and event loops express concurrent programs. Concurrency does not require multiple cores; parallelism does.

**See also:** [Concurrency runtime model (Part 1)](concurrency-runtime-model.md); [Parallelism](#parallelism)

### Conway's law

Conway's law says system architecture tends to mirror communication structure—if three teams never talk, you get three services with awkward integration. Use it when deciding monolith versus split: one team often favors a modular monolith; many teams may need clearer service boundaries. It is a lens for org fit, not a rule to microservice everything.

**See also:** [Architecture checklist — organizational fit](../../checklists/architecture-checklist.md); [Modular monolith](#modular-monolith)

### Core (CPU)

A core is an independent execution unit on a CPU chip—each core runs one instruction stream at a time at the hardware level you care about for system design. Parallelism at the machine level starts with core count: eight cores can execute eight streams simultaneously (hyper-threading adds logical streams but is not a full extra core). Runtime schedulers map goroutines or OS threads onto cores.

**See also:** [Concurrency runtime model (Part 1)](concurrency-runtime-model.md)

---

## D

### DAST (Dynamic Application Security Testing)

DAST (Dynamic Application Security Testing) is security testing that hits a running application, often in a black-box style. It looks for issues like misconfigurations, exposed endpoints, and injectable inputs without requiring full source access. DAST complements SAST (Static Application Security Testing) by finding problems that only appear when the app is actually running.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### Dead letter queue (DLQ)

A dead letter queue (DLQ) is a holding area for messages that failed processing too many times. They leave the main queue so one bad message does not block everything behind it. Operators can inspect, fix, and replay DLQ messages once the underlying bug or bad payload is understood.

**See also:** [Integration hardening](../../checklists/integration-hardening.md)

### Debugging

Debugging is the process of narrowing why a program's actual behavior differs from what you expected. You reproduce the problem, shrink it to a smaller case, and use logs, traces, and tests to find the root cause. Good debugging is systematic guess-and-check, not random edits until something works.

**See also:** [Debugging (workflow)](software-engineering.md#debugging-workflow)

### Deduplication / dedupe

Deduplication (dedupe) means detecting and ignoring duplicate messages or requests. Common approaches include storing an idempotency key or enforcing a unique constraint so the same event cannot be applied twice. It is essential when you have at-least-once delivery and must not double-apply side effects like charging a card.

**See also:** [Idempotency](#idempotency); [Example: idempotent webhook](software-engineering.md#example-idempotent-webhook-or-job-consumer)

### Dependency injection

Dependency injection means passing dependencies—like a database client or clock—into a component from outside instead of creating them inside. The caller decides which concrete implementation to use, which makes code easier to test and swap. It is the practical side of the dependency inversion principle from SOLID.

**See also:** [SOLID — dependency inversion](software-engineering.md#solid)

### DDD (Domain-Driven Design)

DDD (Domain-Driven Design) is an approach to designing software around the business domain and a ubiquitous language shared with domain experts. Key terms include bounded context (a boundary where one model is consistent), entity (identity over time), value object (defined by attributes, immutable), aggregate (a consistency unit accessed through its root), and domain event. It is powerful for complex domains and overkill for simple CRUD.

**See also:** [Domain-Driven Design (DDD)](software-engineering.md#domain-driven-design-ddd)

### DRY (Don't Repeat Yourself)

DRY (Don't Repeat Yourself) means each piece of knowledge should have one clear home in the codebase, avoiding copy-paste logic that will diverge over time. The goal is maintainability, not eliminating every repeated line. Sometimes a little duplication is better than the wrong shared abstraction.

**See also:** [DRY and when duplication wins](software-engineering.md#dry-and-when-duplication-wins)

---

## E

### E2E (end-to-end) test

An E2E (end-to-end) test exercises the whole system—or most of it—often through the UI or public API. It gives high confidence that the pieces wire together correctly, but it is slower than unit tests and can be flaky if overused. Teams usually keep a small suite of critical-path E2E tests and rely on faster tests for day-to-day feedback.

**See also:** [Testing](software-engineering.md#testing)

### Encapsulation

Encapsulation means hiding internal details behind a clear public surface so outside code cannot accidentally break invariants. You expose what callers need and keep implementation private. It is core to object-oriented design and applies more broadly anytime you define a module boundary.

**See also:** [Programming paradigms](software-engineering.md#programming-paradigms)

### Event-driven architecture

Event-driven architecture means components react to events (messages) instead of calling each other directly over synchronous HTTP. It enables loose coupling and independent scaling, but you must think about ordering, duplicates, and consistency across services. Many production systems mix sync calls for queries and events for side effects.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

### Event sourcing

Event sourcing stores the append-only log of events that produced state—such as `MoneyDeposited` and `MoneyWithdrawn`—rather than only the current row in a table. You rebuild state by replaying events, often with snapshots to keep replay fast. It gives a perfect audit trail and temporal queries at the cost of event versioning and replay complexity, and is often paired with CQRS (Command Query Responsibility Segregation).

**See also:** [CQRS and Event Sourcing](software-engineering.md#cqrs-and-event-sourcing)

### Eventual consistency

Eventual consistency means that after a write, reads may be stale for a while before all replicas or consumers catch up. It is common in event-driven and distributed systems where synchronous strong consistency would be too slow or fragile. Design for it with idempotency, clear user expectations, and UI that does not promise instant global truth.

**See also:** [Architectural patterns — event-driven](software-engineering.md#architectural-patterns)

### Eval / eval regression

An eval (evaluation) is a fixed test set—often JSONL—of prompts and expected behaviors for an LLM (Large Language Model) or RAG (Retrieval-Augmented Generation) feature. You re-run it after model or prompt changes to catch answer drift before production. Treat it like a regression suite for non-deterministic AI behavior.

**See also:** [Project 2 — RAG / LLM service](../../career-project-specs/02-rag-llm-service.md); [LLM feature ship checklist](../../checklists/llm-feature-ship.md)

### Event loop

An event loop is a runtime pattern where one thread schedules callbacks when I/O completes—used by Node.js, Python asyncio, and browser JavaScript. It gives concurrency for network-heavy work without one OS thread per connection. It does not parallelize CPU-heavy JavaScript on the main thread; offload that to worker threads or another service.

**See also:** [Concurrency runtime model (Part 1)](concurrency-runtime-model.md); [Node event loop at scale (Part 2)](concurrency-deep-dives.md#node-event-loop-at-scale)

### Exactly-once (and why people say "effectively-once")

Exactly-once delivery is often marketed as a messaging guarantee, but in distributed systems you usually implement at-least-once delivery plus idempotent handling. That way duplicates do not cause extra side effects—"effectively once" from the business perspective. True exactly-once end-to-end is extremely hard and usually delegated to transactional outbox patterns or idempotent consumers.

**See also:** [Message queues and delivery semantics](software-engineering.md#message-queues-and-delivery-semantics)

### Expand/contract migration

Expand/contract is a zero-downtime schema migration pattern: expand by adding a new nullable column or table, backfill data in the background, switch application code to read/write the new shape, then contract by dropping the old column. Rushing a breaking change in one deploy step locks tables or breaks running instances during rolling deploys. Laravel, SQL, and Postgres labs in this playbook reference the same discipline.

**See also:** [Database design — Migrations](database-design.md#migrations); [SQL ecosystem map — migrations](../languages/sql.md)

---

## F

### Factory (pattern)

A factory is a central place to create objects so construction rules stay consistent and callers do not scatter `new` everywhere. It hides which concrete class you instantiate and can enforce invariants at creation time. Useful when construction involves configuration, pooling, or choosing among several implementations.

**See also:** [Design patterns](software-engineering.md#design-patterns-gof-style-survey)

### Fake (test double)

A fake is a test double with a working in-memory implementation—a fake database, fake clock, or fake queue. It behaves realistically enough for integration-style tests without real I/O. Prefer fakes over mocks when you need plausible behavior rather than just verifying that a method was called.

**See also:** [Testing — doubles](software-engineering.md#testing)

### Fast ack

Fast ack means responding with HTTP 2xx quickly on webhooks or ingress while slow work runs in a queue or background worker. Partners and platforms time out and retry if you block on PDF generation, ML inference, or long call chains. Acknowledge receipt, persist the job, and process asynchronously.

**See also:** [Example: idempotent webhook](software-engineering.md#example-idempotent-webhook-or-job-consumer); [Project 1 — Webhook receiver](../../career-project-specs/01-integration-webhook-receiver.md)

### Feature flag

A feature flag is a switch that turns code paths on or off without deploying again. Teams use them for gradual rollouts, A/B tests, and hiding unfinished work behind a safe default. Flags add operational complexity, so retire them once a feature is fully launched.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)

### Fan-out

Fan-out is when one incoming event or request triggers many downstream calls or notifications. Watch for latency (you may wait for the slowest branch), partial failure (some branches succeed and others do not), and the need for idempotency on each branch. Notification systems and workflow engines are classic fan-out examples.

**See also:** [Project 24 — Notification fanout](../../career-project-specs/24-notification-fanout-lab.md)

---

## G

### Graceful shutdown

Graceful shutdown means that on deploy or SIGTERM, a process stops accepting new work, finishes or times out in-flight requests, then exits. It avoids cutting clients off mid-request and gives load balancers time to drain the instance. Every long-running server and worker should implement this.

**See also:** [Project 18 — Proxy / load balancer](../../career-project-specs/18-proxy-load-balancer-lab.md)

### GraphQL

GraphQL is an API style where clients ask for specific fields in one query, reducing over-fetching and under-fetching compared to fixed REST responses. It is flexible for client teams but servers must watch performance—especially resolver N+1 issues where one query triggers a database round trip per row. Schema and resolvers are the server-side contract.

**See also:** [GraphQL, gRPC, and webhooks](software-engineering.md#graphql-grpc-and-webhooks)

### GOMAXPROCS

GOMAXPROCS is a Go runtime setting that limits how many operating-system threads execute Go code simultaneously—defaulting to the number of logical CPUs. It controls how much **parallelism** Go uses on multi-core machines; it does not replace bounded worker pools or semaphores on I/O fan-out. Set to 1 when debugging single-core behavior.

**See also:** [Go M:N scheduler (Part 2)](concurrency-deep-dives.md#go-mn-scheduler); [Project 8 — Go worker](../../career-project-specs/08-go-retrieval-worker-lab.md)

### Goroutine

A goroutine is a lightweight concurrent task scheduled by the Go runtime—not one OS thread per goroutine. The runtime multiplexes many goroutines onto fewer threads (M:N scheduling). Goroutines are cheap to create but still need bounds, context cancellation, and channel or mutex discipline under load.

**See also:** [Concurrency runtime model (Part 1)](concurrency-runtime-model.md); [Goroutines vs OS threads (Part 2)](concurrency-deep-dives.md#goroutines-vs-os-threads)

### gRPC

gRPC is a high-performance RPC (Remote Procedure Call) framework, often using Protocol Buffers over HTTP/2. It is common for service-to-service calls inside a backend where strong typing and streaming matter. Browser support is limited compared to REST, so gRPC usually sits behind an API gateway or BFF (Backend for Frontend).

**See also:** [GraphQL, gRPC, and webhooks](software-engineering.md#graphql-grpc-and-webhooks)

### Guardrails (LLM)

Guardrails are policy limits on LLM (Large Language Model) behavior—citations required, refusals on sensitive topics, output filters, and length caps. They help AI features fail safely instead of hallucinating confidently. Guardrails sit alongside evals and human review in a responsible ship checklist.

**See also:** [Project 2 — RAG / LLM service](../../career-project-specs/02-rag-llm-service.md); [LLMs handbook](llms.md)

---

## H

### HMAC

HMAC (Hash-based Message Authentication Code) is a cryptographic signature over a message—often a webhook raw body plus a shared secret. It proves the sender knew the secret without transmitting the secret itself. Verify the signature before you trust the payload or enqueue work.

**See also:** [Integration hardening](../../checklists/integration-hardening.md); [Project 1 — Webhook receiver](../../career-project-specs/01-integration-webhook-receiver.md)

### Hot path

The hot path is code that runs on every request or inside a tight loop. Optimize and measure here first: avoid heavy work, extra allocations, and blocking I/O on the hot path. Micro-optimizing cold paths rarely moves user-visible latency.

**See also:** [Memory and performance](memory-and-performance.md); [Project 19 — Rust hot-path](../../career-project-specs/19-rust-hot-path-lab.md)

### Hexagonal architecture (ports and adapters)

Hexagonal architecture keeps domain logic in the middle and puts HTTP, databases, and queues on the outside as adapters connected through ports (interfaces). Swapping infrastructure means writing a new adapter, not rewriting business rules. It is the same idea as Clean/Onion architecture with different diagram vocabulary.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

---

## I

### I/O-bound vs CPU-bound

I/O-bound work spends most of its time waiting on network, disk, or the database while the CPU sits idle. CPU-bound work is compute-heavy—parsing, encryption, rendering—and the bottleneck is processor time. Fix I/O-bound problems with fewer round trips, pooling, and async concurrency; fix CPU-bound problems with better algorithms, profiling, or moving work off the hot path.

**See also:** [Memory and performance](memory-and-performance.md)

### Idempotency

Idempotency means doing the same operation twice has the same effect as doing it once. "Set balance to $10" is idempotent; "add $10" is not unless you dedupe by transaction ID. It is critical for retries, webhooks, and any at-least-once delivery path.

**See also:** [Example: idempotent webhook](software-engineering.md#example-idempotent-webhook-or-job-consumer)

### IaaS / PaaS / SaaS

Cloud service models describe who manages what. **IaaS** (Infrastructure as a Service)—virtual machines, networks—you manage OS and apps. **PaaS** (Platform as a Service)—managed runtimes like Heroku or Cloud Run—you deploy code; the platform runs containers. **SaaS** (Software as a Service)—complete products like Salesforce—you configure and integrate. Pick based on control versus operational burden.

**See also:** [Servers and networking — Cloud models](servers-and-networking.md)

### Inverted index / BM25 (vocabulary)

An inverted index maps terms to document IDs—the core of full-text search engines. **BM25** (Best Matching 25) is a ranking function that scores how well a document matches a query, balancing term frequency and document length. You do not implement BM25 from scratch in most apps; you need the vocabulary for search and autocomplete system design interviews.

**See also:** [Algorithms and data structures — Trie](algorithms-and-data-structures.md); [Project 25 — Search autocomplete](../../career-project-specs/25-search-autocomplete-lab.md)

### Integration test

An integration test uses real pieces working together—a database, HTTP server, or queue—rather than mocks for everything. It is usually slower than a unit test but catches wiring and configuration issues unit tests miss. Most teams run a subset on every commit and a larger set before release.

**See also:** [Testing](software-engineering.md#testing)

### Injection (SQL injection)

SQL injection is an attack where attacker-controlled input becomes part of a database query. Prevent it with parameterized queries or ORMs used correctly—not by concatenating strings into SQL. It remains one of the most common and preventable web vulnerabilities.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

---

## J

### Jitter

Jitter is random extra wait added to retry backoff so many clients do not retry at the same instant. Without jitter, a recovering service can get hit by a thundering herd of synchronized retries. Even a small random spread dramatically smooths load after an outage.

**See also:** [Backoff (exponential)](#backoff-exponential); [Sync HTTP callers](software-engineering.md#sync-http-callers)

### JSON (JavaScript Object Notation)

JSON (JavaScript Object Notation) is a common text format for APIs—structured like objects and arrays with string keys. Despite the name it is language-agnostic and human-readable. Most REST APIs and config snippets you encounter use JSON.

**See also:** [REST](software-engineering.md#rest)

### JWT (JSON Web Token)

A JWT (JSON Web Token) is a signed, often base64-encoded payload that carries claims such as user ID and tenant ID between services or from server to client. The server verifies the signature with a shared secret or public key before trusting claims—never trust tenant or role data from an unsigned client body. JWTs are stateless for the server but harder to revoke instantly than server-side sessions unless you add a blocklist or short expiry.

**See also:** [Auth and tenancy](software-engineering.md#auth-and-tenancy); [Illustrative snippets — JWT tenant middleware](illustrative-snippets.md); [Project 12 — Multi-tenant auth](../../career-project-specs/12-multi-tenant-auth-lab.md)

---

## K

### Kafka, Redis, and NATS (message brokers)

These are common message brokers with different sweet spots. **Redis** lists/streams are fast and simple for local iteration and moderate durability. **Kafka** is a durable append-only log with replay and high fan-out—heavier ops, standard at scale. **NATS** is lightweight pub/sub with optional JetStream persistence. Same playbook skills—idempotency, DLQ, bounded workers—transfer across brokers; interviewers care that you know tradeoffs, not every broker API.

**See also:** [Messaging and RPC](messaging-and-rpc.md); [Architecture framework — broker table](architecture-framework.md#pillar-2--integration-and-messaging)

### Keyset (cursor) pagination

Keyset pagination (also called cursor pagination) pages through results with a stable cursor—usually the last seen ID or timestamp—instead of offset (`LIMIT 20 OFFSET 1000`). It avoids skipped or duplicate rows when data changes during paging, which offset pagination cannot guarantee under concurrent writes. APIs that expose infinite scroll or large tables often prefer keyset pagination.

**See also:** [Pagination (cursor / offset)](#pagination-cursor--offset); [Project 4 — SQL performance](../../career-project-specs/04-sql-performance-lab.md)

### Kubernetes (K8s)

Kubernetes (often abbreviated K8s) is a container orchestrator: it schedules app containers across machines, restarts failed ones, exposes services, and scales replicas. You often meet it as YAML manifests and vocabulary like pods, deployments, and services. It handles the operational complexity of running many containers in production.

**See also:** [Servers and networking](servers-and-networking.md)

---

## L

### Lint / linter

A linter is a tool that statically checks code for style issues and common mistakes without running the full application. It catches unused variables, suspicious patterns, and formatting drift early in CI (Continuous Integration). Linters complement tests; they do not replace them.

**See also:** [CI/CD — pipeline](software-engineering.md#cicd-and-delivery)

### Load balancer

A load balancer spreads incoming requests across multiple servers so one machine does not get overwhelmed. It may also terminate TLS, perform health checks, and route by path or header. Without one, scaling out adds machines that never receive traffic.

**See also:** [Servers and networking](servers-and-networking.md)

### Liveness vs readiness

Liveness asks "is the process alive?"—if not, the orchestrator restarts it. Readiness asks "can this instance take traffic?"—if not, it is removed from the load balancer even if the process is running (for example when the database is unreachable). Both are common health check types in Kubernetes and production deploy pipelines.

**See also:** [Production readiness — health checks](../../checklists/production-readiness.md); [Project 16 — Cloud deploy](../../career-project-specs/16-cloud-deploy-lab.md)

---

## M

### Managed identity (Azure)

Managed identity gives an Azure resource (Container App, Function, VM) an automatic identity in Azure AD so it can read Key Vault or call other services without embedding passwords in config. It is how [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) Azure deploys avoid secrets in git.

**See also:** [Azure Key Vault](#azure-key-vault); [Azure cloud and AI — secrets](azure-cloud-and-ai.md#secrets-and-identity)

### Message queue

A message queue is a buffer that lets producers enqueue work and consumers process it later. It decouples "accept the request now" from "do the work when we have capacity." Queues also smooth spikes and survive brief consumer outages—at the cost of eventual processing and operational complexity.

**See also:** [Integration: sync, async, and messaging](software-engineering.md#integration-sync-async-and-messaging)

### Metrics

Metrics are numeric measurements over time—request rates, latency percentiles, error counts—that are cheap to aggregate for dashboards and alerts. Unlike logs, they summarize behavior rather than recording every event. Good metrics use consistent labels without exploding cardinality.

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

### M:N scheduling

M:N scheduling maps many user-space tasks (M) onto fewer OS threads (N)—Go's goroutine scheduler is the classic example. The runtime parks blocked tasks and runs ready ones on available threads, so I/O-heavy programs need fewer OS threads than one-thread-per-task designs. Java virtual threads and Rust tokio use similar ideas with different implementations.

**See also:** [Go M:N scheduler (Part 2)](concurrency-deep-dives.md#go-mn-scheduler); [Goroutine](#goroutine)

### Microservices

Microservices means many small independently deployable services instead of one big application (a monolith). Teams gain autonomy and independent scaling but pay in operational and network complexity—distributed tracing, versioning, and failure modes multiply. It is a organizational and scaling tradeoff, not a default architecture.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

### Mock (test double)

A mock is a test double that records whether collaborators were called—and often how—so you can assert interactions. Mocks help when the contract is "must call X once with Y," but over-mocking couples tests to implementation details. Prefer real or fake collaborators when feasible.

**See also:** [Testing — doubles](software-engineering.md#testing)

### Modular monolith

A modular monolith is one deployable application with clean internal modules and boundaries—often aligned to domain areas. You get simplicity of a single deploy and shared database while keeping code organized for a possible future split. It is a pragmatic default before jumping to microservices.

**See also:** [Architectural patterns](software-engineering.md#architectural-patterns)

### Multi-tenancy / tenant isolation

Multi-tenancy means one application instance serves many customers (tenants) with data separated so tenant A never reads tenant B's rows. Isolation can live in application code (`WHERE tenant_id = ?` on every query), in Postgres Row-Level Security (RLS), or in separate databases per tier. Senior interview line: the JWT or session carries `tenant_id`; every data path scopes by it—authorization, not just authentication.

**See also:** [Auth and tenancy](software-engineering.md#auth-and-tenancy); [Project 12 — Multi-tenant auth](../../career-project-specs/12-multi-tenant-auth-lab.md); [Database design — Data and access security](database-design.md#data-and-access-security)

---

## N

### N+1 query problem

The N+1 query problem is a performance bug where code runs one query per row instead of fetching in bulk—for example loading 100 authors with 101 database round trips (one for the list plus one per author). ORMs make this easy to accidentally introduce through lazy loading. Fix it with eager loading, joins, or batch queries.

**See also:** [Database design — N+1](database-design.md#orms-and-the-n1-query-pattern)

### Noisy neighbor

A noisy neighbor is one tenant or workload that consumes disproportionate CPU, memory, I/O, or connection pool slots and degrades others on shared infrastructure. Defenses include per-tenant rate limits, connection caps, separate queues, and isolating large customers to dedicated resources. Multi-tenant SaaS design interviews often ask how you prevent one customer from starving the rest.

**See also:** [Multi-tenancy / tenant isolation](#multi-tenancy--tenant-isolation); [Project 12 — Multi-tenant auth](../../career-project-specs/12-multi-tenant-auth-lab.md); [Rate limiting (429)](#rate-limiting-429)

### Non-functional requirements (NFR)

Non-functional requirements (NFRs) describe how a system should behave—not feature lists but qualities: latency targets, availability, scale (queries per second, storage growth), security class, compliance, and operability. System design interviews start by separating functional requirements from NFRs because architecture follows constraints. Capture NFRs before irreversible stack choices.

**See also:** [Architecture checklist — Phase 1 feasibility](../../checklists/architecture-checklist.md); [SLA / SLO / SLI](#sla--slo--sli); [System design interview map](../career/system-design-interview-map.md)

---

## O

### Object-oriented programming (OOP)

Object-oriented programming (OOP) organizes programs around objects that combine data and behavior, using ideas like encapsulation and polymorphism. It dominated enterprise software for decades but is not the only paradigm teams use day to day—functional and procedural styles mix in most codebases. OOP shines when domain entities have rich behavior and clear boundaries.

**See also:** [Programming paradigms](software-engineering.md#programming-paradigms)

### Observability

Observability is how well you can understand a system's internal state from outside signals—mainly logs, metrics, and traces—with correlation across requests. It is not just "having dashboards"; it is whether you can answer novel questions when production misbehaves. Strong observability shortens mean time to recovery.

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

### OpenAPI

OpenAPI is a standard way to describe REST-style HTTP APIs—endpoints, request and response shapes, and error codes—in a machine-readable format. Humans and tools (code generators, mock servers, contract tests) can agree on the same contract. It is the modern successor to informal "here is the wiki" API docs.

**See also:** [REST](software-engineering.md#rest); [Contract-first API](../../career-project-specs/05-contract-first-api.md)

### OpenTelemetry

OpenTelemetry (often abbreviated OTel) is a vendor-neutral standard and set of libraries for traces, metrics, and logs. You instrument once and export to many backends—Jaeger, Datadog, and others. It reduces lock-in compared to proprietary agent SDKs.

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

### Outbox pattern

The outbox pattern writes database changes and an outbox row in one transaction, then a separate process publishes from the outbox to the message queue. It avoids the failure mode where the DB committed but the message never sent—or the message sent but the DB rolled back. It is a standard way to get reliable event publishing from transactional systems.

**See also:** [Event-driven integration](software-engineering.md#event-driven-integration)

### OWASP

OWASP (Open Web Application Security Project) maintains a well-known catalogue of common web application risks. Teams use its Top 10 list as checklist language for XSS (Cross-Site Scripting), injection, broken access control, and related issues. It is a starting point for threat modeling, not a complete security program.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### OAuth / OIDC

OAuth 2.0 is a framework for delegated authorization—"allow this app to act on my behalf"—without sharing your password. OpenID Connect (OIDC) adds identity on top: after login you get an ID token (often a JWT) with who the user is. Roles in conversation: client app, authorization server (IdP), and resource server (your API). B2B SaaS and "Sign in with Google" flows use OIDC; your API still enforces authorization on every request.

**See also:** [Auth and tenancy](software-engineering.md#auth-and-tenancy); [OAuth scopes and PKCE](#oauth-scopes-and-pkce); [Project 12 — Multi-tenant auth](../../career-project-specs/12-multi-tenant-auth-lab.md)

### OAuth scopes and PKCE

OAuth **scopes** limit what a token may do—`read:orders` versus `write:orders`—and should be checked on every protected endpoint. **PKCE** (Proof Key for Code Exchange) protects public clients (mobile, SPA) during authorization-code flows by binding the code exchange to a one-time verifier. Modern OIDC setups require PKCE for browser and native apps; server-side confidential clients use client secrets instead.

**See also:** [OAuth / OIDC](#oauth--oidc); [Auth and tenancy](software-engineering.md#auth-and-tenancy)

---

## P

### Pagination (cursor / offset)

Pagination means returning large lists in chunks instead of all at once. Offset pagination (`page=2&size=20`) is simple but can skip or duplicate rows if data changes while the client pages. Cursor pagination is often more stable for live APIs and large datasets.

**See also:** [REST](software-engineering.md#rest)

### Partition key / sharding

A partition key is the field that decides which shard or database partition owns a row—for example `tenant_id` or a hash of `short_code`. Sharding splits data across multiple databases or nodes when one instance cannot hold the load or storage. Choose keys that keep related queries co-located and avoid hot partitions where one key dominates traffic.

**See also:** [Database design — Sharding and partitioning](database-design.md#sharding-and-partitioning); [Project 4 — SQL performance](../../career-project-specs/04-sql-performance-lab.md)

### p50 / p95 / p99 (latency percentiles)

Latency percentiles describe the distribution of response times—if p95 latency is 300ms, 95% of requests finished within 300ms. The slow tail (p99 and above) is what SLOs (Service Level Objectives) and users often feel, while averages hide outliers. Always report percentiles alongside averages when discussing performance.

**See also:** [Memory and performance](memory-and-performance.md); [Project 3 — Observability](../../career-project-specs/03-observability-lab.md)

### Parallelism

Parallelism means many tasks execute at the same instant—requiring multiple CPU cores or machines. It is a subset of concurrency: all parallel programs are concurrent, but a single-core event loop can be concurrent without being parallel. CPU-bound work needs parallelism; I/O-bound work often needs only concurrency.

**See also:** [Concurrency](#concurrency); [Concurrency runtime model (Part 1)](concurrency-runtime-model.md)

### Poison message

A poison message is a queue job that always fails—bad payload, schema mismatch, or a bug in the handler. After max retries it should land in a DLQ (dead letter queue) instead of blocking the queue forever. Without DLQ handling, one poison message can stall the entire consumer.

**See also:** [Dead letter queue (DLQ)](#dead-letter-queue-dlq); [Project 6 — Async worker](../../career-project-specs/06-async-worker-stretch.md)

### Polymorphism

Polymorphism means treating different concrete types through the same interface—callers depend on behavior, not the exact class. It lets you swap implementations and extend behavior without changing every call site. In typed languages this is often expressed with interfaces or abstract base classes.

**See also:** [SOLID — Liskov](software-engineering.md#solid)

### Process vs thread

A process has its own memory space and is isolated from other processes by the operating system. Threads within one process share memory and must synchronize carefully to avoid data races. More threads do not always mean more speed—contention and I/O patterns matter more than raw thread count.

**See also:** [Concurrency basics](software-engineering.md#concurrency-basics)

---

## Q

### Queue (see message queue)

In backend conversations, "queue" usually means a message queue—work waiting for a consumer to process asynchronously. In algorithms, it means a FIFO (First In, First Out) data structure. Context determines which meaning applies; integration docs almost always mean message queue.

**See also:** [Message queue](#message-queue)

---

## R

### Regression test

A regression test locks in a fix so the same bug cannot return unnoticed. It often starts as a failing test written while debugging, then stays in the suite forever. Regression tests are how you pay down the cost of past incidents with compound interest in confidence.

**See also:** [Debugging — safety net](software-engineering.md#debugging-workflow)

### RAG (Retrieval-Augmented Generation)

RAG (Retrieval-Augmented Generation) retrieves relevant documents from a store, then generates an answer with an LLM (Large Language Model) grounded in those chunks. It reduces pure hallucination compared to naked prompts because the model can cite or reason over retrieved text. Quality depends heavily on retrieval, chunking, and eval coverage.

**See also:** [Project 2 — RAG / LLM service](../../career-project-specs/02-rag-llm-service.md); [LLMs handbook](llms.md)

### Rate limiting (429)

Rate limiting rejects excess traffic, typically with HTTP 429 Too Many Requests and often a Retry-After header. Limits may apply per IP, tenant, or API key depending on fairness goals. It protects your service and upstream dependencies from abuse and accidental overload.

**See also:** [Project 23 — Rate limiter gateway](../../career-project-specs/23-rate-limiter-gateway-lab.md); [Production readiness — rate limits](../../checklists/production-readiness.md)

### Reconcile loop

A reconcile loop is a control pattern: observe current state, diff it against desired state, act to close the gap, then requeue until stable. It is the core of Kubernetes controllers and many operators. The loop is idempotent—running it again when nothing changed should be a no-op.

**See also:** [Project 17 — K8s controller](../../career-project-specs/17-k8s-controller-lab.md)

### Resource group (Azure)

A resource group is a container for Azure resources that share a lifecycle—delete the group and its Postgres, Container App, and Key Vault go together. Create one per lab environment (e.g. `rg-playbook-dev`) for easy cleanup after AI-200 exercises.

**See also:** [Azure cloud and AI — hierarchy](azure-cloud-and-ai.md#subscription-and-resource-hierarchy)

### Replication lag / read replica

A read replica is a copy of the primary database that serves read queries to scale read traffic. Replication lag is the delay before a write on the primary appears on the replica—reads may be stale during that window. Under CAP vocabulary, favoring availability and partition tolerance often means accepting eventual consistency on replicas; do not route "must be fresh" reads to a lagging replica without checking.

**See also:** [Database design — Replication and read scaling](database-design.md#replication-and-read-scaling); [Eventual consistency](#eventual-consistency)

### REST

REST (Representational State Transfer) is a common style for HTTP APIs: resources at URLs, HTTP methods (GET, POST, PUT, PATCH, DELETE) with conventional meaning, and status codes that communicate outcome. It is often paired with JSON bodies and stateless servers. REST is a set of constraints and conventions, not a single RFC you can compliance-test against.

**See also:** [REST](software-engineering.md#rest)

### Retry

Retry means trying a failed operation again, usually after a transient error like a timeout or 503. Retries must pair with timeouts, backoff, and idempotency for mutating calls—otherwise you amplify load or duplicate side effects. Not every error is retryable; 4xx client errors usually are not.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Reverse proxy

A reverse proxy sits in front of your application and terminates TLS, routes paths, buffers slow clients, and may load-balance to multiple upstreams. Examples include nginx, Envoy, and cloud load balancers. Clients see one host; the proxy fans out to the actual app servers.

**See also:** [Project 18 — Proxy / load balancer](../../career-project-specs/18-proxy-load-balancer-lab.md); [Servers and networking](servers-and-networking.md)

### Row-Level Security (RLS)

Row-Level Security (RLS) is a Postgres feature where the database enforces row filters per role or session— for example `tenant_id = current_setting('app.tenant_id')`. It adds defense in depth when application code forgets a `WHERE` clause. Tradeoffs include policy complexity, migration discipline, and connection/session setup to set tenant context on every request.

**See also:** [Database design — Data and access security](database-design.md#data-and-access-security); [Multi-tenancy / tenant isolation](#multi-tenancy--tenant-isolation); [Architecture framework — Pillar 3](architecture-framework.md#pillar-3--data-architecture)

---

## S

### SAST (Static Application Security Testing)

SAST (Static Application Security Testing) scans source code—and sometimes configuration—without executing the application. It finds classes of bugs like injection sinks and hard-coded secrets early in CI (Continuous Integration), often called "shifting left." SAST produces false positives, so teams tune rules and triage findings rather than blocking on every warning.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### SOLID

SOLID is five object-oriented design principles: **S**ingle responsibility (one reason to change), **O**pen/closed (extend without modifying), **L**iskov substitution (subtypes honor contracts), **I**nterface segregation (small focused interfaces), **D**ependency inversion (depend on abstractions). They guide maintainable modules—not rules to recite in every CRUD app, but vocabulary for why you inject dependencies or split god objects.

**See also:** [SOLID](software-engineering.md#solid); [Dependency injection](#dependency-injection)

### SSE and WebSocket

SSE (Server-Sent Events) is one-way HTTP push from server to browser with automatic reconnect—good for live dashboards and LLM token streams. WebSockets are full-duplex persistent connections—better for chat, games, and high-frequency bidirectional updates. Both avoid polling; choose based on directionality, infrastructure support, and scale (WebSocket fan-out is harder than SSE behind standard HTTP proxies).

**See also:** [Servers and networking — WebSockets](servers-and-networking.md); [Project 13 — Real-time dashboard](../../career-project-specs/13-realtime-dashboard-lab.md)

### Saga

A saga is a long business process split into local steps with compensating actions—refund if shipment fails, cancel reservation if payment fails. It implements distributed transactions without one giant two-phase commit across services. Sagas require explicit design for partial failure and human intervention on stuck states.

**See also:** [Event-driven integration — saga](software-engineering.md#event-driven-integration)

### Subscription (Azure)

An Azure subscription is the billing and quota boundary under your tenant—where usage meters and cost reports roll up. Lab work often uses one subscription with a free tier or Visual Studio benefit; production orgs may have many subscriptions by team or environment.

**See also:** [Azure certification track](../career/azure-certification-track.md); [Azure cloud and AI](azure-cloud-and-ai.md#subscription-and-resource-hierarchy)

### SemVer (semantic versioning)

SemVer (Semantic Versioning) uses version numbers like `MAJOR.MINOR.PATCH`. Bump major when you break compatibility for consumers who rely on the contract, minor for backward-compatible features, and patch for backward-compatible fixes. Clear versioning lets clients decide when upgrading is safe.

**See also:** [Versioning and compatibility](software-engineering.md#versioning-and-compatibility)

### SLA / SLO / SLI

An SLI (Service Level Indicator) is what you measure—latency, error rate, availability. An SLO (Service Level Objective) is an internal target built on SLIs, such as "99.9% of requests under 300ms." An SLA (Service Level Agreement) is a customer-facing promise with consequences if you miss it. SLOs drive engineering priorities; SLAs drive contracts.

An **error budget** is the allowed unreliability before you must stop shipping risky changes—if your SLO is 99.9% availability, you have roughly 0.1% downtime budget per window. When the budget is exhausted, teams focus on stability over new features until metrics recover. Error budgets connect product velocity to operational risk in a measurable way.

**See also:** [Observability — SLI / SLO / SLA](software-engineering.md#observability-logs-metrics-traces); [Architecture checklist — success metrics](../../checklists/architecture-checklist.md)

### Session vs JWT (tradeoffs)

A **session** stores server-side state keyed by an opaque cookie—the server can revoke access instantly by deleting the session. A **JWT** carries signed claims in the token itself—stateless for the server but revocation requires short TTL, refresh tokens, or a denylist. Sessions suit traditional web apps with cookie auth; JWTs suit SPAs and service-to-service calls. Multi-tenant apps often put `tenant_id` in either model but must scope every query regardless.

**See also:** [JWT (JSON Web Token)](#jwt-json-web-token); [Auth and tenancy](software-engineering.md#auth-and-tenancy); [Project 12 — Multi-tenant auth](../../career-project-specs/12-multi-tenant-auth-lab.md)

### Strangler-fig pattern

The strangler-fig pattern gradually replaces a legacy system by routing slices of traffic to new services while the old system still runs. New features go to the new path; old paths shrink over time until you decommission the legacy stack. It reduces big-bang migration risk compared to a full rewrite.

**See also:** [Architecture checklist — brownfield vs greenfield](../../checklists/architecture-checklist.md); [Systems integration architect](systems-integration-architect.md)

### Shift-left

Shift-left means catching defects earlier in the lifecycle—design reviews, CI (Continuous Integration), SAST (Static Application Security Testing)—when they are cheaper to fix than in production. It is a mindset about feedback loops, not a specific tool. The opposite failure mode is discovering security or integration bugs only after release.

**See also:** [Security for applications — SAST/DAST](software-engineering.md#security-for-applications)

### Sliding window (rate limiting)

Sliding window rate limiting counts requests in a rolling time window rather than a fixed window that resets abruptly at each minute boundary. It produces smoother enforcement—no sudden "free burst" at the top of every hour. Implementation cost is slightly higher than a fixed window but behavior is fairer under steady load.

**See also:** [Project 23 — Rate limiter gateway](../../career-project-specs/23-rate-limiter-gateway-lab.md)

### SOAP

SOAP (Simple Object Access Protocol) is an older XML-heavy style of web services, still common in some enterprises and government integrations. Requests and responses are envelope-shaped XML documents with strict schemas. Teams often compare SOAP with REST plus JSON for greenfield APIs.

**See also:** [SOAP and WS-style services](software-engineering.md#soap-and-ws-style-services)

### Stateless (service)

A stateless service does not rely on in-memory session data tied to one machine between requests. Session state lives in a shared store or signed token so any instance can handle the next request. Statelessness simplifies horizontal scaling and rolling deploys—core to REST and twelve-factor apps.

**See also:** [REST — stateless](software-engineering.md#rest); [Twelve-factor app (12-factor)](#twelve-factor-app-12-factor)

### Stub (test double)

A stub is a test double that returns canned answers without a full implementation—lighter than a fake. Unlike a mock, it usually does not record or assert how it was called. Use stubs when you only need predictable responses, not interaction verification.

**See also:** [Testing — doubles](software-engineering.md#testing)

---

## T

### Twelve-factor app (12-factor)

The twelve-factor app is a checklist for cloud-native services: config in environment, stateless processes, logs as event streams, disposability, dev/prod parity, and explicit dependency declaration among others. It aligns with horizontal scaling, CI/CD, and treating backing services as attached resources. "Stateless service" in this glossary is one slice of the same philosophy.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery); [Stateless (service)](#stateless-service)

### Technical debt

Technical debt is work you postpone—often for speed—that carries ongoing cost in maintenance, bugs, and slower feature delivery. Like financial debt, the "interest" compounds until you pay it down with refactors, tests, or rewrites. Not all debt is bad; intentional debt with a repayment plan differs from accidental mess.

**See also:** [Complexity, change, and technical debt](software-engineering.md#complexity-change-and-technical-debt)

### Tail latency

Tail latency is the slow end of your latency distribution—the p95, p99, and beyond. It often dominates user experience and SLO (Service Level Objective) breaches even when the average looks fine. Optimizing averages while ignoring the tail is a common performance blind spot.

**See also:** [p50 / p95 / p99](#p50--p95--p99-latency-percentiles)

### Thundering herd

A thundering herd is when many clients retry at once when a service recovers, overwhelming it again before it stabilizes. Jittered backoff and circuit breakers reduce the stampede by spreading retries and stopping calls to still-unhealthy dependencies. Cache expiry and cron jobs can cause similar synchronized load spikes.

**See also:** [Jitter](#jitter); [Circuit breaker](#circuit-breaker)

### Timeout

A timeout is a limit on how long to wait for an I/O call—HTTP, database, RPC (Remote Procedure Call)—before giving up. Without timeouts, slow dependencies can pile up threads or connections and take down your service. Set timeouts slightly below client-facing deadlines so you fail fast and return a useful error.

**See also:** [Sync HTTP callers](software-engineering.md#sync-http-callers)

### Trace (distributed tracing)

A distributed trace is a tree of spans showing how a request moved through services—each span is one unit of work with timing and metadata. Tracing is essential for finding latency in microservice setups where logs alone cannot reconstruct the full path. OpenTelemetry is the common instrumentation standard.

**See also:** [Observability: logs, metrics, traces](software-engineering.md#observability-logs-metrics-traces)

### Token bucket (rate limiting)

A token bucket rate limiter refills tokens at a steady rate; each request spends one token. It allows controlled bursts while capping average rate over time—unlike a strict fixed window that rejects everything once the count is hit. Token buckets are a standard algorithm in API gateways and sidecar proxies.

**See also:** [Project 23 — Rate limiter gateway](../../career-project-specs/23-rate-limiter-gateway-lab.md)

---

## U

### Unit test

A unit test is a fast, narrow test of one module or function, usually without real network or database I/O. It pinpoints logic bugs quickly and runs on every save or commit. Unit tests work best when code has clear inputs, outputs, and minimal hidden dependencies.

**See also:** [Testing](software-engineering.md#testing)

### UTF-8

UTF-8 (Unicode Transformation Format, 8-bit) is the encoding you should usually use for text on the web and in modern systems. It is variable-width and supports virtually all written languages in one byte stream. Mixing encodings without explicit conversion is a classic source of mojibake and subtle bugs.

**See also:** [Internationalization and encoding](software-engineering.md#internationalization-and-encoding)

---

## V

### Virtual Network (VNet)

A Virtual Network (VNet) is your private network slice in Azure—subnets, private IPs, and routing rules for resources that should not be public on the internet. Container Apps and Postgres often integrate with VNet endpoints for private connectivity; AZ-900 covers VNet basics with load balancers and NSGs.

**See also:** [Servers and networking](servers-and-networking.md); [Azure Load Balancer](#azure-load-balancer)

### Versioning (API)

API versioning is how you signal breaking changes to clients—for example `/v1/` in the URL, a version header, or content negotiation. The goal is to let existing integrations keep working while new clients adopt improved contracts. Versioning strategy should be documented before you ship your first external API.

**See also:** [Versioning and compatibility](software-engineering.md#versioning-and-compatibility)

---

## W

### Webhook

A webhook is an HTTP callback another system invokes on your URL when something happens—a payment succeeded, a commit was pushed, a form was submitted. Treat deliveries as at-least-once: verify signatures, respond quickly with a fast ack, and process idempotently in the background. Webhooks invert the usual polling model and push work to you.

**See also:** [GraphQL, gRPC, and webhooks](software-engineering.md#graphql-grpc-and-webhooks)

### WAF (Web Application Firewall)

A WAF (Web Application Firewall) sits in front of HTTP traffic and blocks common attack patterns—SQL injection probes, scripted scans, oversized payloads—before they reach your app. Cloud providers and CDNs often offer managed WAF rules. A WAF complements secure coding; it does not replace authorization checks in application code.

**See also:** [Servers and networking — WAF](servers-and-networking.md); [Security for applications](software-engineering.md#security-for-applications)

### Worker

A worker is a process that pulls jobs from a queue or scheduler and does slow work outside the request/response path. Workers handle PDF generation, email sends, index updates, and anything that should not block an HTTP response. Scaling workers independently from web servers is a common async architecture pattern.

**See also:** [Integration: sync, async, and messaging](software-engineering.md#integration-sync-async-and-messaging)

---

## X

### XSS (Cross-Site Scripting)

XSS (Cross-Site Scripting) is injecting script into pages that other users will see—often via unsanitized user input rendered as HTML. Defenses include contextual escaping, Content Security Policy (CSP), and safe templating that treats user data as text by default. Stored XSS in a comment field is a classic example.

**See also:** [Security for applications](software-engineering.md#security-for-applications)

### XML

XML (Extensible Markup Language) is a verbose text format with nested tags and attributes. It is common in SOAP (Simple Object Access Protocol) services and some enterprise integrations, especially where schemas and tooling predated JSON. Compared with JSON, XML is heavier on the wire and harder to read by hand.

**See also:** [SOAP and WS-style services](software-engineering.md#soap-and-ws-style-services)

---

## Y

### YAML

YAML (YAML Ain't Markup Language) is a human-readable config format based on indentation, often used for CI (Continuous Integration) pipelines and Kubernetes manifests. Indentation errors are the most common footgun—tabs vs spaces break parsers silently or with cryptic errors. Many teams validate YAML in CI before apply.

**See also:** [Command-line tooling](command-line-tooling.md)

---

## Z

### Zero-downtime deployment

Zero-downtime deployment means shipping new versions without taking the service offline for users. Common techniques include blue-green deploys, canary rollouts, and rolling updates where instances drain gracefully before replacement. True zero downtime also requires backward-compatible schema and API changes during the transition.

**See also:** [CI/CD and delivery](software-engineering.md#cicd-and-delivery)
