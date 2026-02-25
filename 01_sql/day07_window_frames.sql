/*
========================================
Day 07 - Window Frames & Moving Averages
========================================
*/

-- =====================================
-- 1. Cumulative Sum
-- =====================================

SELECT
    customer_id,
    order_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_total
FROM orders;


-- =====================================
-- 2. Rolling 3-Row Sum
-- =====================================

SELECT
    customer_id,
    order_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3_sum
FROM orders;


-- =====================================
-- 3. Moving Average (Last 3 Orders)
-- =====================================

SELECT
    customer_id,
    order_date,
    amount,
    AVG(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3
FROM orders;


-- =====================================
-- 4. Forward Looking Window
-- =====================================

SELECT
    customer_id,
    order_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS next_3_orders_sum
FROM orders;


-- =====================================
-- 5. Entire Partition Total (No Group By)
-- =====================================

SELECT
    customer_id,
    order_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS total_per_customer
FROM orders;