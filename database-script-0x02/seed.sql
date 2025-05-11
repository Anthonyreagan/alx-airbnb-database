-- Seed users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (uuid_generate_v4(), 'John', 'Doe', 'john@example.com', '$2a$10$hash1', '+1234567890', 'host'),
    (uuid_generate_v4(), 'Jane', 'Smith', 'jane@example.com', '$2a$10$hash2', '+1987654321', 'guest'),
    (uuid_generate_v4(), 'Alice', 'Johnson', 'alice@example.com', '$2a$10$hash3', '+1122334455', 'admin'),
    (uuid_generate_v4(), 'Bob', 'Williams', 'bob@example.com', '$2a$10$hash4', '+1555666777', 'host'),
    (uuid_generate_v4(), 'Charlie', 'Brown', 'charlie@example.com', '$2a$10$hash5', '+1444333222', 'guest');

-- Seed properties
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
SELECT 
    uuid_generate_v4(),
    u.user_id,
    CASE 
        WHEN u.first_name = 'John' THEN 'Cozy Downtown Apartment'
        WHEN u.first_name = 'Bob' THEN 'Beachfront Villa'
    END,
    CASE
        WHEN u.first_name = 'John' THEN 'Modern 1BR in city center'
        WHEN u.first_name = 'Bob' THEN 'Luxury 3BR with ocean view'
    END,
    CASE
        WHEN u.first_name = 'John' THEN 'New York, NY'
        WHEN u.first_name = 'Bob' THEN 'Miami, FL'
    END,
    CASE
        WHEN u.first_name = 'John' THEN 120.00
        WHEN u.first_name = 'Bob' THEN 350.00
    END
FROM users u
WHERE u.role = 'host';

-- Seed bookings
WITH property_ids AS (
    SELECT property_id FROM properties
),
user_ids AS (
    SELECT user_id FROM users WHERE role = 'guest'
)
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT
    uuid_generate_v4(),
    p.property_id,
    u.user_id,
    CURRENT_DATE + (random() * 30)::integer,
    CURRENT_DATE + (random() * 30 + 5)::integer,
    (pr.price_per_night * (random() * 10 + 1)::integer),
    CASE WHEN random() > 0.3 THEN 'confirmed' ELSE 'pending' END
FROM 
    property_ids p
CROSS JOIN user_ids u
JOIN properties pr ON p.property_id = pr.property_id
LIMIT 10;

-- Seed payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
SELECT
    uuid_generate_v4(),
    b.booking_id,
    b.total_price,
    CASE 
        WHEN random() > 0.5 THEN 'credit_card' 
        ELSE 'paypal' 
    END
FROM bookings b
WHERE b.status = 'confirmed';

-- Seed reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
SELECT
    uuid_generate_v4(),
    b.property_id,
    b.user_id,
    (random() * 4 + 1)::integer,
    CASE 
        WHEN random() > 0.5 THEN 'Great experience!'
        ELSE 'Could be better'
    END
FROM bookings b
WHERE b.status = 'confirmed'
LIMIT 5;

-- Seed messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
SELECT
    uuid_generate_v4(),
    u1.user_id,
    u2.user_id,
    CASE 
        WHEN random() > 0.5 THEN 'Hi, is this property available?'
        ELSE 'I have a question about your listing'
    END
FROM users u1
CROSS JOIN users u2
WHERE u1.user_id <> u2.user_id
LIMIT 8;
