-- 180. Consecutive Numbers

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- In SQL, id is the primary key for this table.
-- id is an autoincrement column.
 

-- Find all numbers that appear at least three times consecutively.

-- Return the result table in any order.

WITH cte1 AS (
SELECT id, num,
        LAG(num) OVER (ORDER BY id) AS num_lag_1
FROM Logs),

cte2 AS (
SELECT *,
        LAG(num_lag_1)  OVER (ORDER BY id) AS num_lag_2
FROM cte1)

SELECT DISTINCT num AS ConsecutiveNums
FROM cte2
WHERE num = num_lag_1
    AND num_lag_1 = num_lag_2;
