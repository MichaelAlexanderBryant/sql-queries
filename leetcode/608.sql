-- 608. Tree Node

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | p_id        | int  |
-- +-------------+------+
-- id is the primary key column for this table.
-- Each row of this table contains information about the id of a node and the id of its parent node in a tree.
-- The given structure is always a valid tree.
 

-- Each node in the tree can be one of three types:

-- "Leaf": if the node is a leaf node.
-- "Root": if the node is the root of the tree.
-- "Inner": If the node is neither a leaf node nor a root node.
-- Write an SQL query to report the type of each node in the tree.

-- Return the result table in any order.

WITH leaf_cte AS (
SELECT id,
  CASE
    WHEN 1=1 THEN 'Leaf'
  END AS type
FROM Tree
WHERE id NOT IN (
  SELECT p_id
  FROM Tree
  WHERE p_id IS NOT NULL)
  AND p_id IS NOT NULL),

root_cte AS (
SELECT id,
  CASE
    WHEN 1=1 THEN 'Root'
  END AS type
FROM Tree
WHERE p_id IS NULL
),

inner_cte AS (
SELECT DISTINCT p_id AS id,
  CASE
    WHEN 1=1 THEN 'Inner'
  END AS type
FROM Tree
WHERE p_id IN (
  SELECT p_id
  FROM Tree
  WHERE p_id IS NOT NULL
) AND p_id NOT IN (
  SELECT id
  FROM Tree
  WHERE p_id IS NULL)
)

SELECT *
FROM root_cte
UNION
SELECT *
FROM inner_cte
UNION
SELECT *
FROM leaf_cte;
