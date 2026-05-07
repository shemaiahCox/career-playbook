# Stacks: term cards and ecosystem maps

## New here? Read this once

Learning “a **stack**” means learning a **whole neighborhood of tools**: a language *plus* how people usually run it, bundle it, talk to databases, and ship it. One word (“Python,” “Laravel,” “Next.js”) secretly stands for fifty smaller pieces—that is normal.

These pages stay **short on purpose**. They look like shorthand because they **are shorthand**: reminders for someone who already met the words once.

**If the tables felt confusing, you are doing it right.**

Try this gentle order:

1. **Slow path** — Open the **[stacks glossary](glossary.md)** (one-page map of links) **or** jump to **“Plain language: terms used on this page”** at the bottom of any ecosystem note.
2. **When a word matters for design or correctness** — Open [Software engineering breadth](../handbook/software-engineering.md) and search the term (examples: **idempotency**, **Isolation**, **API contracts**). The handbook carries the longer explanations; stack pages only point.
3. **When you learn by building** — Use [project specs](../../project-specs/) first; stack notes are backup when a spec mentions something you never heard before.

Words used on this README:

| Says | Means in plain English |
|------|------------------------|
| **Term card** | A tiny worksheet: definition, why it matters, one example, how it bites you. Use it in your **own notes** or when adding ideas to [Software engineering breadth](../handbook/software-engineering.md). |
| **Ecosystem map** | A checklist-style page for **one** language/community (Swift, Laravel, Python, …): what bites newcomers and where to study next. Not a beginner tutorial. |
| **Footgun** | A mistake that feels fine in a demo then hurts in production (leaks, wrong thread, swallowed errors, …). |
| **Load-bearing term** | A word that changes **architecture** when you misunderstand it—not trivia. Spend real time there. |

Older readers: dense ideas (MVVM, generics, **main thread**) are easier to reuse when every entry follows the same small shape—whether stack-agnostic or in one ecosystem note.

---

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

## Where the deeper explanations live

The main breadth document is [Software engineering](../handbook/software-engineering.md) (TOC includes concurrency, patterns, integration, testing, security, and more). Use its **Basic / Intermediate / Advanced** bands when you deepen a term.

**Concrete starting points (full understanding, not search-and-hope):** [Integration + idempotent webhook example](../handbook/software-engineering.md#integration-sync-async-and-messaging) · [Concurrency basics](../handbook/software-engineering.md#concurrency-basics) · [Database design — N+1 pattern](../handbook/database-design.md#orms-and-the-n1-query-pattern). Each ecosystem map’s **Read next (handbook)** block at the bottom tailors links to that page’s vocabulary.

## Ecosystem maps (optional, short)

Maps stay **≤2 pages**: modules, tests, typical async/DI patterns, and **how this stack phrases** concepts from the [term-card template](#term-card-template)—not full tutorials.

### Draft maps (this repo)

Quick links—including **Plain language** at the bottom of each file:

| File | Stack |
|------|-------|
| [swift-ios.md](swift-ios.md) | Swift, Apple platforms (SwiftUI/UIKit, ARC, concurrency) |
| [kotlin-android.md](kotlin-android.md) | Kotlin — Android primary, short JVM/server lane |
| [nextjs-react-typescript.md](nextjs-react-typescript.md) | Next.js + React + TypeScript (one web lane) |
| [csharp-dotnet.md](csharp-dotnet.md) | C# / .NET — backend-shaped (ASP.NET Core, DI, async) |
| [php-laravel.md](php-laravel.md) | PHP + Laravel (Composer, HTTP/queues, Eloquent, Octane) |
| [python.md](python.md) | Python — venv/packaging, asyncio vs sync, FastAPI-shaped APIs |
| [sql.md](sql.md) | SQL / relational engines — transactions, plans, migrations (paired with [database design](../handbook/database-design.md)) |

**One-page index of “where is plain English?”:** [Stacks glossary →](glossary.md)

Add a separate **`php.md`** only if you often ship **non-Laravel** PHP.
