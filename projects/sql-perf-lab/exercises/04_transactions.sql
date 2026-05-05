-- Exercise 4 — ACID practice (Postgres)
--
-- A — Atomicity:   ROLLBACK drops every change in the transaction.
-- C — Consistency: Constraints reject illegal rows; failed txn must ROLLBACK.
-- I — Isolation:   FOR UPDATE + COMMIT demo; optional two-session lost-update.
-- D — Durability:  After COMMIT, data survives restart (WAL); trust + backups in prod.
--
-- After a statement errors inside a transaction, Postgres marks the block aborted.
-- Run ROLLBACK before starting the next BEGIN (psql will remind you).

-- --- A — Atomicity (all-or-nothing): updates undone by ROLLBACK ---
BEGIN;

SELECT balance_cents AS balance_before_rollback
FROM wallet
WHERE tenant_id = 't-001';

UPDATE wallet
SET balance_cents = balance_cents - 50
WHERE tenant_id = 't-001';

UPDATE wallet
SET balance_cents = balance_cents - 50
WHERE tenant_id = 't-001';

ROLLBACK;

SELECT balance_cents AS balance_after_rollback
FROM wallet
WHERE tenant_id = 't-001';
-- Compare to balance_before_rollback: must be identical.

-- --- C — Consistency: FK rejects impossible references; transaction ends in error ---
BEGIN;

INSERT INTO orders (tenant_id, customer_id, status, amount_cents)
VALUES ('t-001', 999999999, 'open', 100);
-- Expect ERROR: violates foreign key constraint "orders_customer_id_fkey"

ROLLBACK;

-- --- I — Isolation: serialize updates to one row with explicit lock, then commit ---
BEGIN;

SELECT balance_cents
FROM wallet
WHERE tenant_id = 't-001'
FOR UPDATE;

UPDATE wallet
SET balance_cents = balance_cents - 100
WHERE tenant_id = 't-001';

SELECT balance_cents AS balance_after_debit
FROM wallet
WHERE tenant_id = 't-001';

COMMIT;

-- --- I — Stretch: lost-update under READ COMMITTED (two psql sessions) ---
-- Session A / B (same pattern, tight timing):
-- A: BEGIN;
-- A: SELECT balance_cents FROM wallet WHERE tenant_id = 't-002';
-- B: BEGIN;
-- B: SELECT balance_cents FROM wallet WHERE tenant_id = 't-002';
-- A: UPDATE wallet SET balance_cents = <A_read + 1000> WHERE tenant_id = 't-002';
-- A: COMMIT;
-- B: UPDATE wallet SET balance_cents = <B_read + 1000> WHERE tenant_id = 't-002';
-- B: COMMIT;
-- One increment is "lost" because B overwrote A with a stale base. Fix in real code:
-- FOR UPDATE, single UPDATE balance = balance + n, SERIALIZABLE+retry, or version column.

-- Optional reset after experiments:
-- UPDATE wallet SET balance_cents = 500000 WHERE tenant_id = 't-002';
