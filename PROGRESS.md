# Progress log

## How to read this file

The top section explains **when** to use checklists and **how** to write log entries. The dated sections below are an append-only history of playbook and lab milestones — read newest first if you want recent context, or scroll to the bottom for the earliest scaffold.

## How to use checklists and this log

### Checklists

Use them **when you are close to shipping** a slice (or before you call a lab milestone done) — not as everyday task lists.

- **Platform engineering gate (every step):** [checklists/production-readiness.md](checklists/production-readiness.md) — rate limits, retries, idempotency, dead-letter queue (DLQ), metrics, logs, tracing, health, versioning, security. See applicability matrix for your step.
- **Portfolio artifacts (every step):** [docs/templates/portfolio-artifacts.md](docs/templates/portfolio-artifacts.md) — diagram, architecture decision record (ADR), performance numbers, failure modes, observability evidence in lab `docs/portfolio/`.
- **Inbound webhooks, partner HTTP, sync integration edges** (and HTTP fronts that enqueue later): [checklists/integration-hardening.md](checklists/integration-hardening.md).
- **User-facing model / retrieval-augmented generation (RAG) / tool paths**: [checklists/llm-feature-ship.md](checklists/llm-feature-ship.md).
- **Open Web Application Security Project (OWASP) / web application security (Project 9)** — forms, SQL injection, cross-site scripting (XSS), sessions, cross-site request forgery (CSRF): [checklists/application-security-web-owasp.md](checklists/application-security-web-owasp.md).
- **New stack + AI** (you are accountable for concepts, not only the prompt): [checklists/unfamiliar-stack-ship.md](checklists/unfamiliar-stack-ship.md). Workflow: [docs/concepts/ai-assisted-unfamiliar-stack.md](docs/concepts/ai-assisted-unfamiliar-stack.md).

Walk the sections **top to bottom** once with the repo and environment in front of you. You do not have to tick boxes inside the markdown file unless you want to; the point is not skipping whole categories (signatures, idempotency, DLQ, eval regression, personally identifiable information (PII), timeouts, OWASP-style web risks when Project 9 is in scope, etc.). If you **defer** a row on purpose, note one line here under that milestone (“Deferred: … because …”) so it is explicit.

### This log

**Append-only:** add a new dated `## …` section when something worth remembering lands (merged lab pull request (PR), meaningful success-criteria row, lesson that changes the next design, or a small playbook-only doc change).

Suggested shape for a **lab milestone** (keep it short):

- **What shipped** — fact-level outcome.
- **Pillar(s)** — which architecture pillar(s) this milestone primarily proves (1–5; see [architecture framework](docs/concepts/architecture-framework.md)).
- **Tradeoff** *(optional, high signal for explaining decisions later)* — what you rejected and why.
- **Failure mode** *(optional)* — what breaks in production without what you built.
- **Portfolio** *(optional)* — link to lab `docs/portfolio/` or note deferred artifacts ([template](docs/templates/portfolio-artifacts.md)).
- **Next** *(optional)* — one concrete next step.

You do not need daily entries. Aim for **one section per slice** you would summarize in a weekly update, retrospective, or coaching conversation.

For **architecture-style narration**, lean on **Pillar(s)**, **Tradeoff**, and **Failure mode** when you can. See [Architecture framework](docs/concepts/architecture-framework.md).

**Note:** Historical entries may reference the archived [v1 22-step path](archive/v1-22-step/README.md) or removed `FOCUS.md`. The spine is now the [7-domain path plus required competence labs 08–13](README.md) under the [architecture framework](docs/concepts/architecture-framework.md).

### Active lab and courses

**One active lab at a time** — a domain (1–7) **or** a competence lab (08–13). Linear order: domains 1–5 → 08–12 → domain 6 → 13 → domain 7.

| Field | Value |
|-------|--------|
| **Active lab** | 1 — Agentic AI and orchestration |
| **Active spec** | [01-agentic-orchestration.md](career-project-specs/01-agentic-orchestration.md) |

| Course / credential | Phase | Status | Date | Notes |
|---------------------|-------|--------|------|-------|
| Deep Agents + LangChain/LangGraph docs + FastMCP | 1 | In progress | | |
| KodeKloud Docker for the Absolute Beginner | 2 | Planned | | |
| KodeKloud Terraform for Beginners | 3 | Planned | | |
| AZ-900 Azure Fundamentals (optional vocab) | before 3 | Planned | | |
| KodeKloud AZ-104 | 4 | Planned | | |
| ByteByteGo System Architecture + DesignGurus Modern API Design | 5 | Planned | | |
| Data Engineering Zoomcamp (DataTalks.Club) | 6 | Planned | | |
| KodeKloud CKA | 7 | Planned | | |

**Azure resources used per phase (ADR log):**

| Phase | Azure resources deployed | ADR link |
|-------|--------------------------|----------|
| 1 Agentic | | |
| 3 Terraform | | |
| 4 Admin / governance | | |
| 5 Backends | | |
| 6 Pipelines | | |
| 7 AKS | | |

---

---

## 2026-08-31 — 7-phase Azure + agentic spine

- **Archived** v1 22-step specs to [archive/v1-22-step](archive/v1-22-step/README.md).
- **New path:** Phases 1–7 (Deep Agents → Docker → Terraform → AZ-104 → Azure backends → pipelines → AKS). Primary languages Python + Go; TypeScript stretch.
- **Active:** Phase 1 — [01-agentic-orchestration.md](career-project-specs/01-agentic-orchestration.md).

---

## 2026-06-16 — Bash scripting spine + 22-step renumber

- **Added** [Project 14 — Shell automation lab](archive/v1-22-step/career-project-specs/14-shell-automation-lab.md): strict-mode toolkit, shellcheck, bats, bash-vs-Go CLI ADR.
- **Added** [docs/languages/bash.md](docs/languages/bash.md) ecosystem map; wired from [glossary](docs/languages/glossary.md) and [command-line-tooling](docs/concepts/command-line-tooling.md).
- **Renumbered** spine Projects 14–21 → 15–22; optional P22–P24 → P23–P25 (spec files git-mv).
- **Added** **Bash scripting milestone** sections across Projects 1–13 and 15–22 (phased `scripts/` deliverables).
- **Updated** [README.md](README.md) (22 steps), [engineering-pillars.md](docs/concepts/engineering-pillars.md), [target-alignment.md](docs/career/target-alignment.md), [per-project-testing.md](docs/concepts/per-project-testing.md), career docs, and cross-links repo-wide.

---

## 2026-06-13 — UK career targeting + job-market alignment

- **Added** [docs/career/target-alignment.md](docs/career/target-alignment.md) — project ideas → playbook map, UK employer ask matrix, £80k milestones, GitHub pin order, interview themes.
- **Added** [docs/concepts/messaging-and-rpc.md](docs/concepts/messaging-and-rpc.md) — Kafka vs Redis/NATS, REST vs gRPC career context.
- **Strengthened** specs: Project 8 (Prometheus required; Kafka/gRPC stretches), Project 15 (GitHub Actions required), Project 6 (Kafka stretch), Project 12 (OAuth stretch), Project 18 (Tokio + proptest), Project 7 (CI cross-link), Project 14 (rust-cli-http-probe link).
- **Updated** [rust.md](docs/languages/rust.md) Career positioning; wired from [README.md](README.md) and [docs/README.md](docs/README.md).

---

## 2026-06-03 — Language ecosystem maps (top-to-bottom story)

- **Added** [docs/templates/language-ecosystem-map.md](docs/templates/language-ecosystem-map.md) — shared H2 outline for all stack maps.
- **Restructured** all six ecosystem maps ([python](docs/languages/python.md), [go](docs/languages/go.md), [node-typescript-backend](docs/languages/node-typescript-backend.md), [php-laravel](docs/languages/php-laravel.md), [rust](docs/languages/rust.md), [sql](docs/languages/sql.md)): best for → how it runs → environment setup → project layout → daily commands → playbook concepts.
- **Extended** [language-fundamentals-comparison.md](docs/languages/language-fundamentals-comparison.md) with **Rust** column (~20 tables), snippets, and quick-reference rows.
- **Updated** [glossary](docs/languages/glossary.md) (Rust row, template link, fundamentals note) and [docs/README](docs/README.md) languages intro.

---

## 2026-06-03 — Capstone, portfolio artifacts, production checklist

- **Added** [Project 21 — Integrated platform capstone](archive/v1-22-step/career-project-specs/22-integrated-platform-capstone.md) (Step 21): compose Projects 1–20 into one flagship demo/deploy stack.
- **Added** [docs/templates/portfolio-artifacts.md](docs/templates/portfolio-artifacts.md) and **Portfolio artifacts** section in all 21 specs.
- **Added** [checklists/production-readiness.md](checklists/production-readiness.md) with Step 1–21 applicability matrix; wired into **When you're done** and [PROGRESS.md](PROGRESS.md) checklist intro.
- **Updated** [README.md](README.md) progression (Step 1 → 21), [career-projects/README.md](career-projects/README.md), [engineering-pillars.md](docs/concepts/engineering-pillars.md), [systems-integration-architect.md](docs/concepts/systems-integration-architect.md).

---

## 2026-06-03 — Local lab folders aligned to step numbers

- **Renamed** nested clones: `04-rag-llm-lab` → `02-rag-llm-lab` (step 2), `07-sql-perf-lab` → `04-sql-perf-lab` (step 4).
- **Fixed** [README.md](README.md) GitHub lab links to match spec **Code repo** tables (`rag-llm-lab`, `sql-perf-lab`, `webhook-receiver-lab`).
- **Clarified** folder prefix = step number in README and [career-projects/README.md](career-projects/README.md).

---

## 2026-06-03 — Align inline project numbers with Step 1–20 path

- **Fixed** stale labels from the old P1–P23 renumbering: inline “Project N” text and `[Project N](spec)` links now match the learning path in [README.md](README.md) (e.g. RAG = Project 2, async worker = Project 6, security = Project 9, Rust = Project 18).
- **Touched** specs 8–12, 14–20, 09; [llms.md](docs/concepts/llms.md), [rust.md](docs/languages/rust.md), [node-typescript-backend.md](docs/languages/node-typescript-backend.md), [application-security-web-owasp.md](checklists/application-security-web-owasp.md).

---

## 2026-06-03 — Remove specs README stub and exploration-projects

- **Deleted** [career-project-specs/README.md](career-project-specs/README.md) (catalog lives in [README.md](README.md) only).
- **Deleted** `exploration-projects/`; Laravel route snippet merged into [php-laravel.md](docs/languages/php-laravel.md).
- **Updated** sandbox links in specs 1, 5, 7, 8, 14, 18; language maps; fundamentals comparison; `.gitignore`.

---

## 2026-06-03 — Path catalog in root README

- **Merged** [career-project-specs/README.md](career-project-specs/README.md) progression + browse-by-topic into [README.md](README.md); specs README is now a redirect stub.
- **Updated** cross-links in docs hub, career-projects, exploration-projects, engineering-pillars, systems-integration-architect, ai-assisted-unfamiliar-stack, go.md.

---

## 2026-06-03 — Memory and performance concepts

- **Added** [docs/concepts/memory-and-performance.md](docs/concepts/memory-and-performance.md): measure-then-tune workflow, latency/throughput/memory patterns, profiling cheat sheet, project map.
- **Updated** docs hub, software-engineering cross-links, language maps (Go, Python, Rust, Node, SQL), and specs 2, 3, 4, 6, 8, 13, 17, 18, 19 + browse-by-topic rows.

---

## 2026-06-03 — README + FOCUS consolidation

- **Merged** FOCUS into [README.md](README.md): role direction, non-goals, simplified Start here.
- **Removed** `FOCUS.md`; full curriculum stays in [career-project-specs/README.md](career-project-specs/README.md) only.
- **Updated** cross-links in exploration-projects README, Project 6/9 specs, engineering-pillars.

---

## 2026-06-13 — Docs split: languages/ and concepts/

- **Moved** stack maps → `docs/languages/` (8 files); theory/patterns → `docs/concepts/` (13 files).
- **Updated** links across specs, exploration sandboxes, and checklists.

---

## 2026-06-13 — Flat docs folder

- **Moved** all markdown from `docs/paths/`, `docs/stacks/`, `docs/handbook/`, `docs/playbook/`, `docs/reference/` into flat **`docs/`** (22 files).
- **Updated** cross-links across specs, checklists, and exploration sandboxes.

---

## 2026-06-13 — Linear spec-driven progression (Project 1 → 20)

- **Renumbered** spec files so step order matches filenames (`02-rag-llm-service.md`, `04-sql-performance-lab.md`, …).
- **Path is the catalog:** [career-project-specs/README.md](career-project-specs/README.md) — each spec has Progress, Before you start, Important concepts, When you're done.
- **Removed** [learning-journey.md](docs/README.md); moved [engineering-pillars.md](docs/concepts/engineering-pillars.md) to optional topic index.
- **Note:** GitHub lab repo names unchanged; local folders renumber (e.g. `02-rag-llm-lab`). Rename nested clones manually when you next work locally.

---

## 2026-06-13 — Lean navigation (README + FOCUS)

- **Changed:** [README.md](README.md) and [FOCUS.md](FOCUS.md) are the entry points — start here, one-milestone workflow, folder map only.
- **Trimmed:** [learning-journey.md](docs/README.md) (removed duplicate AI quick map; fixed Rust table); [career-project-specs/README.md](career-project-specs/README.md) (single catalog table).
- **Removed:** Deprecated `projects/` and `project-specs/` stub folders.
- **Fixed:** Broken links to removed README sections (`#learning-path-suggested`, `#architectural-narrative`).

---

## 2026-06-10 — Full pillar project catalog (Project 1–Project 20)

- **Decision:** Restructure playbook into **five engineering pillars** with dedicated specs Project 10–Project 20; **Concept spotlight** on every spec Project 1–Project 20.
- **Added:** [engineering-pillars.md](docs/concepts/engineering-pillars.md), [career-project-specs/README.md](career-project-specs/README.md), specs Project 10–Project 15 (Wave 2), Project 16–Project 17/Project 18–Project 20 (Wave 3).
- **Updated:** [learning-journey.md](docs/README.md) View C + waves, [FOCUS.md](FOCUS.md), [README.md](README.md).
- **Next:** Ship Wave 1 foundation (active spine); Wave 2 starts after Project 8 capstone green.

---

## 2026-06-03 — Rust Tier‑2 growth lane

- **Decision:** Add **Rust** as Tier‑2 after Project 8 Go (not parallel spine)—aligns with LinkedIn stack (Go · Python · Rust · TypeScript · SQL · PHP) and AI/automation/cloud themes.
- **Added:** [docs/languages/rust.md](docs/languages/rust.md), [rust-cli-http-probe](exploration-projects/rust-cli-http-probe/) sandbox, [learning journey — Rust Tier‑2](docs/README.md#rust-tier-2-after-p9-go), Project 8 Rust stretch bullets.
- **Updated:** [FOCUS.md](FOCUS.md) (removed Rust from non-goals; Tier‑2 table), README, exploration-projects README, go.md cross-links.
- **Next:** Ship Project 8 in Go first; optional rust-cli-http-probe for syntax; Project 8 Rust reimplementation + Go-vs-Rust ADR when Go core is green.

---

- **Decision:** Playbook scoped to **JS/TS, PHP, SQL, Go, Python** only—removed Java, C#, Kotlin, Swift, Rust, Unity, Next.js sandboxes and stack maps.
- **Added:** [Project 8 Go retrieval/worker spec](archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md), [Go stack map](docs/languages/go.md), [integration-automation map](docs/concepts/integration-automation.md), [Systems integration architect](docs/concepts/systems-integration-architect.md), [Algorithms study path](docs/concepts/algorithms-study-path.md).
- **Narrative:** Integrations + automation + AI (Boomi/n8n patterns, RAG in Python, performance in Go).
- **Next:** Pick active spec on new spine (Project 1 → Project 2/Project 3 → Project 5 → Project 6/Project 8 → Project 7); study algorithms path when starting Project 4 or Project 8.

---

## 2026-05-05 — Playbook scaffold

- Initialized [career-playbook](.) with `FOCUS.md`, project specs, and checklists.
- Created local practice repos: [01-webhook-receiver-lab](career-projects/01-webhook-receiver-lab) (Project 1) and [02-rag-llm-lab](career-projects/02-rag-llm-lab) (Project 4 skeleton: FastAPI, eval JSONL template, observability hooks).
- **Next:** Run Project 1 locally, exercise idempotency + signature paths; flesh out RAG retrieval in Project 4 when orchestration work starts (retrieval + chosen library/SDK stack).

---

## 2026-05-05 — Learning path + optional Node/TypeScript lab

- README: added **Learning path (suggested)** table (phases 1–5 + stack reality callout).
- New spec: [archive/v1-22-step/career-project-specs/07-node-typescript-lab.md](archive/v1-22-step/career-project-specs/07-node-typescript-lab.md) — optional **Node + TypeScript** parity (webhook, contract API, or webhook+worker); links from Projects 2, 3, and 5.
- [FOCUS.md](FOCUS.md): **Flexible lane** under forward vector; non-goals clarified (one TS service is in-scope; framework churn is not).

---

## 2026-05-05 — Playbook docs: SQL in-project, Rust/Go scope, repo table

- [README.md](README.md): **SQL and performance** note (depth via Project 1/Project 5/Project 6 + Project 3 timings, no mandatory SQL-only project); expanded **quick links** with Project 5 and Project 6 TBD rows; reminder to refresh links when new repos ship.
- [FOCUS.md](FOCUS.md): non-goal for **Rust/Go** unless a shipping artifact or explicit role target exists.

---

## 2026-05-05 — Project 7: SQL performance / correctness lab

- New spec: [archive/v1-22-step/career-project-specs/04-sql-performance-lab.md](archive/v1-22-step/career-project-specs/04-sql-performance-lab.md) — Postgres-focused plans, indexing, joins vs loop-shaped access, transactions, keyset pagination; optional rollup stretch.
- Practice repo: [04-sql-perf-lab](career-projects/04-sql-perf-lab) (Docker Compose, seeded schema, `exercises/*.sql`).
- [README.md](README.md): learning path row **4b**, updated SQL paragraph, quick-links row + SSH clone hint for **sql-perf-lab**.
- [FOCUS.md](FOCUS.md): optional SQL/data depth lane + industry theme **#6** pointing at Project 4.
- Cross-links from Projects **1**, **2**, and **5** to Project 4 for deeper relational work.

---

## 2026-05-05 — sql-perf-lab as standalone repo

- [sql-perf-lab](https://github.com/shemaiahCox/sql-perf-lab) is its own git repository (same pattern as webhook- and rag-llm labs); clone beside **career-playbook** into **`career-projects/04-sql-perf-lab`** (see main [README](README.md#quick-links-to-practice-repos)).
- Spec **07** code-repo table matches **local sibling** clone path; main **README** quick links unchanged for local dev.

---

## 2026-05-06 — Architectural narrative + usage docs

- [README.md](README.md): **Architectural narrative** — maps competencies to projects and checklists; habits for specs, PROGRESS entries, optional lab README diagrams.
- [README.md](README.md): **Using this playbook** — how to work through `career-project-specs/`, pointers to checklists and this log.
- [FOCUS.md](FOCUS.md): **Architectural thinking through practice** bridge linking README narrative and PROGRESS tradeoffs/failure modes.
- [PROGRESS.md](PROGRESS.md): **How to use checklists and this log** — checklist timing, log cadence, milestone shape (**Tradeoff** / **Failure mode** prompts folded in).

---

## 2026-05-06 — Exploration scenarios in project specs

- All [career-project-specs/](career-project-specs/) (`01`–`07`, including `06`): new **Exploration scenarios** sections — Setup / Action / Expected outcome / optional Stretch; lab READMEs hold copy-paste commands where repos exist.
- [README.md](README.md): **Using this playbook** — step to run scenarios after Key concepts and before checklists.

---

## 2026-05-07 — Practice-first tone

- [FOCUS.md](FOCUS.md): **Purpose** blurb (practice and understanding first); **Role direction** (replacing headline “optimize”); SQL depth wording; **Architectural thinking through practice**.
- [README.md](README.md): engineering-first vocabulary in playbook steps; SQL paragraph emphasizes hands-on plan/index literacy from real runs.
- [PROGRESS.md](PROGRESS.md): Tradeoff/cadence wording centered on explanation and retrospectives (not interviews-first).
- [career-project-specs/](career-project-specs/) **01**, **03**, **06**, **07**: practice-first wording (Career relevance, Exploration intro, Maps to / summaries).

---

## 2026-05-08 — Docs index + repository sync

- Added [docs/](docs/) — software engineering, database design, command-line tooling, servers and networking (study notes alongside labs).
- [README.md](README.md): quick-link bullet to **docs/** for discoverability.

---

## 2026-05-09 — Docs layout: guides, reference split, unfamiliar-stack workflow

- [docs/README.md](docs/README.md) indexes **paths/**, **stacks/**, **handbook/** (long-form study notes live under [docs/](docs/)).
- New paths: [docs/concepts/ai-assisted-unfamiliar-stack.md](docs/concepts/ai-assisted-unfamiliar-stack.md), [docs/systems-architect-across-languages.md](docs/systems-architect-across-languages.md); [docs/README.md](docs/README.md) documents the **term card** template.
- New checklist: [checklists/unfamiliar-stack-ship.md](checklists/unfamiliar-stack-ship.md) (lifecycle, leaks, failure paths, secrets, observability—scoped by product shape).
- [README.md](README.md): **Unfamiliar stack + AI** subsection; bullet links to docs map and paths. [FOCUS.md](FOCUS.md): polyglot architect literacy pointer.

---

## 2026-05-10 — Ecosystem one-pagers (draft)

- Added five **≤2-page** maps under [docs/](docs/) (index in [README.md](docs/README.md)): [swift-ios.md](docs/swift-ios.md), [kotlin-android.md](docs/kotlin-android.md), [nextjs-react-typescript.md](docs/nextjs-react-typescript.md), [csharp-dotnet.md](docs/csharp-dotnet.md), [php-laravel.md](docs/languages/php-laravel.md).
- [docs/README.md](docs/README.md), [docs/README.md](docs/README.md): pointers to ecosystem index.

---

## 2026-05-11 — Ecosystem maps: Python + SQL

- New: [docs/languages/python.md](docs/languages/python.md) (venv/packaging, asyncio, GIL, FastAPI-shaped footguns); [docs/languages/sql.md](docs/languages/sql.md) (dialects, transactions, plans, ORM boundary).
- [docs/README.md](docs/README.md), [docs/README.md](docs/README.md): index updates (ecosystem maps live in stacks README).

---

## 2026-05-12 — Learning journey guide

- New: [docs/README.md](docs/README.md) — View A (dependency spine), View B (illustrative week overlay), weekly recipe, phase → reference skim tables ([software engineering](docs/concepts/software-engineering.md), [database design](docs/concepts/database-design.md), ecosystem maps).
- [README.md](README.md): quick-link + pointer under **Using this playbook**. [docs/README.md](docs/README.md): paths row. [docs/concepts/ai-assisted-unfamiliar-stack.md](docs/concepts/ai-assisted-unfamiliar-stack.md): Related link.

---

## 2026-05-13 — Handbook debugging + stack maps (Node, Java)

- [docs/concepts/software-engineering.md](docs/concepts/software-engineering.md): **Debugging (workflow)** section; TOC + intro; cross-links from **Testing** and **Observability**. [docs/README.md](docs/README.md): Project 3/Project 2 skim row + ecosystem map rows below. [archive/v1-22-step/career-project-specs/03-observability-lab.md](archive/v1-22-step/career-project-specs/03-observability-lab.md): companion reading.
- New stacks: [docs/languages/node-typescript-backend.md](docs/languages/node-typescript-backend.md), [docs/java-jvm.md](docs/java-jvm.md); [docs/README.md](docs/README.md), [docs/languages/glossary.md](docs/languages/glossary.md). [docs/README.md](docs/README.md): Observability/debugging + polyglot/stack exploration; stacks intro line.

---

## 2026-05-18 — Repo layout: `career-projects/`, `career-project-specs/`

- **Labs:** Playbook workspaces (**`01-*`**, **`04-*`**, **`07-*`**) live inside this repo under **`career-projects/`** (nested git checkouts)—not **`exploration-projects/`** (sandboxes only) and no longer implied under **`~/Documents/dev/business-projects/`** unless you deliberately keep clones there (**`business-projects/`** is for unrelated product repos like PacPal).
- **Specs:** Initiative docs moved **`project-specs/` → `career-project-specs/`**; [`project-specs/README.md`](project-specs/README.md) redirects old paths.
- [`.gitignore`](.gitignore): ignore **`career-projects/*`** except **`README.md`** so nested lab checkouts remain separate repositories—not gitlinks inside this repo.
- [README.md](README.md): quick-links, clone notes, **`Using this playbook`**, **`FOCUS`**, **`exploration-projects/README`**, and cross-links refreshed for the folder names above.
