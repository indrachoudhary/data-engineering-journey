-- =====================================================
-- Day 05 - Window Functions
-- Author: Indra Choudhary
-- Description: Ranking functions, running totals,
--              partitioning, and interview patterns
-- =====================================================


-- Sample Table:
-- orders(order_id, customer_id, amount, order_date)



-- =====================================================
-- 1️⃣ Total Per Customer (without collapsing rows)
-- =====================================================

SELECT order_id,
       customer_id,
       amount,
       SUM(amount) OVER (
           PARTITION BY customer_id
       ) AS total_per_customer
FROM orders;



-- =====================================================
-- 2️⃣ Running Total Per Customer
-- =====================================================

SELECT order_id,
       customer_id,
       amount,
       SUM(amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_id
       ) AS running_total
FROM orders;



-- =====================================================
-- 3️⃣ ROW_NUMBER() - Unique Ranking
-- =====================================================

SELECT order_id,
       customer_id,
       amount,
       ROW_NUMBER() OVER (
           PARTITION BY customer_id
           ORDER BY amount DESC
       ) AS rn
FROM orders;



-- =====================================================
-- 4️⃣ RANK() - Ranking With Gaps
-- =====================================================

SELECT order_id,
       customer_id,
       amount,
       RANK() OVER (
           PARTITION BY customer_id
           ORDER BY amount DESC
       ) AS rank_value
FROM orders;



-- =====================================================
-- 5️⃣ DENSE_RANK() - Ranking Without Gaps
-- =====================================================

SELECT order_id,
       customer_id,
       amount,
       DENSE_RANK() OVER (
           PARTITION BY customer_id
           ORDER BY amount DESC
       ) AS dense_rank_value
FROM orders;



-- =====================================================
-- 6️⃣ Top 1 Order Per Customer (Interview Pattern)
-- =====================================================

SELECT *
FROM (
    SELECT order_id,
           customer_id,
           amount,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY amount DESC
           ) AS rn
    FROM orders
) t
WHERE rn = 1;



-- =====================================================
-- 7️⃣ Global Ranking (No PARTITION BY)
-- =====================================================

SELECT order_id,
       customer_id,
       amount,
       ROW_NUMBER() OVER (
           ORDER BY amount DESC
       ) AS global_rank
FROM orders;



-- =====================================================
-- 8️⃣ Running Total Without Partition (Whole Table)
-- =====================================================

SELECT order_id,
       customer_id,
       amount,
       SUM(amount) OVER (
           ORDER BY order_id
       ) AS running_total_global
FROM orders;



-- =====================================================
-- KEY LEARNINGS
-- =====================================================

-- Window functions preserve rows.
-- GROUP BY collapses rows.
-- PARTITION BY defines grouping.
-- ORDER BY defines calculation order.
-- With ORDER BY → cumulative behavior.
-- Without ORDER BY → full partition total.
-- ROW_NUMBER() is safest for Top-N per group.