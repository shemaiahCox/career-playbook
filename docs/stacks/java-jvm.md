# Ecosystem map: Java / JVM (backend-shaped)

**Use this:** You read or ship **HTTP APIs**, **workers**, or **batch jobs** on the **JVM**—usually **Java** with **Spring Boot** at startups and enterprises, sometimes **Kotlin** on the server (see [JVM / server Kotlin (short lane)](kotlin-android.md#jvm--server-kotlin-short-lane) in the Android-first map). This page is **vocabulary + footguns**, not a Spring tutorial.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **JVM** executes **bytecode** (.class); **JDK** = dev kit; **JRE** (historically) = runtime only—modern JDK-only packaging is common. **GC** manages heap; **tuning** matters at scale but interviews start at **heap vs stack** and **stop-the-world pauses** as concepts. |
| **Build** | **Maven** (`pom.xml`, lifecycle phases `compile`, `test`, `package`) vs **Gradle** (Kotlin/Groovy DSL, tasks). Both resolve **coordinates** (`group:artifact:version`) from **Maven Central** (or mirrors). |
| **Spring Boot** | **Convention over configuration**: **starters** pull related deps; **auto-configuration** wires beans when classpath looks “like” a web app or JPA. You still own **profiles** (`application.yml` per env), **security**, and **data** boundaries. |
| **Layering** | **Controller** (HTTP) → **Service** (domain/use case) → **Repository** (data)—names vary; the idea is the same as other backend stacks: keep **HTTP DTOs** from leaking into every layer unchecked. |

---

## How concepts show up

**Dependency injection**

- **Spring** **`@Autowired` / constructor injection** (preferred): **singleton** vs **request-scoped** beans—wrong scope → **stale state** or **captive deps** (same failure family as .NET DI).

**Data access**

- **JPA** (**Hibernate**): entities, **`@OneToMany`** **lazy** loading → **N+1** in HTTP handlers if you touch collections per row—same story as EF Core and Django; see [ORMs and N+1](../handbook/database-design.md#orms-and-the-n1-query-pattern).
- **Transactions:** **`@Transactional`** boundaries—defaults and **rollback** rules bite when exceptions cross layers.

**HTTP**

- **Spring MVC** / **WebFlux** (reactive) are different concurrency models—don’t block reactive pipelines with JDBC unless you use bounded schedulers; know which stack you are on.

**Concurrency**

- **Threads** are the classic JVM server model; **virtual threads** (Project Loom, modern JDK) reduce **blocking I/O** cost—one interview-grade sentence: “cheap parallelism for blocking calls without thread explosion.” Link **[Concurrency basics](../handbook/software-engineering.md#concurrency-basics)** for the general picture.

**Observability**

- **SLF4J** + **Logback** / Log4j2; **Micrometer** metrics; **OpenTelemetry** Java agent—correlation IDs at the servlet/filter or WebFlux filter edge.

**Security**

- **Spring Security** for filter chains, CSRF (for session cookies), OAuth2 resource server patterns—same OWASP vocabulary as other maps; supply chain: **Dependabot** / **Snyk** on Maven coordinates.

---

## Footgun checklist

- [ ] **Null** — `Optional` misuse, **`NullPointerException`** on hot paths; modern **nullable types** in Kotlin help; Java still needs discipline.
- [ ] **Lazy JPA associations** — accidental N+1 when returning entities to JSON serializers; prefer **DTOs** or **fetch joins** where appropriate.
- [ ] **`@Transactional` on private methods** — Spring AOP does not apply—silent “no transaction” surprises.
- [ ] **Prod profile** — `spring.profiles.active` wrong → dev DB credentials or **`ddl-auto`** in prod (schema drift / data loss class risks).
- [ ] **Fat JAR classpath** — duplicate or conflicting deps (“**classpath hell**”); use **`mvn dependency:tree`** or Gradle equivalent when versions fight.
- [ ] **Logging dependencies** — keep libraries **current**; treat **log config** as infrastructure (awareness of historical supply-chain issues in logging stacks).

---

## Plain language: terms used on this page

- **JVM** — Virtual machine that runs Java (and Kotlin, Scala, …) bytecode.
- **JDK** — Java Development Kit: compiler, tools, bundled runtime for dev.
- **Bytecode / .class** — Compiled form the JVM executes; **JAR** = zip of classes + manifest.
- **Maven** — Build tool: **`pom.xml`**, **lifecycle** (e.g. `mvn verify`), **repositories** (Central).
- **Gradle** — Build tool with programmable build scripts; many Spring repos use it.
- **Spring Boot** — Opinionated layer on **Spring**: embedded server, auto-config, **actuator** endpoints for health/metrics in many setups.
- **Starter** — Maven/Gradle dependency bundle (e.g. `spring-boot-starter-web`) that pulls aligned versions.
- **Bean** — Object managed by Spring’s **IoC** container—lifecycle and scope matter.
- **JPA / Hibernate** — Map tables to objects; **lazy** vs **eager** loading drives N+1 behavior.
- **`@Transactional`** — Declarative transactions—proxy-based; must go through Spring-managed beans.
- **WebFlux vs Web MVC** — Reactive (async streams) vs servlet-style thread-per-request—blocking mix footguns.
- **Virtual threads (Loom)** — Lightweight threads mapped to blocking I/O—reduces cost of **blocking** JDBC calls in large counts (JDK+runtime support).
- **SLF4J / Logback / Micrometer** — Logging façade + implementation; metrics façade common in Spring shops.

### Read next (handbook)

- **[Concurrency basics](../handbook/software-engineering.md#concurrency-basics)** — threads, pools, blocking vs async stacks.
- **[Example: idempotent webhook or job](../handbook/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — HTTP integrations.
- **[ORMs and the N+1 pattern](../handbook/database-design.md#orms-and-the-n1-query-pattern)** — Hibernate-shaped access.
- **[Observability: logs, metrics, traces](../handbook/software-engineering.md#observability-logs-metrics-traces)** — production signals.
- **[Security for applications](../handbook/software-engineering.md#security-for-applications)** — OWASP vocabulary.

---

## See also

- [Kotlin / Android + JVM note](kotlin-android.md) — **server Kotlin** lane when you are not on Spring/Java only.
- [C# / .NET](csharp-dotnet.md) — parallel enterprise backend vocabulary (DI, ORM, GC).
- [SQL ecosystem map](sql.md) — JDBC and connection pools sit on top of the same SQL discipline.
