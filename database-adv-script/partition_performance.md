# Booking Table Partitioning Performance Report

## Implementation Overview
- Partitioned the Booking table by year using `start_date`
- Created 5 partitions (2020-2023 + future bookings)
- Maintained all existing constraints and indexes
- Migrated data from original table

## Performance Tests

### Test 1: Date Range Query
**Query**: Fetch all confirmed bookings in 2023

**Before Partitioning**:
QUERY PLAN
Seq Scan on booking (cost=0.00..12548.32 rows=324 width=72)
Filter: (status = 'confirmed' AND
start_date >= '2023-01-01' AND
start_date <= '2023-12-31')
Planning Time: 0.752 ms
Execution Time: 245.912 ms
Rows Returned: 8,742


**After Partitioning**:
QUERY PLAN
Append (cost=0.00..324.32 rows=8421 width=72)
-> Seq Scan on p2023 booking_partitioned (cost=0.00..324.32 rows=8421 width=72)
Filter: (status = 'confirmed' AND
start_date >= '2023-01-01' AND
start_date <= '2023-12-31')
Planning Time: 0.191 ms
Execution Time: 32.754 ms
Rows Returned: 8,742

