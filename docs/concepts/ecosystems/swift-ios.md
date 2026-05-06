# Ecosystem map: Swift (Apple platforms)

**Use this:** You are shipping or reviewing **iOS / iPadOS / macOS / visionOS** code (SwiftUI or UIKit) and need **vocabulary + footguns**, not a language course.

**Companion:** [term cards](../README.md) · [unfamiliar-stack ship](../../../checklists/unfamiliar-stack-ship.md) · [Software engineering breadth](../../reference/software-engineering.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | Compiled; ARC (**Automatic Reference Counting**) owns memory for class instances. Structs/enums are **value types** (copy semantics). |
| **Packaging** | **Swift Package Manager (SPM)** for modules and deps; **Xcode** projects or workspaces for apps. CocoaPods still exists in legacy codebases. |
| **UI stack** | **SwiftUI** (declarative, state drives view tree) vs **UIKit** (imperative, view controllers). Mixing both in one flow is normal in brownfield apps. |
| **Entry** | `@main` `App` (SwiftUI) or `UIApplicationMain` (UIKit); **scene lifecycle** (foreground/background, memory warnings). |

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

## See also

- Apple: *Concurrency*, *SwiftUI state*, *Memory management* (official docs).
- This repo: integration/security themes still apply if the app calls **your** APIs (signatures, TLS, token storage).
