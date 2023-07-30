-- 182. Duplicate Emails

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | email       | varchar |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table contains an email. The emails will not contain uppercase letters.
 

-- Write an SQL query to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

-- Return the result table in any order.

SELECT DISTINCT p1.email
FROM Person p1
JOIN Person p2
  ON p1.email = p2.email
    AND p1.id != p2.id;
