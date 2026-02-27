DAY 13 – INDEXES & QUERY OPTIMIZATION (POSTGRESQL)
🔹 1. What Is an Index?

Separate data structure (B-Tree by default)

Speeds up reads

Slows down writes

Used in WHERE, JOIN, ORDER BY, GROUP BY

🔹 2. Types of Scans in EXPLAIN

Seq Scan → Full table scan

Index Scan → Uses index + table lookup

Bitmap Index Scan → Many matches

Index Only Scan → Reads only index

🔹 3. When to Add Index

✔ High selectivity (small % rows returned)
✔ Equality filters
✔ Frequent joins
✔ Sorting

🔹 4. When NOT to Add Index

❌ Small tables
❌ Low selectivity (70%+ rows match)
❌ Too many indexes (slow inserts)

🔹 5. Composite Index Rule

Order matters.

Put columns in this order:

Equality filters

Range filters

ORDER BY columns

Example:

(user_id, transaction_date)

Works for:

WHERE user_id = ?

WHERE user_id = ? AND transaction_date >= ?

Does NOT work for:

WHERE transaction_date >= ?

🔹 6. Partial Index (Very Powerful)
CREATE INDEX idx_failed_status
ON transactions(status)
WHERE status = 'failed';

Smaller.
Faster.
Production-grade optimization.

🔹 7. Index Only Scan Requirements

All required columns must be in index

Table must be vacuumed

VACUUM ANALYZE transactions;