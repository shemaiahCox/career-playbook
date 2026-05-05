# sql-perf-lab

Small **PostgreSQL** playground for **query plans**, **index design**, **join vs loop-shaped** queries, **transactions**, **keyset pagination**, and an optional **materialized-view** rollup.

**Repository:** [github.com/shemaiahCox/sql-perf-lab](https://github.com/shemaiahCox/sql-perf-lab) · `git@github.com:shemaiahCox/sql-perf-lab.git`

**Companion spec (Project 7):** [career-playbook — `07-sql-performance-lab.md`](https://github.com/shemaiahCox/career-playbook/blob/main/project-specs/07-sql-performance-lab.md). If you have this repo under `career-playbook/projects/sql-perf-lab`, open [`../../project-specs/07-sql-performance-lab.md`](../../project-specs/07-sql-performance-lab.md) locally.

## Prerequisites

- Docker with Compose v2

## Run Postgres

```bash
docker compose up -d
```

Database listens on **localhost:5433** (avoids clashing with a local 5432).

```bash
export DATABASE_URL=postgresql://lab:lab@localhost:5433/sqllab
```

Wait until `pg_isready` succeeds:

```bash
until docker compose exec db pg_isready -U lab -d sqllab; do sleep 1; done
```

## Load / reset data

Schema and seed apply **only on first** container init. To replay from scratch:

```bash
docker compose down -v
docker compose up -d
```

## Exercises

Run in order (later files assume objects created by earlier ones, e.g. indexes in `02_indexes.sql`):

```bash
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f exercises/01_plans.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f exercises/02_indexes.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f exercises/03_joins_vs_loop.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f exercises/04_transactions.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f exercises/05_pagination.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f exercises/06_rollup_stretch.sql
```

**04** is the **ACID** drill: `ROLLBACK` (atomicity), FK failure (consistency), `FOR UPDATE` + commit (isolation), and comments on durability — plus an optional two-session **lost-update** on `t-002`.

## Before / after story (what to capture for interviews)

1. **01 → 02:** `EXPLAIN (ANALYZE, BUFFERS)` on the `tenant_id + created_at` filter should move from **Seq Scan** on `orders` to an **Index Scan** using `idx_orders_tenant_created`; the partial index should help **open-only** counts.
2. **03:** Correlated scalar subquery vs **GROUP BY** join — compare total time and nested-loop behavior.
3. **05:** `OFFSET 50000` cost vs keyset seek plan on the same sort order.
4. **04:** Tie **ACID** to behavior: same balance after `ROLLBACK`; FK error + `ROLLBACK`; committed debit after `FOR UPDATE`.

## Safety on a laptop

- Dataset is modest (~80k `orders`); `EXPLAIN ANALYZE` still executes the query—avoid uncapped scans on huge tables in shared environments.
- If you grow seeds into the millions, add a **statement_timeout** in `psql` and consider running against a throwaway instance only.

## Clone and Git

```bash
git clone git@github.com:shemaiahCox/sql-perf-lab.git
cd sql-perf-lab
```

If you started from an empty GitHub repo and already have commits locally:

```bash
git remote add origin git@github.com:shemaiahCox/sql-perf-lab.git
git branch -M main
git push -u origin main
```
