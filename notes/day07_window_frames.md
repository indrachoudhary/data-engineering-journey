# Day 07 - Window Frames & Moving Averages

Until now:
- We used PARTITION BY
- We used ORDER BY
- We used window functions

Today we control HOW MANY rows the window sees.

This is called a WINDOW FRAME.

----------------------------------------------------

## Default Behavior

When you use:

SUM(amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
)

SQL automatically uses:

RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

This gives cumulative total.

----------------------------------------------------

## Window Frame Types

ROWS → Physical rows
RANGE → Logical value range (based on ORDER BY column)

Important:
ROWS is predictable.
RANGE can group ties together.

In interviews → prefer ROWS.

----------------------------------------------------

## Syntax Structure

SUM(amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)

General pattern:

ROWS BETWEEN
    X PRECEDING
    AND Y FOLLOWING

----------------------------------------------------

## Common Frame Examples

1. Cumulative Sum

ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

2. Moving Average (last 3 rows)

ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

3. Forward Looking Window

ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING

4. Entire Partition

ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING

----------------------------------------------------

## Moving Average Example

AVG(amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)

Calculates rolling 3-order average.

----------------------------------------------------

## Key Difference

ROWS:
Counts exact rows.

RANGE:
Groups rows with same ORDER BY value.

Example:
If 3 orders have same date,
RANGE may include all 3 together.

----------------------------------------------------

## Why This Matters

Used in:
- Financial analytics
- Revenue trends
- Stock analysis
- Retention analysis
- Time series smoothing

----------------------------------------------------

## Interview Insight

Window function = WHAT
Window frame = HOW MUCH data to include

Without frame → cumulative
With frame → sliding window