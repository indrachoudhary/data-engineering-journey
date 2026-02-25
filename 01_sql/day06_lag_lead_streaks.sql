/*
========================================
Day 06 - LAG, LEAD, Deduplication, Streaks
========================================
*/

-- =====================================
-- 1. LAG() - Previous Row Value
-- =====================================

SELECT
    user_id,
    login_date,
    LAG(login_date) OVER (
        PARTITION BY user_id
        ORDER BY login_date
    ) AS previous_login
FROM user_logins;


-- =====================================
-- 2. Days Between Logins
-- =====================================

SELECT
    user_id,
    login_date,
    login_date -
    LAG(login_date) OVER (
        PARTITION BY user_id
        ORDER BY login_date
    ) AS days_between_logins
FROM user_logins;


-- =====================================
-- 3. LEAD() - Next Row Value
-- =====================================

SELECT
    user_id,
    login_date,
    LEAD(login_date) OVER (
        PARTITION BY user_id
        ORDER BY login_date
    ) AS next_login
FROM user_logins;


-- =====================================
-- 4. Look 3 Rows Ahead
-- =====================================

SELECT
    user_id,
    login_date,
    LEAD(login_date, 3) OVER (
        PARTITION BY user_id
        ORDER BY login_date
    ) AS login_3_rows_ahead
FROM user_logins;


-- =====================================
-- 5. Detect First Login Per User
-- =====================================

SELECT
    user_id,
    login_date,
    CASE
        WHEN LAG(login_date) OVER (
                PARTITION BY user_id
                ORDER BY login_date
             ) IS NULL
        THEN 'First Login'
        ELSE 'Returning User'
    END AS login_type
FROM user_logins;


-- =====================================
-- 6. Deduplication (Keep Latest Record)
-- =====================================

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


-- =====================================
-- 7. Detect Status Change
-- =====================================

SELECT *
FROM (
    SELECT
        user_id,
        status,
        LAG(status) OVER (
            PARTITION BY user_id
            ORDER BY updated_at
        ) AS previous_status
    FROM user_status
) t
WHERE status <> previous_status;


-- =====================================
-- 8. Streak Detection (Consecutive Logins)
-- =====================================

SELECT
    user_id,
    MIN(login_date) AS streak_start,
    MAX(login_date) AS streak_end,
    COUNT(*) AS streak_length
FROM (
    SELECT
        user_id,
        login_date,
        login_date -
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY login_date
        ) AS streak_group
    FROM user_logins
) t
GROUP BY user_id, streak_group
ORDER BY user_id, streak_start;


-- =====================================
-- 9. Longest Streak Per User
-- =====================================

SELECT user_id,
       MAX(streak_length) AS longest_streak
FROM (
    SELECT
        user_id,
        COUNT(*) AS streak_length
    FROM (
        SELECT
            user_id,
            login_date,
            login_date -
            ROW_NUMBER() OVER (
                PARTITION BY user_id
                ORDER BY login_date
            ) AS streak_group
        FROM user_logins
    ) t
    GROUP BY user_id, streak_group
) s
GROUP BY user_id;