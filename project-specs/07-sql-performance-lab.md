# Project 7 — SQL performance and correctness lab

## Problem

Build a **small, intentional** relational dataset and queries where you practice **reading plans**, choosing **indexes**, avoiding **N+1** patterns, applying **ACID** principles in real `psql` flows, and paginating reliably—so SQL reads as an engineering skill, not guesswork.

## Career relevance

**Summary:** You collect **concrete** before/after `EXPLAIN` stories, index decisions you can defend, and isolation tradeoffs—the substance people mean when they ask you to **walk through a slow query you fixed**.

### In depth

Most backend roles assume you can **join**, **filter**, and **migrate** responsibly. What separates “I use an ORM” from “I own the data layer” is whether you can **predict** cost from a plan, **know** when an index helps, and **reason** about concurrency. A dedicated lab keeps that practice **orthogonal** to framework churn: the same lessons apply to Laravel, SQLAlchemy, raw PDO, and read replicas later.

**Why learning this moves the needle**

- **Interview signal:** “We added a covering index and cut p95 from 800ms to 12ms” lands when you can show **seq scan → index scan**, **rows removed by filter**, and **buffer hits**—not when you only say “we tuned Postgres.”
- **Production fires:** Regressions often ship as **one extra join**, **missing predicate**, or **offset pagination** on a hot list. `EXPLAIN (ANALYZE, BUFFERS)` is how you **prove** the regression and **verify** the fix under load-shaped data.
- **ORM coexistence:** ORMs generate SQL; seniors still **trace** N+1 loops, eager-load shapes, and migration-induced locks. This lab names those patterns in **SQL first**, then you map them to your day-job stack.
- **Cost awareness:** Wrong indexes **slow** writes and **bloat** autovacuum work; partial indexes and constraint-first design are how you keep **read** optimizations from becoming **write** taxes.

**Real-world situations this project mirrors**

- **Hot list endpoints** that worked at 10k rows and **degraded** at 10M because of `ORDER BY created_at DESC LIMIT 50 OFFSET 100000`.
- **Dashboard queries** that scanned a huge time range until a **predicate-friendly** index and a **narrow** select list appeared.
- **Double spends / double inserts** when two workers race without a **transaction boundary** or **unique** constraint aligned to the business key.
- **Staging-only miracles:** fixes that used indexes present in prod but not in CI’s dataset—your lab teaches **repeatable** seeds and plans checked into the repo.

## Code repo

| | URL |
|---|-----|
| **GitHub** | [https://github.com/shemaiahCox/sql-perf-lab](https://github.com/shemaiahCox/sql-perf-lab) |
| **SSH** | `git@github.com:shemaiahCox/sql-perf-lab.git` |
| **Local sibling** | [`../projects/07-sql-perf-lab`](../projects/07-sql-perf-lab) |

## Stack

**Postgres 16** (Docker Compose) as the reference engine: `EXPLAIN (ANALYZE, BUFFERS)`, partial indexes, and concurrency demos match what most teams mean by “production Postgres.” Application code stays **optional and thin**—`psql`, small shell helpers, or a short Python runner only to load seeds or time batches.

**Dialect deltas (MySQL / SQL Server):** Concepts transfer; syntax does not. Use their `EXPLAIN` / actual-plan equivalents, learn **MVCC vs locking** basics for your engine, and re-run the same **logical** exercises (missing index, bad pagination, isolation) with dialect-appropriate DDL. Keep one **primary** repo engine so commits stay reviewable.

## Key concepts (with definitions and patterns)

### Query plan (`EXPLAIN` vs `EXPLAIN ANALYZE`)

**What:** The optimizer’s **estimated** or **measured** path: join order, scan type, row counts, and cost.

**Problem it solves:** Stops optimization from being vibes—shows **why** a query is slow (seq scan, nested loop explosion, mis-estimated cardinality).

**In this repo:** Use `EXPLAIN` for shape, then `EXPLAIN (ANALYZE, BUFFERS)` on representative data to see **actual** timings and buffer churn.

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT o.id, o.status
FROM orders o
WHERE o.tenant_id = 't-001' AND o.created_at > now() - interval '7 days';
```

### Index design (useful vs useless vs partial)

**What:** A **B-tree** (default in Postgres) supporting seeks and ordered scans on a prefix of indexed columns; **partial** indexes include a `WHERE` predicate to index a **subset** of rows cheaply.

**Problem it solves:** Alignment of **query predicates** and **sort keys** with index columns; avoids “we indexed everything” write drag.

**In this repo:** Exercises compare **no index**, **wrong-column** index, **composite** `(tenant_id, created_at DESC)`, and a **partial** index for a high-traffic subset (e.g. `status = 'open'`).

### N+1 vs join (logical shape)

**What:** **N+1** runs one query for a parent list and **one query per row** for children; a **join** (or batch `IN`) fetches the graph in **constant** query count.

**Problem it solves:** API latency cliffs when list endpoints fan out per item—ORMs hide the loop until production.

**In this repo:** Side-by-side SQL: correlated subquery / loop-shaped statements vs single join plan with stable row estimates.

### ACID (transactions)

**What:** **ACID** is the shorthand for what a transactional database guarantees when you group statements in a **`BEGIN` … `COMMIT`** (or single auto-commit statement):

| Property | Meaning (practice lens) |
|----------|-------------------------|
| **Atomicity** | Either **all** changes in the transaction apply, or **none** do. If you **`ROLLBACK`** (or the connection errors before commit), partial updates **vanish**. |
| **Consistency** | The database only accepts transitions between **valid** states: **constraints** (FK, UNIQUE, NOT NULL, CHECK) and your business rules enforced in SQL or triggers. A rejected statement can **abort** the whole transaction until you **`ROLLBACK`**. |
| **Isolation** | Concurrent transactions **don’t see each other’s in-flight writes** as if they ran in a single global order—**exactly how much** isolation depends on the **isolation level**. In Postgres the default is **`READ COMMITTED`**. You still design for **lost updates** (read-modify-write races) with **`FOR UPDATE`**, **one-shot `UPDATE … WHERE`**, **SERIALIZABLE** / retries, or **unique** business keys. |
| **Durability** | After **`COMMIT`**, committed work **survives** crashes and restarts (in Postgres, via the **WAL**). This lab doesn’t simulate power loss; you accept durability as an engine contract once you see successful commits. |

**Problem it solves:** Correct money-like state, inventory, and idempotency records without “half applied” stories or silent races.

**In this repo:** [Exercise 4](../projects/07-sql-perf-lab/exercises/04_transactions.sql) walks **atomicity** (`ROLLBACK`), **consistency** (FK violation), and **isolation** (`FOR UPDATE` row lock + optional two-session lost-update drill). **Durability** is explained here; confirm in production with your operator’s backup/HA story, not this container alone.

### Keyset pagination vs `OFFSET`

**What:** **Keyset** (seek) pagination uses the **last seen sort key** (`WHERE (created_at, id) < ($1, $2) ORDER BY created_at DESC, id DESC LIMIT 50`); **`OFFSET`** skips N rows and **scans** them.

**Problem it solves:** Deep-list APIs that **linearly slow** as users page forward.

**In this repo:** Same list query with large `OFFSET` vs keyset; compare plans and latency on seeded volume.

### Optional stretch: materialized view / rollup

**What:** **Pre-aggregated** storage (materialized view refreshed on a schedule or trigger) for expensive reporting queries.

**Problem it solves:** OLTP-safe pattern for one **heavy** analytic read without blocking the hot path.

## Exercises (in repo)

| # | Topic | Location |
|---|--------|----------|
| 1 | Plans: `EXPLAIN` / `ANALYZE` | `exercises/01_plans.sql` |
| 2 | Indexing: missing, composite, partial | `exercises/02_indexes.sql` |
| 3 | Join vs N+1-shaped access | `exercises/03_joins_vs_loop.sql` |
| 4 | **ACID** practice: atomicity, consistency, isolation | `exercises/04_transactions.sql` |
| 5 | Keyset vs `OFFSET` pagination | `exercises/05_pagination.sql` |
| 6 | Stretch: rollup / MV | `exercises/06_rollup_stretch.sql` |

Run order and setup: see [projects/07-sql-perf-lab/README.md](../projects/07-sql-perf-lab/README.md).

## Testing approach (lab)

**Primary:** **Executable exercises** in `exercises/*.sql` are the harness: each file should run cleanly after seed; capture **before/after** `EXPLAIN (ANALYZE, BUFFERS)` excerpts in README or comments as evidence (your “tests” are plan shape + expected row counts).

**Secondary:** Optional **assertion scripts** (e.g. small shell/pytest that greps for `Seq Scan` vs `Index Scan` on known queries)—only if it helps CI; not required if manual excerpts are documented per success criteria.

**Compare:** Unlike API labs, **correctness** here is “does the database do what we claim under this data shape?”—**regression** is saved plans and notes, not only green unit dots.

**Example asks for AI (optional):**  
“Given exercises/02_indexes.sql intent [paste], add three commented `EXPLAIN` blocks: before index, after composite index, after partial index—each with one sentence tradeoff.”  
“Write a short script that runs each exercise file against `DATABASE_URL` and fails on SQL error—no semantic diff of plans.”

**Shared patterns:** [Per-project testing (labs + AI)](../docs/playbook/per-project-testing.md).

## Success criteria

- [ ] **Docker Compose** brings up Postgres with schema + seed loaded from checked-in SQL.
- [ ] Every exercise file runs **cleanly** in `psql` after seed (document any `SET` needed, e.g. `statement_timeout`).
- [ ] At least **three** before/after plan excerpts captured in README or comments (seq scan → index scan, bad pagination, join vs loop).
- [ ] **Exercise 4:** You can explain each **ACID** letter using the repo’s `ROLLBACK`, FK failure, and `FOR UPDATE` / lost-update notes.

## Exploration scenarios

The repo already ships scripted exercises—use these scenarios as **learning goals** (what you should see before moving on). Commands and seeds: [07-sql-perf-lab README](../projects/07-sql-perf-lab/README.md) and `exercises/*.sql`.

### 1 — Plans: estimate vs reality (`01_plans.sql`)

- **Setup:** Postgres up with seed data (`docker compose` per README).
- **Action:** Run representative filters with `EXPLAIN`, then `EXPLAIN (ANALYZE, BUFFERS)`.
- **Expected outcome:** You can point to **seq scan vs index scan**, rows removed by filter, and buffer reads—capture one before/after excerpt for README.

### 2 — Index payoff (`02_indexes.sql`)

- **Action:** Compare latency/plan **without** helpful index vs **with** composite or partial index aligned to predicates.
- **Expected outcome:** Measurable drop in execution time or buffers; articulate **write cost** tradeoff of each new index.

### 3 — Join vs loop-shaped access (`03_joins_vs_loop.sql`)

- **Action:** Run N+1-shaped pattern vs single join / batch fetch on same logical question.
- **Expected outcome:** Explain why loop shape explodes round-trips or planner cost—tie to API list endpoints.

### 4 — Transactions drill (`04_transactions.sql`)

- **Action:** Walk `ROLLBACK`, FK violation, `FOR UPDATE` / optional two-session race notes in file.
- **Expected outcome:** One-sentence explanation per **ACID** letter grounded in what you ran.

### 5 — Pagination cliff (`05_pagination.sql`)

- **Action:** Same page size with large **`OFFSET`** vs **keyset** predicate on `(created_at, id)`.
- **Expected outcome:** Deep pages stay cheap with keyset; **OFFSET** degrades—capture plans.

### 6 — Stretch rollup (`06_rollup_stretch.sql`)

- **Action:** Run stretch if present; compare reporting query cost pre/post materialization strategy.
- **Expected outcome:** Document refresh vs freshness tradeoff.

### 7 — Cross-check with application layer

- **Action:** Describe how ORM **eager load** would map to scenario 3’s join shape for your day-job stack.
- **Expected outcome:** Single paragraph linking this SQL lab to how your application stack loads data (ORM, batching, pagination)—something you could explain in a design review or postmortem.

## Maps to

Backend performance work, API pagination design, data correctness stories, ORM troubleshooting.
