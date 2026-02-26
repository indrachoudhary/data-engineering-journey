/*
========================================
Day 11 - Subqueries & CTE
========================================
*/

-- =====================================
-- 1. Scalar Subquery
-- =====================================

SELECT *
FROM orders
WHERE amount > (
    SELECT AVG(amount)
    FROM orders
);


-- =====================================
-- 2. Correlated Subquery
-- =====================================

SELECT *
FROM orders o
WHERE amount > (
    SELECT AVG(amount)
    FROM orders
    WHERE customer_id = o.customer_id
);


-- =====================================
-- 3. Subquery in FROM
-- =====================================

SELECT
    customer_id,
    COUNT(*) AS large_orders
FROM (
    SELECT *
    FROM orders
    WHERE amount > 100
) t
GROUP BY customer_id;


-- =====================================
-- 4. CTE Version
-- =====================================

WITH large_orders AS (
    SELECT *
    FROM orders
    WHERE amount > 100
)
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM large_orders
GROUP BY customer_id;