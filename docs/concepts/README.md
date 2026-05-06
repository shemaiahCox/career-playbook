# Concepts: term cards and vocabulary

Dense ideas (MVVM, idempotency, generics, “main thread,” …) are easier to reuse when every entry follows the same small shape.

## Term card template

Use this in your own notes or when extending reference docs.

| Block | Purpose |
|-------|---------|
| **Definition** | One or two sentences—in *your* words. |
| **When it matters** | “You care when …” (design, review, or interview). |
| **Minimal example** | One short snippet (5–15 lines); **pseudocode is OK** for portable ideas. |
| **Failure mode or tradeoff** | What breaks or what it costs (required—otherwise the term is trivia). |
| **See also** (optional) | One link into [software engineering breadth](../reference/software-engineering.md) or another reference doc. |

## Rules for a polyglot playbook

- **One canonical example** per *pattern* (e.g. MVVM). Add a single **comparative line** for other stacks (“Android often …”) instead of three full codebases.
- **Tutorials belong in labs** ([project-specs/](../../project-specs/)); this folder is for **vocabulary and pointers**.

## Where the grown-up explanations live

The main breadth document is [Software engineering](../reference/software-engineering.md) (TOC includes concurrency, patterns, integration, testing, security, and more). Use its **Basic / Intermediate / Advanced** bands when you deepen a term.

**Ecosystem maps:** Short stack-specific vocabulary lives in [ecosystems/](ecosystems/README.md) (Swift, Kotlin, Next.js/React/TS, C#/.NET, PHP/Laravel, **Python**, **SQL**)—keep each under ~2 pages.
