-- 626. Exchange Seats

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table indicates the name and the ID of a student.
-- id is a continuous increment.
 

-- Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

-- Return the result table ordered by id in ascending order.

SELECT ROW_NUMBER() OVER (ORDER BY new_id ASC) AS id, student
FROM (
    SELECT
      CASE
        WHEN id % 2 = 0 THEN id-1
        WHEN id % 2 != 0 THEN id+1
      END AS new_id,
      student
    FROM Seat
) sq
