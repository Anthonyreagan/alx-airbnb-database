-- Initial unoptimized query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.start_date DESC
LIMIT 1000;

-- Optimized query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    (
        SELECT 
            payment_id, 
            booking_id, 
            amount, 
            payment_date, 
            payment_method
        FROM 
            Payment
        WHERE 
            payment_date > CURRENT_DATE - INTERVAL '1 year'
    ) pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date > CURRENT_DATE - INTERVAL '2 years'
ORDER BY 
    b.start_date DESC
LIMIT 1000;
