-- Exercise 6 — Stretch: rollup with materialized view
-- Refresh strategy in prod is usually SCHEDULE or trigger-driven; here we run REFRESH manually.

DROP MATERIALIZED VIEW IF EXISTS daily_order_totals;

CREATE MATERIALIZED VIEW daily_order_totals AS
SELECT date_trunc('day', created_at) AS day,
       tenant_id,
       count(*)::bigint AS order_count,
       sum(amount_cents)::bigint AS revenue_cents
FROM orders
GROUP BY 1, 2;

CREATE UNIQUE INDEX idx_daily_order_totals_key ON daily_order_totals (day, tenant_id);

REFRESH MATERIALIZED VIEW CONCURRENTLY daily_order_totals;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM daily_order_totals
WHERE tenant_id = 't-001'
ORDER BY day DESC
LIMIT 14;

EXPLAIN (ANALYZE, BUFFERS)
SELECT date_trunc('day', created_at) AS day,
       tenant_id,
       count(*)::bigint AS order_count,
       sum(amount_cents)::bigint AS revenue_cents
FROM orders
WHERE tenant_id = 't-001'
GROUP BY 1, 2
ORDER BY day DESC
LIMIT 14;
