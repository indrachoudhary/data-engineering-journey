# Day 02 - SQL JOINs

## INNER JOIN
Returns only rows that exist in both tables.

## LEFT JOIN
Returns all rows from the left table.
If no match in the right table, values are NULL.

## NULL Behavior
- SUM() returns NULL if no non-null values exist.
- COUNT(column) ignores NULL values.
- COUNT(*) counts rows.

## COALESCE
Used to replace NULL values with a default value.

Example:
COALESCE(SUM(amount), 0)

## Key Learning
Understanding NULL behavior is critical in production data systems.
