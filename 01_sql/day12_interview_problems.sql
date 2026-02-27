/*
========================================
Day 12 - Hard SQL Interview Problems
========================================
*/

-- =====================================
-- 1. Second Highest Salary
-- =====================================

SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (
    SELECT MAX(salary) FROM employees
);


-- =====================================
-- 2. Customers Who Never Ordered
-- =====================================

SELECT *
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;


-- =====================================
-- 3. Top 3 Orders Per Customer
-- =====================================

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY amount DESC
           ) AS rn
    FROM orders
) t
WHERE rn <= 3;


-- =====================================
-- 4. Employees Earning More Than Manager
-- =====================================

SELECT e.*
FROM employees e
JOIN employees m
    ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;


-- =====================================
-- 5. Find Duplicate Emails
-- =====================================

SELECT email, COUNT(*)
FROM users
GROUP BY email
HAVING COUNT(*) > 1;