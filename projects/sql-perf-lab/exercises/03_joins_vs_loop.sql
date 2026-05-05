-- Exercise 3 — Loop-shaped (correlated) vs join aggregation
-- Correlated pattern often mirrors ORM N+1; join pattern fetches in one pass.

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.id,
       c.name,
       (
           SELECT count(*)::bigint
           FROM orders o
           WHERE o.customer_id = c.id
       ) AS order_count
FROM customers c
WHERE c.tenant_id = 't-001'
ORDER BY c.id
LIMIT 200;

EXPLAIN (ANALYZE, BUFFERS)
SELECT c.id,
       c.name,
       count(o.id) AS order_count
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
WHERE c.tenant_id = 't-001'
GROUP BY c.id, c.name
ORDER BY c.id
LIMIT 200;
