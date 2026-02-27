-- =========================================
-- DAY 13: POSTGRESQL INDEX PRACTICE
-- =========================================

DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    user_id INT,
    status TEXT,
    amount NUMERIC,
    transaction_date DATE
);

-- Insert 200,000 rows of test data
INSERT INTO transactions (user_id, status, amount, transaction_date)
SELECT
    (random() * 10000)::int,
    CASE
        WHEN random() < 0.7 THEN 'completed'
        WHEN random() < 0.9 THEN 'pending'
        ELSE 'failed'
    END,
    (random() * 1000)::numeric(10,2),
    CURRENT_DATE - (random() * 365)::int
FROM generate_series(1, 200000);

ANALYZE transactions;

-- =========================================
-- 1. SEQ SCAN TEST
-- =========================================

EXPLAIN ANALYZE
SELECT *
FROM transactions
WHERE user_id = 500;

-- =========================================
-- 2. ADD INDEX ON user_id
-- =========================================

CREATE INDEX idx_transactions_user
ON transactions(user_id);

ANALYZE transactions;

EXPLAIN ANALYZE
SELECT *
FROM transactions
WHERE user_id = 500;

-- =========================================
-- 3. COMPOSITE INDEX TEST
-- =========================================

CREATE INDEX idx_transactions_user_date
ON transactions(user_id, transaction_date);

ANALYZE transactions;

EXPLAIN ANALYZE
SELECT *
FROM transactions
WHERE user_id = 500
AND transaction_date >= '2026-01-01';

-- =========================================
-- 4. LOW SELECTIVITY TEST
-- =========================================

EXPLAIN ANALYZE
SELECT *
FROM transactions
WHERE status = 'completed';

-- =========================================
-- 5. PARTIAL INDEX TEST
-- =========================================

CREATE INDEX idx_failed_status
ON transactions(status)
WHERE status = 'failed';

ANALYZE transactions;

EXPLAIN ANALYZE
SELECT *
FROM transactions
WHERE status = 'failed';

-- =========================================
-- 6. INDEX ONLY SCAN TEST
-- =========================================

VACUUM ANALYZE transactions;

EXPLAIN ANALYZE
SELECT COUNT(*)
FROM transactions
WHERE status = 'failed';

-- =========================================
-- END OF DAY 13
-- =========================================