-- =====================================================
-- Day 02 - SQL JOINs and NULL Handling
-- Author: Indra Choudhary
-- Description: INNER JOIN, LEFT JOIN, COUNT behavior, SUM with NULL
-- =====================================================


-- Sample Tables:
-- customers(customer_id, name, country)
-- orders(order_id, customer_id, amount)


-- 1️⃣ INNER JOIN Example
-- Returns only matching records between customers and orders

SELECT c.customer_id,
       c.name,
       o.order_id,
       o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;



-- 2️⃣ LEFT JOIN Example
-- Returns all customers, even if they have no orders

SELECT c.customer_id,
       c.name,
       o.order_id,
       o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;



-- 3️⃣ Total Amount Spent Per Customer
-- Note: SUM returns NULL if no matching rows

SELECT c.customer_id,
       c.name,
       SUM(o.amount) AS total_spent
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;



-- 4️⃣ Handling NULL with COALESCE

SELECT c.customer_id,
       c.name,
       COALESCE(SUM(o.amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;



-- 5️⃣ COUNT Difference

-- COUNT(column) counts only non-null values
SELECT c.customer_id,
       COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id;


-- COUNT(*) counts rows (even if columns are NULL)
SELECT c.customer_id,
       COUNT(*) AS row_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id;



-- =============================
-- KEY LEARNINGS
-- =============================

-- INNER JOIN returns only matching rows.
-- LEFT JOIN keeps all rows from left table.
-- SUM() returns NULL if all values are NULL.
-- COUNT(column) ignores NULL values.
-- COUNT(*) counts rows.
-- COALESCE() replaces NULL with a specified value.
