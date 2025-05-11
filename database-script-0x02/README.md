# AirBnB Database Seed Data

## Overview
This script populates the AirBnB database with realistic sample data including:
- 5 users (hosts, guests, admin)
- 2 properties
- 10 bookings
- 5 payments
- 5 reviews
- 8 messages

## Usage
1. First create the schema using `schema.sql`
2. Execute the seed script:
```bash
psql -U username -d dbname -f seed.sql
