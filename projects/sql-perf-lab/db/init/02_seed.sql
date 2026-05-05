-- Synthetic tenants: t-001 is “large”, t-002 is smaller.
INSERT INTO customers (tenant_id, name)
SELECT 't-001', 'c' || n
FROM generate_series(1, 5000) AS n;

INSERT INTO customers (tenant_id, name)
SELECT 't-002', 'o' || n
FROM generate_series(1, 1000) AS n;

INSERT INTO orders (tenant_id, customer_id, status, amount_cents, created_at)
SELECT 't-001',
    (1 + floor(random() * 5000))::bigint,
    CASE
        WHEN random() < 0.72 THEN 'open'
        WHEN random() < 0.95 THEN 'shipped'
        ELSE 'canceled'
    END,
    (random() * 100000)::int,
    now() - (random() * interval '400 days')
FROM generate_series(1, 75000) AS g;

INSERT INTO orders (tenant_id, customer_id, status, amount_cents, created_at)
SELECT 't-002',
    (5001 + floor(random() * 1000))::bigint,
    CASE
        WHEN random() < 0.5 THEN 'open'
        ELSE 'shipped'
    END,
    (random() * 50000)::int,
    now() - (random() * interval '200 days')
FROM generate_series(1, 8000) AS g;

INSERT INTO wallet (tenant_id, balance_cents)
VALUES ('t-001', 1000000),
       ('t-002', 500000);

ANALYZE customers;
ANALYZE orders;
ANALYZE wallet;
