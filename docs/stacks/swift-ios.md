# Ecosystem map: Swift (Apple platforms)

**Use this:** You are shipping or reviewing **iOS / iPadOS / macOS / visionOS** code (SwiftUI or UIKit) and need **vocabulary + footguns**, not a language course.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) · [Software engineering breadth](../handbook/software-engineering.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | Swift compiles to native code using **Automatic Reference Counting (ARC)** to free unused **class instances**; **structs/enums behave like values** copied by default (helps avoid accidental sharing). |
| **Packaging** | **Swift Package Manager (SPM)** pulls modules; Xcode projects/workspace still wrap real apps shipped to testers; **CocoaPods** survives in older apps adding dependencies differently. |
| **UI stack** | **SwiftUI**: describe UI as state-driven trees (**declarative**). **UIKit**: push view controllers explicitly (**imperative**). Brownfield mixes both. |
| **Entry** | `@main App` launches SwiftUI; classic UIKit launches via **`UIApplicationMain`**. Apps move through **scene lifecycle** milestones (foreground, background, memory warnings). |

---

## How “systems” concepts show up

**Concurrency**

- **`async`/`await`** and **Swift 6 strict concurrency** (actors, `Sendable`, isolation) are the modern default.
- **MainActor** bounds UI work: assume **UI and many framework callbacks** expect the main actor unless proven otherwise.
- **Combine** and **GCD** still appear in older code; map mentally to “who guarantees thread safety?”

**Ownership / “memory leaks”**

- ARC **does not** prevent cycles: **strong reference cycles** between two class instances (or closures capturing `self` strongly).
- Fix patterns: **`weak`** / **`unowned`** on one side, or **`[weak self]`** in async/closures, or break the cycle structurally.
- **Timers, KVO, NotificationCenter, delegates** — if one side is strongly held, design an explicit teardown path.

**State (SwiftUI)**

- Source of truth: **`@State`**, **`@Observable`** / **`ObservableObject`**, environment, navigation stack.
- **“Derived state” bugs** = views reading stale data because ownership of updates is unclear.

**Persistence / I/O**

- **FileManager / app sandbox**; **Keychain** for secrets (not UserDefaults for tokens).
- **Core Data / SwiftData** → migrations and merge policies are architectural decisions.

---

## Footgun checklist (scan before ship)

- [ ] No **main-thread violation** for UI mutation (instruments / runtime warnings).
- [ ] **Retain cycles** audited in delegates, closures, parent–child object graphs.
- [ ] **Scene / view lifecycle** — long-running work cancelled or moved off UI when views tear down.
- [ ] **Concurrency warnings** (Swift 6) not ignored wholesale — they often encode real races.

---

## Plain language: terms used on this page

Apple’s vocabulary stacks fast—this section is the **decoder ring** for the tables above.

- **ARC** — Swift counts references to objects; when nothing points at an instance, it frees—**no manual `free()`**, but loops still bite you.
- **Value type (struct / enum)** — Passed by copying small data—helps avoid unintended shared mutations.
- **SwiftUI vs UIKit** — Two UI architectures; migrating apps often weld both temporarily.
- **SPM vs CocoaPods vs Xcodeproj** — Three ways Swift teams manage dependencies/apps—expect to see SPM + Xcode everywhere new.
- **Scene lifecycle / memory warnings** — OS tells app when user backgrounds you or RAM is tight—tear down timers/subscriptions politely.
- **`async` / `await` / `@MainActor` / isolation** — Modern concurrency divides work onto actors; **`MainActor`** is “the lane where touching UI is legal.”
- **`Sendable` / actors / strict concurrency warnings** — Compiler checks that concurrent tasks don’t pass unsafe shared mutable state around.
- **Combine / GCD** — Older async toolkits—“who owns which queue?” stays the mantra when reading mature codebases.
- **Strong reference cycles / leaks** — Two objects grabbing each other keep memory alive indefinitely—classic UI bug.
- **`weak` / `unowned` / `[weak self]`** — Break cycles by not holding mutual strong refs (choose carefully—`unowned` crashes if the partner vanished).
- **KVO / NotificationCenter / delegates / timers** — Callback mechanisms that keep objects alive unless you unregister intentionally.
- **`@State` / `@Observable` / `ObservableObject` / navigation stack** — SwiftUI knobs for remembering UI state—and **who updates it**.
- **`FileManager`, sandboxed storage, Keychain** — Persistence layers; **never store long-lived secrets in `UserDefaults`**.

### Read next (handbook)

- **[Concurrency basics](../handbook/software-engineering.md#concurrency-basics)** — UI thread discipline (maps to **MainActor** rules above).
- **[Security for applications](../handbook/software-engineering.md#security-for-applications)** — TLS, secrets handling, OWASP headings when apps call your APIs.
- **[Example: idempotent webhook or job](../handbook/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — integrations your app consumes or your backend exposes.
- **[GraphQL, gRPC, and webhooks](../handbook/software-engineering.md#graphql-grpc-and-webhooks)** — outbound webhook client concerns (signatures, retries).

---

## See also

- Apple: *Concurrency*, *SwiftUI state*, *Memory management* (official docs).
- This repo: integration/security themes still apply if the app calls **your** APIs (signatures, TLS, token storage).
