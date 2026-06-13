# Template — language ecosystem map

Use this outline for every file in [`docs/languages/`](../languages/). Readers go **top to bottom**; syntax side-by-side lives in [`language-fundamentals-comparison.md`](../languages/language-fundamentals-comparison.md).

**Depth:** Playbook-practical — one table or ≤12 lines per setup section; no full tutorials.

---

## Section order (H2 headings)

Copy these H2 titles in order. Keep **`#plain-language-terms-used-on-this-page`** anchor on section 9 for [`glossary.md`](../languages/glossary.md) links.

### 1. Use this

- One sentence: who should read this and when (playbook project context).
- **Companion:** docs README · relevant spec(s) · unfamiliar-stack checklist if applicable.
- **New here?** link to plain language section + glossary.

### 2. Best for, alternatives, and playbook fit

Single table:

| Best for | Use instead when | Primary projects |
|----------|------------------|------------------|

Merge any old “When X vs Y” / “What to practice” content here—no duplicate comparison sections later.

### 3. How it runs

Short table:

| Execution | Typing | Memory / concurrency |
|-----------|--------|----------------------|

One line each: compiled vs interpreted, static vs dynamic, GC vs ownership, threads vs event loop, etc.

### 4. Environment setup

Numbered or bulleted steps:

1. Install / version manager + verify command
2. Create new project (one copy-paste command)
3. Lockfile / dependency habit
4. Optional: link to playbook lab clone path

### 5. Project layout

ASCII tree (8–12 lines max) with one-line role per folder/file.

### 6. Commands you'll use often

| Intent | Command | Notes |
|--------|---------|-------|
| Run dev | … | … |
| Test | … | … |
| Build / lint | … | … |

### 7. How concepts show up

Playbook-specific: HTTP, queues, observability, security, ORM, LLM boundaries—keep existing depth from prior map versions.

### 8. Footguns

Checklist of production mistakes for this stack.

### 9. Plain language: terms used on this page

Glossary for jargon on **this page only**. Preserve heading exactly for glossary index links.

### 10. See also

- Handbook sections
- [`language-fundamentals-comparison.md`](../languages/language-fundamentals-comparison.md) for syntax
- Adjacent stack maps (Go ↔ Python, SQL, etc.)

---

## SQL variant

Sections 3–6 adapt for SQL (no runtime/compiler):

- **How it runs:** declarative, dialect, schema vs ad-hoc queries
- **Environment setup:** Docker Compose / `psql`, connection string
- **Project layout:** `migrations/`, `exercises/`, seeds
- **Commands:** `psql`, `EXPLAIN ANALYZE`, meta-commands

---

## Maintainer checklist

- [ ] No duplicate “When X vs Y” block outside section 2
- [ ] Commands are copy-paste safe
- [ ] Plain language anchor unchanged
- [ ] Cross-links to specs use current Project N numbers
