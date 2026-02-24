# Day 06 - LAG(), LEAD(), Deduplication & Streaks

## What Problem Do LAG and LEAD Solve?

They allow comparing the current row with:

- Previous row (LAG)
- Next row (LEAD)

Without self-joins.

Used for:
- Change detection
- Time difference calculation
- Session analysis
- Trend analysis
- Consecutive event tracking

---

## LAG()

LAG(column, offset, default_value)

Looks backward inside partition.

Example:

LAG(amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
)

- offset default = 1
- Returns NULL if no previous row (unless default provided)

---

## LEAD()

LEAD(column, offset, default_value)

Looks forward inside partition.

Example:

LEAD(amount, 2) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
)

- Looks 2 rows ahead

---

## Days Between Consecutive Events

login_date -
LAG(login_date) OVER (
    PARTITION BY user_id
    ORDER BY login_date
)

Calculates time difference between events.

---

## Detect First Event Per User

CASE
    WHEN LAG(column) OVER (...) IS NULL
    THEN 'First Event'
END

If previous row doesn't exist → first occurrence.

---

## Deduplication Pattern (Industry Standard)

Keep latest record per key:

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY email
               ORDER BY created_at DESC
           ) AS rn
    FROM users
) t
WHERE rn = 1;

ROW_NUMBER() is safest when exactly one row is needed.

---

## Detect Status Change

Use LAG() to compare current and previous status:

WHERE current_status <> previous_status

Used in:
- Subscription changes
- Account state transitions
- Workflow monitoring

---

# 🔥 Streak Detection (Advanced Pattern)

## Problem:
Find consecutive login streaks.

Core Trick:

login_date - ROW_NUMBER()

Why it works:

If:
- Date increases by 1
- Row number increases by 1

Then:
date - row_number remains constant.

That constant becomes streak identifier.

---

## Streak Query Pattern

SELECT user_id,
       COUNT(*) AS streak_length
FROM (
    SELECT user_id,
           login_date,
           login_date -
           ROW_NUMBER() OVER (
               PARTITION BY user_id
               ORDER BY login_date
           ) AS streak_group
    FROM user_logins
) t
GROUP BY user_id, streak_group;

---

## Key Insight

If two sequences increase at the same rate,
their difference stays constant.

This is mathematical reasoning applied to SQL.

---

## Common Mistakes

1. Forgetting ORDER BY in window functions
2. Not partitioning by entity (user_id)
3. Using RANK() when ROW_NUMBER() is required
4. Using DISTINCT instead of fixing duplicates
5. Not checking data gaps before streak analysis

---

## Mental Models

LAG = look backward  
LEAD = look forward  
ROW_NUMBER = assign sequence  
date - row_number = streak grouping  

---

## Engineering Takeaway

Window functions allow:

- Row-wise comparison
- Event tracking
- Pattern detection
- Data deduplication
- Time-series segmentation

This separates beginner SQL from advanced SQL.