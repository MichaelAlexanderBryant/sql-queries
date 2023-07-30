-- 602. Friend Requests II: Who Has the Most Friends

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | requester_id   | int     |
-- | accepter_id    | int     |
-- | accept_date    | date    |
-- +----------------+---------+
-- (requester_id, accepter_id) is the primary key for this table.
-- This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

-- Write an SQL query to find the people who have the most friends and the most friends number.

-- The test cases are generated so that only one person has the most friends.

WITH friend_count AS (
SELECT id, SUM(num) AS num
FROM (
    SELECT accepter_id AS id, COUNT(accepter_id) AS num
    FROM RequestAccepted
    GROUP BY accepter_id
    UNION ALL
    SELECT requester_id AS id, COUNT(requester_id) AS num
    FROM RequestAccepted
    GROUP BY requester_id
) sq
GROUP BY id)

SELECT TOP 1
    id, num
FROM friend_count
ORDER BY num DESC;
