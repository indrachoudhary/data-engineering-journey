-- =====================================================
-- Day 03 - Advanced JOIN Behavior & Execution Order
-- Author: Indra Choudhary
-- Description: RIGHT JOIN, FULL OUTER JOIN, CROSS JOIN,
--              LEFT JOIN filtering issue, execution order
-- =====================================================


-- Sample Tables:
-- customers(customer_id, name, country)
-- orders(order_id, customer_id, amount)



-- 1️⃣ RIGHT JOIN
-- Keeps all rows from the right table (orders)

SELECT c.customer_id,
       c.name,
       o.order_id,
       o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;



-- 2️⃣ FULL OUTER JOIN
-- Keeps all rows from both tables

SELECT c.customer_id,
       c.name,
       o.order_id,
       o.amount
FROM customers c
FULL OUTER JOIN orders o
ON c.customer_id = o.customer_id;



-- 3️⃣ CROSS JOIN (Cartesian Product)
-- Every row from customers × every row from orders

SELECT *
FROM customers c
CROSS JOIN orders o;



-- 4️⃣ LEFT JOIN behaving like INNER JOIN (common mistake)

SELECT c.customer_id,
       c.name,
       COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.amount > 100
GROUP BY c.customer_id, c.name;


-- Problem:
-- WHERE removes NULL rows from LEFT JOIN,
-- effectively turning it into an INNER JOIN.



-- 5️⃣ Correct Way: Filter inside JOIN condition

SELECT c.customer_id,
       c.name,
       COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
AND o.amount > 100
GROUP BY c.customer_id, c.name;



-- =============================
-- EXECUTION ORDER (Logical)
-- =============================

-- 1. FROM
-- 2. JOIN
-- 3. WHERE
-- 4. GROUP BY
-- 5. HAVING
-- 6. SELECT
-- 7. ORDER BY



-- =============================
-- KEY LEARNINGS
-- =============================

-- RIGHT JOIN keeps all rows from right table.
-- FULL OUTER JOIN keeps all rows from both tables.
-- CROSS JOIN creates Cartesian product.
-- WHERE can unintentionally turn LEFT JOIN into INNER JOIN.
-- Filtering inside JOIN preserves LEFT JOIN behavior.
-- Understanding execution order is critical for debugging.
