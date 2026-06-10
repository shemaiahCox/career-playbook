# Stacks: term cards and ecosystem maps

## New here? Read this once

Learning “a **stack**” means learning a **whole neighborhood of tools**: a language *plus* how people usually run it, bundle it, talk to databases, and ship it. One word (“Python,” “Laravel,” “Next.js”) secretly stands for fifty smaller pieces—that is normal.

These pages stay **short on purpose**. They look like shorthand because they **are shorthand**: reminders for someone who already met the words once.

**If the tables felt confusing, you are doing it right.**

Try this gentle order:

1. **Slow path** — Open the **[stacks glossary](glossary.md)** (one-page map of links) **or** jump to **“Plain language: terms used on this page”** at the bottom of any ecosystem note.
2. **When a word matters for design or correctness** — Open [Software engineering breadth](../handbook/software-engineering.md) and search the term (examples: **idempotency**, **Isolation**, **API contracts**). The handbook carries the longer explanations; stack pages only point.
3. **When you learn by building** — Use [project specs](../../career-project-specs/) first; stack notes are backup when a spec mentions something you never heard before.

Words used on this README:

| Says | Means in plain English |
|------|------------------------|
| **Term card** | A tiny worksheet: definition, why it matters, one example, how it bites you. Use it in your **own notes** or when adding ideas to [Software engineering breadth](../handbook/software-engineering.md). |
| **Ecosystem map** | A checklist-style page for **one** stack or pattern (Laravel, Go, Boomi-shaped integration, …): footguns and where to study next. Not a beginner tutorial. |
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

## Rules for this playbook

- **One canonical example** per pattern in career labs; stack maps are vocabulary only.
- **Tutorials belong in labs** ([career-project-specs/](../../career-project-specs/)); this folder points to footguns and handbook depth.

## Where the deeper explanations live

The main breadth document is [Software engineering](../handbook/software-engineering.md) (TOC includes concurrency, patterns, integration, testing, security, and more). Use its **Basic / Intermediate / Advanced** bands when you deepen a term.

**Concrete starting points (full understanding, not search-and-hope):** [Integration + idempotent webhook example](../handbook/software-engineering.md#integration-sync-async-and-messaging) · [Concurrency basics](../handbook/software-engineering.md#concurrency-basics) · [Database design — N+1 pattern](../handbook/database-design.md#orms-and-the-n1-query-pattern). Each ecosystem map’s **Read next (handbook)** block at the bottom tailors links to that page’s vocabulary.

## Ecosystem maps (core stack)

Maps stay **≤2 pages**: modules, tests, async patterns, footguns—not full tutorials.

| File | Stack / pattern |
|------|-----------------|
| [php-laravel.md](php-laravel.md) | PHP + Laravel — HTTP, queues, Eloquent |
| [node-typescript-backend.md](node-typescript-backend.md) | Node.js + TypeScript — HTTP/API services |
| [go.md](go.md) | Go — workers, concurrency, retrieval gateways |
| [rust.md](rust.md) | Rust — Tier‑2 after P9 Go; optional reimplementation, edge stretch |
| [python.md](python.md) | Python — FastAPI, asyncio, RAG-shaped APIs |
| [sql.md](sql.md) | SQL / Postgres — plans, transactions, migrations |
| [integration-automation.md](integration-automation.md) | Boomi / n8n / workflow integration patterns |

**Plain-language index:** [Stacks glossary →](glossary.md)
