# Day 03 - Advanced JOIN Behavior

## RIGHT JOIN
Returns all rows from the right table.
Non-matching left table values become NULL.

## FULL OUTER JOIN
Returns all rows from both tables.
Non-matching sides contain NULL values.

## CROSS JOIN
Creates a Cartesian product.
Row count = rows in table A × rows in table B.

## LEFT JOIN + WHERE Problem
Using WHERE on the right table can remove NULL rows.
This unintentionally converts LEFT JOIN to INNER JOIN.

## Correct Filtering Strategy
Apply filtering conditions inside the JOIN using:
AND condition

## Logical Execution Order
1. FROM
2. JOIN
3. WHERE
4. GROUP BY
5. HAVING
6. SELECT
7. ORDER BY

## Key Takeaway
Execution order determines query correctness.
Understanding join behavior prevents data corruption and performance issues.
