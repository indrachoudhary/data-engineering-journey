# Day 08 - Cohort Analysis (Retention)

## What is a Cohort?

A cohort = group of users who started in the same time period.

Example:
- Users who signed up in Jan 2024
- Users who made first purchase in March

Cohort analysis measures retention over time.

--------------------------------------------------

## Goal

For each signup month:
- How many users signed up?
- How many returned in month 1?
- Month 2?
- Month 3?

--------------------------------------------------

## Tables Assumed

users(user_id, signup_date)
logins(user_id, login_date)

--------------------------------------------------

## Step 1 - Find Cohort Month

DATE_TRUNC('month', signup_date)

Each user belongs to a cohort month.

--------------------------------------------------

## Step 2 - Find Activity Month

DATE_TRUNC('month', login_date)

--------------------------------------------------

## Step 3 - Calculate Month Difference

DATE_PART('month',
    AGE(activity_month, cohort_month)
)

Month difference meaning:

0 → signup month
1 → first month after signup
2 → second month after signup

--------------------------------------------------

## Step 4 - Aggregate

GROUP BY cohort_month, month_number

COUNT(DISTINCT user_id)

--------------------------------------------------

## Retention Percentage Formula

retention % =
(active_users / total_users_in_cohort) * 100

--------------------------------------------------

## Why Cohort Analysis Is Important

Used in:
- SaaS retention tracking
- Product analytics
- Subscription businesses
- Growth analysis

--------------------------------------------------

## Key Learning

- DATE_TRUNC for grouping by month
- AGE + DATE_PART for month difference
- JOIN users with activity table
- DISTINCT user counting
- Business-focused SQL thinking