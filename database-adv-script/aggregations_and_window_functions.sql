-- Use the correct database
USE airbnb_db;

-- 1. Find the total number of bookings made by each user, using COUNT and GROUP BY.
--    Aggregates booking data by user_id and counts the number of bookings per user.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    User AS u
LEFT JOIN -- Use LEFT JOIN to include users even if they have made 0 bookings
    Booking AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name -- Group by user details to get count per user
ORDER BY
    total_bookings DESC, u.last_name, u.first_name; -- Order to see users with most bookings first

-- 2. Use a window function (RANK) to rank properties based on the total number of bookings they have received.
--    First, calculate the total bookings per property using a subquery or CTE.
--    Then, apply the RANK() window function over this aggregated data.
WITH PropertyBookingCounts AS (
    -- This CTE calculates the total number of bookings for each property
    SELECT
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS num_bookings -- Count bookings for each property
    FROM
        Property AS p
    LEFT JOIN -- Use LEFT JOIN to include properties even with 0 bookings
        Booking AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id, p.name
)
SELECT
    property_id,
    property_name,
    num_bookings,
    RANK() OVER (ORDER BY num_bookings DESC) AS booking_rank -- Rank properties by booking count (highest count gets rank 1)
    -- ROW_NUMBER() could also be used, but RANK is better if properties can tie
FROM
    PropertyBookingCounts
ORDER BY
    booking_rank, property_name; -- Order the final result by rank
