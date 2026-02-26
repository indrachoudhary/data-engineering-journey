# Day 11 - Subqueries & CTE Mastery

## What is a Subquery?

A query inside another query.

Types:
1. Scalar subquery (returns single value)
2. Correlated subquery
3. Subquery in FROM
4. Subquery in WHERE

--------------------------------------------------

## 1. Scalar Subquery

Example:
Find orders above average amount.

SELECT *
FROM orders
WHERE amount > (
    SELECT AVG(amount) FROM orders
);

--------------------------------------------------

## 2. Correlated Subquery

Executed per row.

SELECT *
FROM orders o
WHERE amount > (
    SELECT AVG(amount)
    FROM orders
    WHERE customer_id = o.customer_id
);

--------------------------------------------------

## 3. Subquery in FROM

Acts like temporary table.

SELECT customer_id, COUNT(*)
FROM (
    SELECT *
    FROM orders
    WHERE amount > 100
) t
GROUP BY customer_id;

--------------------------------------------------

## What is a CTE?

CTE = Common Table Expression

Cleaner version of subquery.

WITH temp_table AS (
    SELECT ...
)
SELECT * FROM temp_table;

--------------------------------------------------

## Why CTE is Better

- More readable
- Reusable
- Cleaner logic separation
- Easier debugging

--------------------------------------------------

## Interview Insight

Subquery = works  
CTE = professional