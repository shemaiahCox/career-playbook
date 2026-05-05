-- Exercise 2 — Indexing: composite and partial
-- Adds helpful indexes; compare plans to exercise 1.
-- Safe to re-run: drops demo indexes first.

DROP INDEX IF EXISTS idx_orders_tenant_created;
DROP INDEX IF EXISTS idx_orders_open_partial;

CREATE INDEX idx_orders_tenant_created
    ON orders (tenant_id, created_at DESC);

-- Hot slice: only "open" rows for a tenant list many products scan frequently.
CREATE INDEX idx_orders_open_partial
    ON orders (tenant_id, created_at DESC)
    WHERE status = 'open';

ANALYZE orders;

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
