# Day 05 - Window Functions

## What Are Window Functions?

Window functions perform calculations across a set of rows
related to the current row without collapsing the result set.

Unlike GROUP BY:
- GROUP BY collapses rows
- Window functions preserve rows

---

## Basic Syntax

FUNCTION() OVER (
    PARTITION BY column
    ORDER BY column
)

---

## PARTITION BY

- Divides rows into groups
- Similar to GROUP BY
- Does NOT reduce row count
- Calculation resets per partition

If omitted → entire table is one partition

---

## ORDER BY (inside OVER)

- Defines order of rows within partition
- Required for ranking functions
- Required for running calculations
- Creates cumulative behavior by default

---

## Aggregate Window Functions

### Total Per Group

SUM(amount) OVER (
    PARTITION BY customer_id
)

Returns same total value for each row in that partition.

---

### Running Total

SUM(amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_id
)

Calculates cumulative sum from first row to current row.

Rule:
- With ORDER BY → running total
- Without ORDER BY → total per partition

---

## Ranking Functions

### ROW_NUMBER()

- Always unique
- No ties
- Best for "Top 1 per group"

ROW_NUMBER() OVER (
    PARTITION BY customer_id
    ORDER BY amount DESC
)

---

### RANK()

- Same rank for ties
- Skips numbers

Example:
1, 1, 3

---

### DENSE_RANK()

- Same rank for ties
- No gaps

Example:
1, 1, 2

---

## Choosing Ranking Function

Use ROW_NUMBER() when:
- You need exactly N rows
- Example: Top 1 per customer

Use RANK() or DENSE_RANK() when:
- Ties should be preserved

---

## Common Interview Pattern

Top 1 highest order per customer:

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY amount DESC
           ) AS rn
    FROM orders
) t
WHERE rn = 1;

---

## Common Mistakes

1. Forgetting PARTITION BY → global ranking
2. Using DENSE_RANK() when exactly 1 row is needed
3. Forgetting ORDER BY in running totals
4. Confusing GROUP BY with window functions

---

## Key Differences: GROUP BY vs Window Function

GROUP BY:
- Collapses rows
- One row per group

Window Function:
- Preserves rows
- Adds calculated column

---

## Core Mental Model

Window functions:
- Look sideways (across rows)
- But do not merge rows

GROUP BY:
- Compresses rows into summary rows

---

## Real Engineering Insight

Window functions are used for:
- Ranking
- Deduplication
- Running metrics
- Session analysis
- Change detection
- Time-series analytics

They separate intermediate SQL from advanced SQL.