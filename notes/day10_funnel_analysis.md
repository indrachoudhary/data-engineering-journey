# Day 10 - Funnel Analysis

## What is a Funnel?

A funnel tracks how users move through steps.

Example:
1. Visit website
2. Sign up
3. Add to cart
4. Make purchase

We measure:
- How many users complete each step
- Conversion rate between steps
- Drop-off points

--------------------------------------------------

## Table Assumed

events(
    user_id,
    event_name,
    event_time
)

Example events:
'visit'
'signup'
'add_to_cart'
'purchase'

--------------------------------------------------

## Step 1 - Count Users Per Step

COUNT(DISTINCT user_id)
GROUP BY event_name

--------------------------------------------------

## Step 2 - Ordered Funnel Logic

We must ensure:
Step 2 happens AFTER Step 1.

This requires:
- MIN(event_time)
- Conditional aggregation
- OR self-join

--------------------------------------------------

## Step 3 - Conversion Rate

conversion % =
(step_users / first_step_users) * 100

--------------------------------------------------

## Why Funnel Analysis Matters

Used in:
- Growth teams
- Product managers
- Marketing analytics
- Business dashboards

--------------------------------------------------

## Key Learning

- DISTINCT counting
- Conditional aggregation
- MIN(event_time)
- Sequential logic
- Business conversion thinking