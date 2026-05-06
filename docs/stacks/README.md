# Stacks: term cards and ecosystem maps

Dense ideas (MVVM, idempotency, generics, “main thread,” …) are easier to reuse when every entry follows the same small shape—whether stack-agnostic or in a specific ecosystem note.

## Term card template

Use this in your own notes or when extending handbook pages.

| Block | Purpose |
|-------|---------|
| **Definition** | One or two sentences—in *your* words. |
| **When it matters** | “You care when …” (design, review, or interview). |
| **Minimal example** | One short snippet (5–15 lines); **pseudocode is OK** for portable ideas. |
| **Failure mode or tradeoff** | What breaks or what it costs (required—otherwise the term is trivia). |
| **See also** (optional) | One link into [software engineering breadth](../handbook/software-engineering.md) or another handbook page. |

## Rules for a polyglot playbook

- **One canonical example** per *pattern* (e.g. MVVM). Add a single **comparative line** for other stacks (“Android often …”) instead of three full codebases.
- **Tutorials belong in labs** ([project-specs/](../../project-specs/)); this folder is for **vocabulary and pointers**.

## Where the grown-up explanations live

The main breadth document is [Software engineering](../handbook/software-engineering.md) (TOC includes concurrency, patterns, integration, testing, security, and more). Use its **Basic / Intermediate / Advanced** bands when you deepen a term.

## Ecosystem maps (optional, short)

Add **≤2 pages** per ecosystem when you need them: modules, tests, typical async/DI story, and **how the stack expresses** concepts from the [term card template](#term-card-template)—not full tutorials. Keep each map file under ~2 pages.

### Draft maps (this repo)

| File | Stack |
|------|-------|
| [swift-ios.md](swift-ios.md) | Swift, Apple platforms (SwiftUI/UIKit, ARC, concurrency) |
| [kotlin-android.md](kotlin-android.md) | Kotlin — Android primary, short JVM/server lane |
| [nextjs-react-typescript.md](nextjs-react-typescript.md) | Next.js + React + TypeScript (one web lane) |
| [csharp-dotnet.md](csharp-dotnet.md) | C# / .NET — backend-shaped (ASP.NET Core, DI, async) |
| [php-laravel.md](php-laravel.md) | PHP + Laravel (Composer, HTTP/queues, Eloquent, Octane) |
| [python.md](python.md) | Python — venv/packaging, asyncio vs sync, FastAPI-shaped APIs |
| [sql.md](sql.md) | SQL / relational engines — transactions, plans, migrations (paired with [database design](../handbook/database-design.md)) |

Add a separate **`php.md`** only if you often ship **non-Laravel** PHP.
