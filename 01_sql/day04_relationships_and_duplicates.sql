-- =====================================================
-- Day 04 - Relationships, Duplicates & Subqueries
-- Author: Indra Choudhary
-- Description: Many-to-Many joins, duplicate explosion,
--              DISTINCT vs GROUP BY, Subqueries vs JOIN
-- =====================================================


-- Sample Tables:
-- students(student_id, name)
-- courses(course_id, course_name)
-- enrollments(student_id, course_id)



-- =====================================================
-- 1️⃣ Many-to-Many Relationship
-- =====================================================
-- students <-> enrollments <-> courses

SELECT s.student_id,
       s.name,
       c.course_name
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN courses c
    ON e.course_id = c.course_id;



-- =====================================================
-- 2️⃣ Duplicate Explosion Problem
-- =====================================================
-- If we join students directly to courses incorrectly

SELECT *
FROM students s
JOIN courses c
ON s.student_id = c.course_id;

-- This creates meaningless matches
-- and can explode row counts incorrectly



-- =====================================================
-- 3️⃣ Counting with Many-to-Many
-- =====================================================

-- Count courses per student

SELECT s.student_id,
       s.name,
       COUNT(e.course_id) AS total_courses
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
GROUP BY s.student_id, s.name;



-- =====================================================
-- 4️⃣ DISTINCT vs GROUP BY
-- =====================================================

-- DISTINCT removes duplicate rows
SELECT DISTINCT student_id
FROM enrollments;


-- GROUP BY groups rows for aggregation
SELECT student_id,
       COUNT(course_id) AS course_count
FROM enrollments
GROUP BY student_id;



-- Key Difference:
-- DISTINCT → removes duplicates
-- GROUP BY → aggregates data



-- =====================================================
-- 5️⃣ Subquery vs JOIN
-- =====================================================

-- Subquery: Get students who enrolled in course_id = 1

SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = 1
);


-- Same logic using JOIN

SELECT DISTINCT s.name
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
WHERE e.course_id = 1;



-- =====================================================
-- 6️⃣ Debugging Duplicate Rows
-- =====================================================

-- Step 1: Check row count before join
SELECT COUNT(*) FROM students;

-- Step 2: Check row count after join
SELECT COUNT(*)
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id;

-- If row count increases unexpectedly,
-- check relationship type (1-to-many or many-to-many)



-- =====================================================
-- KEY LEARNINGS
-- =====================================================

-- Many-to-many joins increase row count.
-- Duplicate explosion happens when join logic is wrong.
-- DISTINCT is not a fix for bad joins.
-- GROUP BY is for aggregation.
-- Always validate row counts before and after joins.
