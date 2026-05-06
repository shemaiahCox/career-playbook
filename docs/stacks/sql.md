# Ecosystem map: SQL and relational databases

**Use this:** You **design queries, migrations, or schema** and need a **shared vocabulary** across Postgres, MySQL, SQL Server, SQLite—**not** a duplicate of the full [database design](../handbook/database-design.md) reference.

**Companion:** [term cards](README.md) · [SQL performance lab](../../project-specs/07-sql-performance-lab.md) · [database design](../handbook/database-design.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **SQL role** | **Declarative**: you describe *what* rows you want; the **planner** chooses *how* (indexes, joins, order). |
| **Dialects** | **ANSI SQL** is a baseline; every engine adds types, functions, and edge cases (**`LIMIT`/`OFFSET`**, **window functions**, **`RETURNING`**). Prefer **one** canonical engine per product where possible. |
| **Boundaries** | **ORMs** (Django, SQLAlchemy, EF, Eloquent) **emit** SQL—debugging often means reading **generated SQL** and **plans**. |

---

## How concepts show up

**Transactions & correctness**

- **ACID**, **isolation levels** (read committed vs repeatable read vs serializable): choose to match **lost update / phantom read** tolerance vs contention.
- **Application-level idempotency** still matters when **at-least-once** delivery hits your DB.

**Performance shape**

- **Indexes** trade **write cost + storage** for **read selectivity**; **composite** index column order follows **filter + sort** shape of real queries.
- **EXPLAIN** (or `EXPLAIN ANALYZE`) is how you verify **plan** matches intent—ORM “simple” APIs can hide **seq scans** or **N+1**.

**Schema change**

- **Migrations** are **deploy steps**—**expand/contract** and **backfill** patterns for zero-downtime at scale; **locks** on big tables are operational risks.

**“Leaks” in SQL terms**

- **Connection pools** exhausted; **long transactions** holding locks; **unbounded queries** (missing `LIMIT`, huge `IN (...)` lists).

---

## Footgun checklist

- [ ] **N+1 queries** from ORM defaults—profile request paths; use **eager loading** or **SQL joins** intentionally.
- [ ] **`SELECT *`** in hot paths—breaks when schema evolves; select **columns** you need.
- [ ] **Nullable columns** + **aggregates**—`COUNT(*)` vs `COUNT(col)` semantics; surprise null math.
- [ ] **Migration ordering** in CI vs prod—**backward-compatible** deploy when app and DB roll separately.

---

## See also

- [Database design](../handbook/database-design.md) — depth reference
- [Software engineering breadth](../handbook/software-engineering.md) — persistence and integration sections
- Your ORM’s doc: **session/transaction** boundaries and **lazy vs eager** loading
