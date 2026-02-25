/*
========================================
Day 09 - Revenue Cohort Analysis
========================================
*/

-- =====================================
-- 1. Base Cohort Revenue Data
-- =====================================

SELECT
    u.user_id,
    DATE_TRUNC('month', u.signup_date) AS cohort_month,
    DATE_TRUNC('month', o.order_date) AS revenue_month,
    DATE_PART('month',
        AGE(
            DATE_TRUNC('month', o.order_date),
            DATE_TRUNC('month', u.signup_date)
        )
    ) AS month_number,
    o.amount
FROM users u
JOIN orders o
    ON u.user_id = o.user_id;


-- =====================================
-- 2. Revenue Per Cohort Per Month
-- =====================================

SELECT
    cohort_month,
    month_number,
    SUM(amount) AS total_revenue
FROM (
    SELECT
        u.user_id,
        DATE_TRUNC('month', u.signup_date) AS cohort_month,
        DATE_TRUNC('month', o.order_date) AS revenue_month,
        DATE_PART('month',
            AGE(
                DATE_TRUNC('month', o.order_date),
                DATE_TRUNC('month', u.signup_date)
            )
        ) AS month_number,
        o.amount
    FROM users u
    JOIN orders o
        ON u.user_id = o.user_id
) t
GROUP BY cohort_month, month_number
ORDER BY cohort_month, month_number;


-- =====================================
-- 3. Cumulative Revenue (LTV Curve)
-- =====================================

SELECT
    cohort_month,
    month_number,
    SUM(total_revenue) OVER (
        PARTITION BY cohort_month
        ORDER BY month_number
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM (
    SELECT
        cohort_month,
        month_number,
        SUM(amount) AS total_revenue
    FROM (
        SELECT
            u.user_id,
            DATE_TRUNC('month', u.signup_date) AS cohort_month,
            DATE_TRUNC('month', o.order_date) AS revenue_month,
            DATE_PART('month',
                AGE(
                    DATE_TRUNC('month', o.order_date),
                    DATE_TRUNC('month', u.signup_date)
                )
            ) AS month_number,
            o.amount
        FROM users u
        JOIN orders o
            ON u.user_id = o.user_id
    ) x
    GROUP BY cohort_month, month_number
) y
ORDER BY cohort_month, month_number;