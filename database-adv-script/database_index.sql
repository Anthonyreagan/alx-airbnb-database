-- Index creation statements
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_property_reviews ON Review(property_id, rating);

-- Performance measurement queries with EXPLAIN ANALYZE
-- Query 1: User booking history
EXPLAIN ANALYZE 
SELECT * FROM Booking 
WHERE user_id = 'user123' 
ORDER BY start_date DESC;

-- Query 2: Property availability check
EXPLAIN ANALYZE
SELECT p.* FROM Property p
WHERE p.location LIKE 'New York%'
AND p.price_per_night BETWEEN 50 AND 200
AND NOT EXISTS (
    SELECT 1 FROM Booking b 
    WHERE b.property_id = p.property_id
    AND b.status = 'confirmed'
    AND b.start_date <= '2023-12-31'
    AND b.end_date >= '2023-12-01'
);

-- Query 3: Top rated properties
EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) as avg_rating
FROM Property p
JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) > 4.0
ORDER BY avg_rating DESC
LIMIT 10;
