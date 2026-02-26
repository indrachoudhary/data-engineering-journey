/*
========================================
Day 10 - Funnel Analysis
========================================
*/

-- =====================================
-- 1. Basic Step Counts
-- =====================================

SELECT
    event_name,
    COUNT(DISTINCT user_id) AS users
FROM events
GROUP BY event_name
ORDER BY users DESC;


-- =====================================
-- 2. Proper Sequential Funnel
-- =====================================

WITH user_steps AS (
    SELECT
        user_id,
        MIN(CASE WHEN event_name = 'visit' THEN event_time END) AS visit_time,
        MIN(CASE WHEN event_name = 'signup' THEN event_time END) AS signup_time,
        MIN(CASE WHEN event_name = 'add_to_cart' THEN event_time END) AS cart_time,
        MIN(CASE WHEN event_name = 'purchase' THEN event_time END) AS purchase_time
    FROM events
    GROUP BY user_id
)

SELECT
    COUNT(*) AS total_users,
    COUNT(signup_time) AS signed_up,
    COUNT(cart_time) AS added_to_cart,
    COUNT(purchase_time) AS purchased
FROM user_steps
WHERE signup_time > visit_time
   OR signup_time IS NULL;


-- =====================================
-- 3. Conversion Rates
-- =====================================

WITH user_steps AS (
    SELECT
        user_id,
        MIN(CASE WHEN event_name = 'visit' THEN event_time END) AS visit_time,
        MIN(CASE WHEN event_name = 'signup' THEN event_time END) AS signup_time,
        MIN(CASE WHEN event_name = 'add_to_cart' THEN event_time END) AS cart_time,
        MIN(CASE WHEN event_name = 'purchase' THEN event_time END) AS purchase_time
    FROM events
    GROUP BY user_id
),
funnel_counts AS (
    SELECT
        COUNT(*) AS total_users,
        COUNT(signup_time) AS signed_up,
        COUNT(cart_time) AS added_to_cart,
        COUNT(purchase_time) AS purchased
    FROM user_steps
)
SELECT
    total_users,
    signed_up,
    ROUND(signed_up * 100.0 / total_users, 2) AS signup_conversion,
    added_to_cart,
    ROUND(added_to_cart * 100.0 / total_users, 2) AS cart_conversion,
    purchased,
    ROUND(purchased * 100.0 / total_users, 2) AS purchase_conversion
FROM funnel_counts;