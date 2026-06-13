# Ecosystem map: SQL and relational databases

**Use this:** You **design queries, migrations, or schema** and need a **shared vocabulary** across Postgres, MySQL, SQL Server, SQLite—**not** a duplicate of the full [database design](../concepts/database-design.md) reference.

**Companion:** [docs README](../README.md) · [SQL performance lab](../../career-project-specs/04-sql-performance-lab.md) · [database design](../concepts/database-design.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **SQL role** | **Declarative** means you describe *what* rows you want, not micromanage each algorithm step—the database **query planner** picks **indexes, joins, and order**. |
| **Dialects** | **ANSI SQL** is a loose shared baseline; Postgres, MySQL, SQL Server, SQLite each extend it (**`LIMIT`/`OFFSET`**, **`RETURNING`**, window functions, etc.—details differ). Pick **one** production engine story when you can—it cuts surprises. |
| **Boundaries** | **ORMs** (Object-Relational Mappers—Django, SQLAlchemy, EF, Eloquent…) **generate** SQL—you still inspect **plans** when performance or correctness breaks. |

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

## Plain language: terms used on this page

Skim slowly—you are **not** expected to memorize everything tonight.

- **Declarative vs planner** — You say *what data* you want (SQL looks like a checklist); the engine chooses *how* to fetch it.
- **Dialect** — Vendor-specific quirks on top of “standard” SQL punctuation and functions.
- **ORM** — Code layer that hides raw SQL—you still owe the database sane queries.
- **ACID / isolation levels** — Rules for locking and visibility when many transactions overlap (prevents spooky partial reads—or trades speed for strictness depending on setting).
- **Lost update / phantom read** — Two sessions stepping on each other’s writes or seeing odd mid-flight rows—isolation knobs exist to tame them.
- **At-least-once delivery / idempotency** — Messaging systems may deliver duplicates; databases still need safeguards so writing twice doesn’t corrupt data (**idempotency** = same request twice = safe).
- **Index** — Fast lookup structure; every index costs extra disk and slows some writes.
- **Composite index** — One index covering multiple columns—**column order** should match how you filter/sort in real queries.
- **EXPLAIN / EXPLAIN ANALYZE** — Database report showing the **execution plan** (did it scan the whole table or use an index?).
- **Seq scan** — Reading a whole table because no index helped—fine for tiny tables, dangerous for big ones.
- **N+1** — One query for parents + one per child row—ORM default sometimes; fix with joins or batch loading.
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
