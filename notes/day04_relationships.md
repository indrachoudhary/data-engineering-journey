# Day 04 - Relationships & Duplicate Explosion

## Relationship Types
1. One-to-One
2. One-to-Many
3. Many-to-Many

Many-to-many relationships require a bridge table.

## Duplicate Explosion
Happens when:
- Join condition is wrong
- Many-to-many relationship multiplies rows
- Keys are not unique

Fix by:
- Understanding relationship
- Checking primary keys
- Validating row counts

## DISTINCT vs GROUP BY
DISTINCT → removes duplicate rows  
GROUP BY → used for aggregation  

DISTINCT is not a solution for incorrect joins.

## Subquery vs JOIN
Subqueries are readable for filtering.
JOINs are usually better for performance and flexibility.

## Debugging Strategy
1. Check row count before join
2. Check row count after join
3. Understand relationship type
4. Validate key uniqueness
