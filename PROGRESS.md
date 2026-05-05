# Progress log

Append a new dated entry when you ship a milestone or learn something worth remembering.

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
