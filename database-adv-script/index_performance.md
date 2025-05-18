-- Indexes for User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);

-- Indexes for Property table
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(price_per_night);

-- Indexes for Booking table
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);

-- Composite indexes for frequently joined queries
CREATE INDEX idx_property_reviews ON Review(property_id, rating);
CREATE INDEX idx_user_bookings ON Booking(user_id, start_date);
CREATE INDEX idx_property_bookings ON Booking(property_id, status, start_date);
