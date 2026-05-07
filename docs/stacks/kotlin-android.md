# Ecosystem map: Kotlin (Android-first, JVM note)

**Use this:** **Android** is the primary frame below. **Server/JVM Kotlin** (Ktor, Spring) differs mainly in **runtime and I/O** — see the short **JVM lane** at the end.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Android lane (primary)

### Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | Code runs on Android’s **ART** virtual machine; **Kotlin** and **Java** libraries often live together in one **APK** (the installable app package). |
| **Build** | **Gradle** is the build tool (scripts in Kotlin or Groovy); **AGP** (Android Gradle Plugin) version locks which Android build features you can use. |
| **UI** | **Jetpack Compose** builds UI with **declarative** descriptions (“draw this when state is X”); **XML + Views** is the older **imperative** style—many apps mix both while migrating. |
| **Structure** | **Modules** split code (`app`, `feature-*`, `core-*`); **flavors / build types** swap config for dev vs prod without copy-paste. |

### Concurrency & lifecycle

- **Coroutines** + **Dispatchers** (`Main`, `Default`, `IO`): **never block Main** for disk/network.
- **`lifecycleScope` / `viewModelScope`**: coroutines **tied to lifecycle** so work does not outlive UI.
- **Flows / StateFlow** for reactive state; collect in **lifecycle-aware** collectors (repeatOnLifecycle).

### “Memory leaks” on Android

- **`Context` leaks** (holding Activity/Context past teardown) — a top cause of retaining entire screens.
- **Listeners, Handlers, static refs** to Views or Activities.
- **Compose:** remember **where state lives** (ViewModel vs composable). Avoid **`remember`** holding stale heavy objects.

### Networking & data

- **Retrofit/OkHttp** stack is common; **certificate pinning** and timeouts are product decisions.
- **Room** migrations must be **planned** like any schema evolution (see [database design](../handbook/database-design.md) mindset).

---

## JVM / server Kotlin (short lane)

| Android | JVM server |
|---------|------------|
| Main = UI thread | No “main UI” — use **thread pools**, **blocking vs reactive** choice per stack |
| `Dispatchers.Main` | `Dispatchers.IO` / Vert.x / netty threads — follow **framework rules** |
| APK boundaries | **JAR/service** boundaries, **12-factor** config, **DB pools** |

**Ktor / Spring:** async style differs; same **idempotency, transactions, observability** rules as any backend (see project specs).

---

## Footgun checklist

- [ ] Coroutines **scoped** (not fire-and-forget globals) for UI-related work.
- [ ] **Context** usage — prefer **`applicationContext`** when a long-lived ref needs Context; avoid leaking Activity.
- [ ] **ProGuard/R8** — release builds strip/optimize; crashes that only happen in release often map here.

---

## Plain language: terms used on this page

Google throws a lot of names at newcomers—focus on **ideas**, not trivia.

- **ART** — Android’s runtime executing your bytecode on device—not something you micromanage daily, but “where code runs.”
- **Kotlin / Java interop** — Old Android code is Java; new code is Kotlin; they call each other inside one APK.
- **Gradle / AGP** — Scripts that compile, package, and sign the app—the Android Gradle Plugin upgrades track new platform APIs.
- **Compose vs XML Views** — Two UI toolkits; Compose is newer and state-driven.
- **Module** — Gradle sub-project so features stay isolated (`:app`, `:feature-login`, …).
- **Flavor / build type** — “debug vs release” layers or “free vs paid” shapes without duplicating the whole codebase.
- **Coroutine** — Kotlin’s structured async—think “cheap tasks you can pause.”
- **Dispatcher (Main vs IO vs Default)** — Which shared thread pool runs the work (**Main** = UI lane—never block it on network!).
- **`lifecycleScope` / `viewModelScope`** — Coroutines cancelled when the UI or ViewModel is torn down—stops stray work leaking after leaving a screen.
- **Flow / StateFlow** — Kotlin streams for reacting to data changing over time.
- **`repeatOnLifecycle`** — Compose/Android helper so collectors obey screen visibility—fewer crashes from updating dead UI.
- **Context leak** — Holding Android `Context` (especially an **Activity**) after the UI closed—often keeps a whole UI tree in RAM.
- **Retrofit / OkHttp** — Common HTTP stack (declarative API client + plumbing underneath).
- **Certificate pinning / timeouts** — Security and reliability choices for HTTPS calls—not “automatically correct.”
- **Room** — SQLite wrapper with migrations—schema changes deserve the same seriousness as backend DB migrations.
- **JVM lane** — When Kotlin runs **without Android UI**, you pick normal server concurrency models (threads, reactive stacks, etc.).
- **12-factor config** — Keep environment/secrets/config outside baked artifacts—borrowed mantra from cloud-native lore.
- **ProGuard / R8** — Release step shrinks and obfuscates code—stack traces become harder unless you ship mapping files.

### Read next (handbook)

- **[Concurrency basics](../handbook/software-engineering.md#concurrency-basics)** — main/UI lane vs workers (matches **Dispatchers** above).
- **[Async sketch — table](../handbook/software-engineering.md#async-sketch)** — see Java/Kotlin-ish server defaults in the playbook’s coarse map.
- **[Example: idempotent webhook or job](../handbook/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — mobile apps still call flaky HTTP APIs—same replay discipline.
- **[Observability: logs, metrics, traces](../handbook/software-engineering.md#observability-logs-metrics-traces)** — correlation across device + backend.

---

## See also

- Gradle + Android **version catalogs** for reproducible builds.
- Compose **Navigation** + ViewModel ownership per graph.
