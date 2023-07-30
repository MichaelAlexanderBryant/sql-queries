-- 1158. Market Analysis I

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | user_id        | int     |
-- | join_date      | date    |
-- | favorite_brand | varchar |
-- +----------------+---------+
-- user_id is the primary key of this table.
-- This table has the info of the users of an online shopping website where users can sell and buy items.
 

-- Table: Orders

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | order_id      | int     |
-- | order_date    | date    |
-- | item_id       | int     |
-- | buyer_id      | int     |
-- | seller_id     | int     |
-- +---------------+---------+
-- order_id is the primary key of this table.
-- item_id is a foreign key to the Items table.
-- buyer_id and seller_id are foreign keys to the Users table.
 

-- Table: Items

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | item_id       | int     |
-- | item_brand    | varchar |
-- +---------------+---------+
-- item_id is the primary key of this table.
 

-- Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.

-- Return the result table in any order.

WITH nonzero_orders AS (
SELECT o.buyer_id, u.join_date, COUNT(*) AS orders_in_2019
FROM Users AS u
LEFT JOIN Orders AS o
    ON u.user_id = o.buyer_id
WHERE o.order_date >= '2019-01-01'
    AND o.order_date <= '2019-12-31'
GROUP BY o.buyer_id, u.join_date)

SELECT user_id AS buyer_id, join_date,
    CASE WHEN 1=1 THEN 0 END AS orders_in_2019
FROM Users
WHERE user_id NOT IN (
    SELECT o.buyer_id
    FROM Users AS u
    LEFT JOIN Orders AS o
        ON u.user_id = o.buyer_id
    WHERE o.order_date >= '2019-01-01'
        AND o.order_date <= '2019-12-31'
    GROUP BY o.buyer_id, u.join_date
)
UNION
SELECT *
FROM nonzero_orders;
