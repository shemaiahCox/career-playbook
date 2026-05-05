-- Exercise 1 — Plans: EXPLAIN vs EXPLAIN ANALYZE
-- Expect: sequential scan on orders at baseline (no secondary indexes yet).
-- Run: psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f exercises/01_plans.sql

\timing on

EXPLAIN
SELECT o.id, o.status, o.amount_cents
FROM orders o
WHERE o.tenant_id = 't-001'
  AND o.created_at > now() - interval '30 days';

EXPLAIN (ANALYZE, BUFFERS)
SELECT o.id, o.status, o.amount_cents
FROM orders o
WHERE o.tenant_id = 't-001'
  AND o.created_at > now() - interval '30 days';

EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*)
FROM orders o
WHERE o.tenant_id = 't-001'
  AND o.status = 'open';
