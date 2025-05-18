-- Use the correct database
USE airbnb_db;

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings.
--    An INNER JOIN returns only the rows where the join condition is met in both tables.
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    Booking AS b -- Alias Booking table as 'b' for brevity
INNER JOIN
    User AS u ON b.user_id = u.user_id; -- Join on the user_id column

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews.
--    A LEFT JOIN returns all rows from the left table (Property) and the matched rows from the right table (Review).
--    If there is no match, columns from the right table will be NULL.
SELECT
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM
    Property AS p -- Alias Property table as 'p' (Left table)
LEFT JOIN
    Review AS r ON p.property_id = r.property_id; -- Join on the property_id column

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
--    MySQL does not directly support FULL OUTER JOIN. This query simulates it using a LEFT JOIN UNIONed with a RIGHT JOIN.
--    The LEFT JOIN gets all users and their bookings (bookings will be NULL if no match).
--    The RIGHT JOIN gets all bookings and their users (users will be NULL if no match).
--    UNION combines the results and removes duplicates.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date
FROM
    User AS u -- Alias User table as 'u'
LEFT JOIN
    Booking AS b ON u.user_id = b.user_id -- Get all users and their bookings
UNION
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date
FROM
    User AS u
RIGHT JOIN
    Booking AS b ON u.user_id = b.user_id -- Get all bookings and their users (including those without a matching user_id, though FK should prevent this)
WHERE u.user_id IS NULL; -- Filter out rows already included in the LEFT JOIN (where user_id is not NULL)
