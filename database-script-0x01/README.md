# AirBnB Clone Database Schema

## Schema Overview
This SQL script creates a normalized database schema for an AirBnB clone with:

- 6 main tables
- Proper constraints and relationships
- Optimized indexes

## Tables Structure
1. **users**: User accounts with roles
2. **properties**: Listing information
3. **bookings**: Reservation records
4. **payments**: Transaction details
5. **reviews**: Guest feedback
6. **messages**: User communications

## Key Features
- UUID primary keys
- Referential integrity with foreign keys
- Data validation constraints
- Automatic timestamps
- Performance-optimized indexes

## Installation
1. Execute the script in PostgreSQL:
```bash
psql -U username -d dbname -f schema.sql
