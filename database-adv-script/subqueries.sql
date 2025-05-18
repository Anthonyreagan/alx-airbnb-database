-- Use the correct database
USE airbnb_db;

-- 1. Non-correlated subquery: Find all properties where the average rating is greater than 4.0.
--    The subquery calculates the average rating per property independently.
--    The outer query uses the result of the subquery to filter properties.
SELECT
    p.property_id,
    p.name,
    p.price_per_night
FROM
    Property AS p
WHERE
    p.property_id IN (
        SELECT
            r.property_id
        FROM
            Review AS r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );

-- 2. Correlated subquery: Find users who have made more than 3 bookings.
--    The subquery depends on the outer query's current row ('u').
--    For each user 'u', the subquery counts bookings where booking.user_id matches u.user_id.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    User AS u
WHERE
    (SELECT COUNT(*) FROM Booking AS b WHERE b.user_id = u.user_id) > 3;