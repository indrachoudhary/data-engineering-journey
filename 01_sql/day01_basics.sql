-- =====================================================
-- Day 01 - SQL Basics
-- Author: Indra Choudhary
-- Description: Aggregations, Filtering, Group By, Having
-- =====================================================


-- Table: orders
-- Columns: order_id, customer_id, order_date, amount, country


-- 1️⃣ Total Revenue
SELECT SUM(amount) AS total_revenue
FROM orders;


-- 2️⃣ Total Revenue Per Country
SELECT country, SUM(amount) AS total_revenue
FROM orders
GROUP BY country;


-- 3️⃣ Customers Who Spent More Than 400 In Total
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 400;


-- 4️⃣ Number of Orders Per Day
SELECT order_date, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date;


-- 5️⃣ Highest Single Order Amount
SELECT MAX(amount) AS highest_order
FROM orders;



-- =============================
-- CONCEPT NOTES
-- =============================

-- SELECT: Used to retrieve columns from a table.
-- WHERE: Filters rows before aggregation.
-- GROUP BY: Groups rows to apply aggregation functions.
-- HAVING: Filters results after aggregation.
-- Aggregation: Operations like SUM, COUNT, AVG, MAX, MIN applied to grouped data.
