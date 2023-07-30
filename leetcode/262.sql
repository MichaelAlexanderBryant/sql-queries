-- 262. Trips and Users

-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | id          | int      |
-- | client_id   | int      |
-- | driver_id   | int      |
-- | city_id     | int      |
-- | status      | enum     |
-- | request_at  | date     |     
-- +-------------+----------+
-- id is the primary key for this table.
-- The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
-- Status is an ENUM type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').
 

-- Table: Users

-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | users_id    | int      |
-- | banned      | enum     |
-- | role        | enum     |
-- +-------------+----------+
-- users_id is the primary key for this table.
-- The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
-- banned is an ENUM type of ('Yes', 'No').
 

-- The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

-- Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.

-- Return the result table in any order.

WITH unbanned_client AS (
SELECT t.id, t.client_id, t.driver_id, t.status, t.request_at
FROM Trips t
JOIN Users u
    ON t.client_id = u.users_id
WHERE u.banned = 'No'),

unbanned_drivers AS (
SELECT t.id, t.client_id, t.driver_id, t.status, t.request_at
FROM unbanned_client t
JOIN Users u
    ON t.driver_id = u.users_id
WHERE u.banned = 'No'),

case_when AS (
SELECT *,
    CASE
        WHEN status = 'cancelled_by_client' THEN 'cancelled'
        WHEN status = 'cancelled_by_driver' THEN 'cancelled'
        ELSE 'completed'
    END AS new_status
FROM unbanned_drivers
WHERE request_at >= '2013-10-01'
    AND request_at <= '2013-10-03'),

completed_cancelled AS (
SELECT request_at, new_status, COUNT(*) AS status_counts
FROM case_when
GROUP BY request_at, new_status),

totals AS (
SELECT DISTINCT request_at, SUM(status_counts) OVER(PARTITION BY request_at) AS total_requests
FROM completed_cancelled)

SELECT DISTINCT cc.request_at AS 'Day',
    CASE
        WHEN new_status='cancelled' THEN ROUND(cc.status_counts*1.0/t.total_requests,2)
        WHEN new_status='completed' THEN ROUND((t.total_requests-cc.status_counts)*1.0/t.total_requests,2)
        ELSE NULL
    END AS 'Cancellation Rate'
FROM completed_cancelled cc
JOIN totals t
    ON cc.request_at = t.request_at
