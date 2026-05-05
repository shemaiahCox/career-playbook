-- Baseline schema: only PKs and FKs so indexing exercises start from a cold optimizer.

CREATE TABLE customers (
    id bigserial PRIMARY KEY,
    tenant_id text NOT NULL,
    name text NOT NULL
);

CREATE TABLE orders (
    id bigserial PRIMARY KEY,
    tenant_id text NOT NULL,
    customer_id bigint NOT NULL REFERENCES customers (id),
    status text NOT NULL DEFAULT 'open',
    amount_cents int NOT NULL DEFAULT 0,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE wallet (
    tenant_id text PRIMARY KEY,
    balance_cents int NOT NULL DEFAULT 0
);
