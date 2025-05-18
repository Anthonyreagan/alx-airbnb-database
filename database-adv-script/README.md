# SQL Joins Queries Documentation

This repository contains complex SQL join queries for the AirBnB database schema.

## Queries Included

### 1. INNER JOIN Query
**Purpose**: Retrieve all bookings along with the user information of who made each booking.  
**Join Type**: INNER JOIN  
**Tables Involved**: `Booking`, `User`  
**Key Points**:
- Only returns bookings that have associated users
- Shows complete booking details with user information
- Ordered by booking date (newest first)

### 2. LEFT JOIN Query
**Purpose**: Retrieve all properties with their reviews, including properties that haven't received any reviews.  
**Join Type**: LEFT JOIN  
**Tables Involved**: `Property`, `Review`, `User`  
**Key Points**:
- Returns all properties regardless of having reviews
- Includes reviewer information for properties with reviews
- Ordered by property name and review date

### 3. FULL OUTER JOIN Simulation
**Purpose**: Retrieve all users and all bookings, showing unmatched records from both tables.  
**Join Type**: Simulated using LEFT JOIN + RIGHT JOIN + UNION  
**Tables Involved**: `User`, `Booking`  
**Key Points**:
- Shows users who haven't made any bookings
- Shows bookings not linked to valid users
- Combines results using UNION to simulate FULL OUTER JOIN
- Ordered by user_id and booking date

## How to Use
1. Execute these queries against your AirBnB database
2. Modify column selections as needed for your application
3. Adjust JOIN conditions if your schema differs

## Notes
- MySQL doesn't natively support FULL OUTER JOIN, so we simulate it
- These queries assume the database schema from `database_schema.sql`
- Indexes on join columns will significantly improve performance
