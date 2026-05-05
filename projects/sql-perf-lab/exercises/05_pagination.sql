-- Exercise 5 — Keyset vs OFFSET pagination
-- Keyset stays stable as the user walks the list; OFFSET rescans skipped rows.

\timing on

EXPLAIN (ANALYZE, BUFFERS)
SELECT o.id, o.created_at, o.status
FROM orders o
WHERE o.tenant_id = 't-001'
ORDER BY o.created_at DESC, o.id DESC
OFFSET 50000
LIMIT 50;

-- First page: note the last (created_at, id) pair from this result for the next query.
EXPLAIN (ANALYZE, BUFFERS)
SELECT o.id, o.created_at, o.status
FROM orders o
WHERE o.tenant_id = 't-001'
ORDER BY o.created_at DESC, o.id DESC
LIMIT 50;

-- Second page using keyset: substitute :last_created and :last_id from the last row of the prior page.
-- Example placeholders (adjust to real values from your first page):
-- WHERE (created_at, id) < ('2025-01-15 12:00:00+00'::timestamptz, 12345)

PREPARE keyset_page (timestamptz, bigint) AS
SELECT o.id, o.created_at, o.status
FROM orders o
WHERE o.tenant_id = 't-001'
  AND (o.created_at, o.id) < ($1, $2)
ORDER BY o.created_at DESC, o.id DESC
LIMIT 50;

-- Run after you copy real values from the first page (example only — will return 0 rows if no match):
-- EXECUTE keyset_page ('2020-01-01'::timestamptz, 999999999);

DEALLOCATE keyset_page;
