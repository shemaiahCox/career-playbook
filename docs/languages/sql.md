# Ecosystem map: SQL and relational databases

**Use this:** You **design queries, migrations, or schema** and need a **shared vocabulary** across Postgres, MySQL, SQL Server, SQLite—**not** a duplicate of the full [database design](../concepts/database-design.md) reference.

**Companion:** [docs README](../README.md) · [SQL performance lab](../../career-project-specs/04-sql-performance-lab.md) · [database design](../concepts/database-design.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Best for, alternatives, and playbook fit

| Best for | Use instead when | Primary projects |
|----------|------------------|------------------|
| Data correctness, query plans, migrations, transactional invariants | Application business logic in PHP/Python/Go—SQL owns persistence shape, not feature orchestration | [Project 4 — SQL performance lab](../../career-project-specs/04-sql-performance-lab.md); object-relational mapper (ORM)-backed apps in Projects 1–2, 5–7 |

---

## How it runs

| Execution | Typing | Memory / concurrency |
|-----------|--------|----------------------|
| **Declarative**—you describe *what* rows; the **query planner** chooses *how* | **Typed schema** (columns, constraints) + **untyped ad-hoc** queries in application code | **Dialect-specific** (Postgres primary in this playbook); transactions + isolation levels coordinate concurrent writers |

---

## Environment setup

1. Start Postgres from Project 4 lab **Docker Compose** (or local install)—one primary engine story cuts surprises.
2. Connect: `psql "$DATABASE_URL"` or `psql -h localhost -U postgres -d mydb`.
3. Verify: `\conninfo` and `\dt` after migrations run.
4. Migration runner: Laravel `artisan migrate`, Flyway, golang-migrate, or raw SQL files in CI—match your app stack.
5. Project 4 exercises live under [`career-projects/`](../../career-projects/) per spec.

---

## Project layout

```
db/
├── migrations/          # ordered schema changes (001_init.sql, …)
├── schema.sql           # optional full snapshot for docs
├── seeds/               # dev/test fixtures
└── exercises/           # Project 4 ad-hoc query files (*.sql)
```

---

## Commands you'll use often

| Intent | Command | Notes |
|--------|---------|-------|
| Interactive shell | `psql "$DATABASE_URL"` | Meta-commands start with `\` |
| List tables | `\dt` | Inside psql |
| Explain plan | `EXPLAIN ANALYZE SELECT ...` | Verify index use on hot queries |
| Run file | `psql "$DATABASE_URL" -f exercises/01.sql` | Lab exercises |
| Describe table | `\d table_name` | Columns, indexes, constraints |

---

## How concepts show up

**Transactions & correctness**

- **ACID**, **isolation levels** (read committed vs repeatable read vs serializable): choose to match **lost update / phantom read** tolerance vs contention.
- **Application-level idempotency** still matters when **at-least-once** delivery hits your DB.

**Performance shape**

- **Indexes** trade **write cost + storage** for **read selectivity**; **composite** index column order follows **filter + sort** shape of real queries.
- **EXPLAIN** (or `EXPLAIN ANALYZE`) is how you verify **plan** matches intent—ORM “simple” APIs can hide **seq scans** or **N+1 query**.

**Schema change**

- **Migrations** are **deploy steps**—**expand/contract** and **backfill** patterns for zero-downtime at scale; **locks** on big tables are operational risks.

**“Leaks” in SQL terms**

- **Connection pools** exhausted; **long transactions** holding locks; **unbounded queries** (missing `LIMIT`, huge `IN (...)` lists).

---

## Footguns

- [ ] **N+1 queries** from ORM defaults—profile request paths; use **eager loading** or **SQL joins** intentionally.
- [ ] **`SELECT *`** in hot paths—breaks when schema evolves; select **columns** you need.
- [ ] **Nullable columns** + **aggregates**—`COUNT(*)` vs `COUNT(col)` semantics; surprise null math.
- [ ] **Migration ordering** in CI vs prod—**backward-compatible** deploy when app and DB roll separately.

---

## Plain language: terms used on this page

Skim slowly—you are **not** expected to memorize everything tonight.

- **Declarative vs planner** — You say *what data* you want (SQL looks like a checklist); the engine chooses *how* to fetch it.
- **Dialect** — Vendor-specific quirks on top of “standard” SQL punctuation and functions.
- **object-relational mapper (ORM)** — Code layer that hides raw SQL—you still owe the database sane queries.
- **ACID / isolation levels** — Rules for locking and visibility when many transactions overlap (prevents spooky partial reads—or trades speed for strictness depending on setting).
- **Lost update / phantom read** — Two sessions stepping on each other’s writes or seeing odd mid-flight rows—isolation knobs exist to tame them.
- **At-least-once delivery / idempotency** — Messaging systems may deliver duplicates; databases still need safeguards so writing twice doesn’t corrupt data (**idempotency** = same request twice = safe).
- **Index** — Fast lookup structure; every index costs extra disk and slows some writes.
- **Composite index** — One index covering multiple columns—**column order** should match how you filter/sort in real queries.
- **EXPLAIN / EXPLAIN ANALYZE** — Database report showing the **execution plan** (did it scan the whole table or use an index?).
- **Seq scan** — Reading a whole table because no index helped—fine for tiny tables, dangerous for big ones.
- **N+1 query** — One query for parents + one per child row—ORM default sometimes; fix with joins or batch loading.
- **Eager loading** — Fetch related rows in one round trip so the ORM doesn’t surprise you per row.
- **Migration** — Versioned schema change script run during deploy.
- **Expand/contract / backfill** — Safe pattern: add new shape, copy data, switch readers, remove old shape—avoids downtime drama.
- **Connection pool** — Reused DB connections; exhausting it makes the app wait even if SQL is fast.
- **Long transaction** — Holds locks a long time—blocks other work.
- **Unbounded query** — Missing `LIMIT` or giant `IN (...)` lists—can flatten the database.

### Read next (handbook)

- **[Transactions and ACID](../concepts/database-design.md#transactions-and-acid)** — isolation levels and phenomena match many terms above.
- **[ORMs and the N+1 query pattern](../concepts/database-design.md#orms-and-the-n1-query-pattern)** — how ORMs create round-trip explosions.
- **[Indexes](../concepts/database-design.md#indexes)** — planner and covering indexes in depth.
- **[Example: idempotent webhook or job](../concepts/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — DB + messaging + retries in one narrative.
- **[Memory and performance](../concepts/memory-and-performance.md)** — app + DB tuning workflow; [Project 4](../../career-project-specs/04-sql-performance-lab.md) for SQL depth.

---

## See also

- [Database design](../concepts/database-design.md) — depth reference
- [Software engineering breadth](../concepts/software-engineering.md) — persistence and integration sections
- Your ORM’s doc: **session/transaction** boundaries and **lazy vs eager** loading
