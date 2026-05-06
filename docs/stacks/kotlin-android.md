# Ecosystem map: Kotlin (Android-first, JVM note)

**Use this:** **Android** is the primary frame below. **Server/JVM Kotlin** (Ktor, Spring) differs mainly in **runtime and I/O** — see the short **JVM lane** at the end.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md)

---

## Android lane (primary)

### Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | Art VM; **Kotlin** interoperates with **Java** and Android SDK (two languages, one APK). |
| **Build** | **Gradle** (Kotlin DSL or Groovy); **AGP** versions pin what APIs you get. |
| **UI** | **Jetpack Compose** (declarative) vs **XML + Views** (imperative); both coexist in migration. |
| **Structure** | **Modules** (`app`, `feature-*`, `core-*`); **Gradle flavors/build types** for env-specific behavior. |

### Concurrency & lifecycle

- **Coroutines** + **Dispatchers** (`Main`, `Default`, `IO`): **never block Main** for disk/network.
- **`lifecycleScope` / `viewModelScope`**: coroutines **tied to lifecycle** so work does not outlive UI.
- **Flows / StateFlow** for reactive state; collect in **lifecycle-aware** collectors (repeatOnLifecycle).

### “Memory leaks” on Android

- **`Context` leaks** (holding Activity/Context past teardown) — a top cause of retaining entire screens.
- **Listeners, Handlers, static refs** to Views or Activities.
- **Compose:** remember **where state lives** (ViewModel vs composable)- Avoid **remember** holding stale heavy objects.

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

## See also

- Gradle + Android **version catalogs** for reproducible builds.
- Compose **Navigation** + ViewModel ownership per graph.
