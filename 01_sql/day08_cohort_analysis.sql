/*
========================================
Day 08 - Cohort Analysis
========================================
*/

-- =====================================
-- 1. Cohort + Activity Month
-- =====================================

SELECT
    u.user_id,
    DATE_TRUNC('month', u.signup_date) AS cohort_month,
    DATE_TRUNC('month', l.login_date) AS activity_month
FROM users u
JOIN logins l
    ON u.user_id = l.user_id;


-- =====================================
-- 2. Add Month Difference
-- =====================================

SELECT
    u.user_id,
    DATE_TRUNC('month', u.signup_date) AS cohort_month,
    DATE_TRUNC('month', l.login_date) AS activity_month,
    DATE_PART('month',
        AGE(
            DATE_TRUNC('month', l.login_date),
            DATE_TRUNC('month', u.signup_date)
        )
    ) AS month_number
FROM users u
JOIN logins l
    ON u.user_id = l.user_id;


-- =====================================
-- 3. Cohort Retention Table
-- =====================================

SELECT
    cohort_month,
    month_number,
    COUNT(DISTINCT user_id) AS active_users
FROM (
    SELECT
        u.user_id,
        DATE_TRUNC('month', u.signup_date) AS cohort_month,
        DATE_TRUNC('month', l.login_date) AS activity_month,
        DATE_PART('month',
            AGE(
                DATE_TRUNC('month', l.login_date),
                DATE_TRUNC('month', u.signup_date)
            )
        ) AS month_number
    FROM users u
    JOIN logins l
        ON u.user_id = l.user_id
) t
GROUP BY cohort_month, month_number
ORDER BY cohort_month, month_number;


-- =====================================
-- 4. Add Retention Percentage
-- =====================================

WITH cohort_data AS (
    SELECT
        u.user_id,
        DATE_TRUNC('month', u.signup_date) AS cohort_month,
        DATE_TRUNC('month', l.login_date) AS activity_month,
        DATE_PART('month',
            AGE(
                DATE_TRUNC('month', l.login_date),
                DATE_TRUNC('month', u.signup_date)
            )
        ) AS month_number
    FROM users u
    JOIN logins l
        ON u.user_id = l.user_id
),
cohort_size AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT user_id) AS total_users
    FROM cohort_data
    WHERE month_number = 0
    GROUP BY cohort_month
)
SELECT
    c.cohort_month,
    c.month_number,
    COUNT(DISTINCT c.user_id) AS active_users,
    ROUND(
        COUNT(DISTINCT c.user_id) * 100.0
        / s.total_users,
        2
    ) AS retention_percentage
FROM cohort_data c
JOIN cohort_size s
    ON c.cohort_month = s.cohort_month
GROUP BY c.cohort_month, c.month_number, s.total_users
ORDER BY c.cohort_month, c.month_number;