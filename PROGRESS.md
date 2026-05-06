# Progress log

## How to use checklists and this log

### Checklists

Use them **when you are close to shipping** a slice (or before you call a lab milestone done)—not as everyday task lists.

- **Inbound webhooks, partner HTTP, sync integration edges** (and HTTP fronts that enqueue later): [checklists/integration-hardening.md](checklists/integration-hardening.md).
- **User-facing model / RAG / tool paths**: [checklists/llm-feature-ship.md](checklists/llm-feature-ship.md).
- **New stack + AI** (you are accountable for concepts, not only the prompt): [checklists/unfamiliar-stack-ship.md](checklists/unfamiliar-stack-ship.md). Workflow: [docs/paths/ai-assisted-unfamiliar-stack.md](docs/paths/ai-assisted-unfamiliar-stack.md).

Walk the sections **top to bottom** once with the repo and env in front of you. You do not have to tick boxes inside the markdown file unless you want to; the point is not skipping whole categories (signatures, idempotency, DLQ, eval regression, PII, timeouts, etc.). If you **defer** a row on purpose, note one line here under that milestone (“Deferred: … because …”) so it is explicit.

### This log

**Append-only:** add a new dated `## …` section when something worth remembering lands (merged lab PR, meaningful success-criteria row, lesson that changes the next design, or a small playbook-only doc change).

Suggested shape for a **lab milestone** (keep it short):

- **What shipped** — fact-level outcome.
- **Tradeoff** *(optional, high signal for explaining decisions later)* — what you rejected and why.
- **Failure mode** *(optional)* — what breaks in prod without what you built.
- **Next** *(optional)* — one concrete next step.

You do not need daily entries. Aim for **one section per slice** you would summarize in a weekly update, retrospective, or coaching conversation.

For **architecture-style narration**, lean on **Tradeoff** and **Failure mode** when you can. See also [README — Architectural narrative](README.md#architectural-narrative).

---

## 2026-05-05 — Playbook scaffold

- Initialized [career-playbook](.) with `FOCUS.md`, project specs, and checklists.
- Created local practice repos: [webhook-receiver-lab](projects/webhook-receiver-lab) (Project 1) and [rag-llm-lab](projects/rag-llm-lab) (Project 4 skeleton: FastAPI, eval JSONL template, observability hooks).
- **Next:** Run Project 1 locally, exercise idempotency + signature paths; flesh out RAG retrieval in Project 4 when LangChain work starts.

---

## 2026-05-05 — Learning path + optional Node/TypeScript lab

- README: added **Learning path (suggested)** table (phases 1–5 + stack reality callout).
- New spec: [project-specs/06-node-typescript-lab.md](project-specs/06-node-typescript-lab.md) — optional **Node + TypeScript** parity (webhook, contract API, or webhook+worker); links from Projects 2, 3, and 5.
- [FOCUS.md](FOCUS.md): **Flexible lane** under forward vector; non-goals clarified (one TS service is in-scope; framework churn is not).

---

## 2026-05-05 — Playbook docs: SQL in-project, Rust/Go scope, repo table

- [README.md](README.md): **SQL and performance** note (depth via P1/P2/P5 + P3 timings, no mandatory SQL-only project); expanded **quick links** with P2 and P5 TBD rows; reminder to refresh links when new repos ship.
- [FOCUS.md](FOCUS.md): non-goal for **Rust/Go** unless a shipping artifact or explicit role target exists.

---

## 2026-05-05 — Project 7: SQL performance / correctness lab

- New spec: [project-specs/07-sql-performance-lab.md](project-specs/07-sql-performance-lab.md) — Postgres-focused plans, indexing, joins vs loop-shaped access, transactions, keyset pagination; optional rollup stretch.
- Practice repo: [projects/sql-perf-lab](projects/sql-perf-lab) (Docker Compose, seeded schema, `exercises/*.sql`).
- [README.md](README.md): learning path row **4b**, updated SQL paragraph, quick-links row + SSH clone hint for **sql-perf-lab**.
- [FOCUS.md](FOCUS.md): optional SQL/data depth lane + industry theme **#6** pointing at P7.
- Cross-links from Projects **1**, **2**, and **5** to P7 for deeper relational work.

---

## 2026-05-05 — sql-perf-lab as standalone repo

- [projects/sql-perf-lab](https://github.com/shemaiahCox/sql-perf-lab) is its own git repository (same pattern as webhook- and rag-llm labs); no longer committed inside **career-playbook** (`projects/*/` ignore restored).
- Spec **07** code-repo table matches **local sibling** clone path; main **README** quick links unchanged for local dev.

---

## 2026-05-06 — Architectural narrative + usage docs

- [README.md](README.md): **Architectural narrative** — maps competencies to projects and checklists; habits for specs, PROGRESS entries, optional lab README diagrams.
- [README.md](README.md): **Using this playbook** — how to work through `project-specs/`, pointers to checklists and this log.
- [FOCUS.md](FOCUS.md): **Architectural thinking through practice** bridge linking README narrative and PROGRESS tradeoffs/failure modes.
- [PROGRESS.md](PROGRESS.md): **How to use checklists and this log** — checklist timing, log cadence, milestone shape (**Tradeoff** / **Failure mode** prompts folded in).

---

## 2026-05-06 — Exploration scenarios in project specs

- All [project-specs/](project-specs/) (`01`–`07`, including `06`): new **Exploration scenarios** sections — Setup / Action / Expected outcome / optional Stretch; lab READMEs hold copy-paste commands where repos exist.
- [README.md](README.md): **Using this playbook** — step to run scenarios after Key concepts and before checklists.

---

## 2026-05-07 — Practice-first tone

- [FOCUS.md](FOCUS.md): **Purpose** blurb (practice and understanding first); **Role direction** (replacing headline “optimize”); SQL depth wording; **Architectural thinking through practice**.
- [README.md](README.md): engineering-first vocabulary in playbook steps; SQL paragraph emphasizes hands-on plan/index literacy from real runs.
- [PROGRESS.md](PROGRESS.md): Tradeoff/cadence wording centered on explanation and retrospectives (not interviews-first).
- [project-specs/](project-specs/) **01**, **03**, **06**, **07**: practice-first wording (Career relevance, Exploration intro, Maps to / summaries).

---

## 2026-05-08 — Docs index + repository sync

- Added [docs/](docs/) — software engineering, database design, command-line tooling, servers and networking (study notes alongside labs).
- [README.md](README.md): quick-link bullet to **docs/** for discoverability.

---

## 2026-05-09 — Docs layout: guides, reference split, unfamiliar-stack workflow

- [docs/README.md](docs/README.md) indexes **paths/**, **stacks/**, **handbook/** (long-form study notes live under [docs/handbook/](docs/handbook/)).
- New paths: [docs/paths/ai-assisted-unfamiliar-stack.md](docs/paths/ai-assisted-unfamiliar-stack.md), [docs/paths/systems-architect-across-languages.md](docs/paths/systems-architect-across-languages.md); [docs/stacks/README.md](docs/stacks/README.md) documents the **term card** template.
- New checklist: [checklists/unfamiliar-stack-ship.md](checklists/unfamiliar-stack-ship.md) (lifecycle, leaks, failure paths, secrets, observability—scoped by product shape).
- [README.md](README.md): **Unfamiliar stack + AI** subsection; bullet links to docs map and paths. [FOCUS.md](FOCUS.md): polyglot architect literacy pointer.

---

## 2026-05-10 — Ecosystem one-pagers (draft)

- Added five **≤2-page** maps under [docs/stacks/](docs/stacks/) (index in [README.md](docs/stacks/README.md)): [swift-ios.md](docs/stacks/swift-ios.md), [kotlin-android.md](docs/stacks/kotlin-android.md), [nextjs-react-typescript.md](docs/stacks/nextjs-react-typescript.md), [csharp-dotnet.md](docs/stacks/csharp-dotnet.md), [php-laravel.md](docs/stacks/php-laravel.md).
- [docs/README.md](docs/README.md), [docs/stacks/README.md](docs/stacks/README.md), [README.md](README.md): pointers to ecosystem index.

---

## 2026-05-11 — Ecosystem maps: Python + SQL

- New: [docs/stacks/python.md](docs/stacks/python.md) (venv/packaging, asyncio, GIL, FastAPI-shaped footguns); [docs/stacks/sql.md](docs/stacks/sql.md) (dialects, transactions, plans, ORM boundary).
- [docs/README.md](docs/README.md), [docs/stacks/README.md](docs/stacks/README.md): index updates (ecosystem maps live in stacks README).

---

## 2026-05-12 — Learning journey guide

- New: [docs/paths/learning-journey.md](docs/paths/learning-journey.md) — View A (dependency spine), View B (illustrative week overlay), weekly recipe, phase → reference skim tables ([software engineering](docs/handbook/software-engineering.md), [database design](docs/handbook/database-design.md), ecosystem maps).
- [README.md](README.md): quick-link + pointer under **Using this playbook**. [docs/README.md](docs/README.md): paths row. [docs/paths/ai-assisted-unfamiliar-stack.md](docs/paths/ai-assisted-unfamiliar-stack.md): Related link.
