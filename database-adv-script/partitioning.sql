-- Create partitioned table structure
CREATE TABLE booking_partitioned (
    booking_id VARCHAR(36) NOT NULL,
    property_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- Migrate data from original table
INSERT INTO booking_partitioned
SELECT * FROM Booking;

-- Create indexes on partitioned table
CREATE INDEX idx_part_booking_dates ON booking_partitioned(start_date, end_date);
CREATE INDEX idx_part_booking_user ON booking_partitioned(user_id);
CREATE INDEX idx_part_booking_property ON booking_partitioned(property_id);

-- Sample query to test partitioning
EXPLAIN ANALYZE
SELECT * FROM booking_partitioned
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31'
AND status = 'confirmed';
