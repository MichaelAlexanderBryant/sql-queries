-- 570. Managers with at Least 5 Direct Reports

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | department  | varchar |
-- | managerId   | int     |
-- +-------------+---------+
-- In SQL, id is the primary key column for this table.
-- Each row of this table indicates the name of an employee, their department, and the id of their manager.
-- If managerId is null, then the employee does not have a manager.
-- No employee will be the manager of themself.
 

-- Find the managers with at least five direct reports.

-- Return the result table in any order.

SELECT m.name
FROM Employee m
JOIN Employee e
    ON m.id = e.managerId
GROUP BY m.name
HAVING COUNT(*) >= 5;
