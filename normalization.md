# Database Normalization Report (3NF)

## 1. Initial Assessment
Identified potential normalization issues:
- Composite attributes in `User` (address as single field)
- Redundant data in `Booking` (storing calculated `total_price`)
- Transitive dependency in `Property` (location → city/country)

## 2. Normalization Steps

### First Normal Form (1NF)
- Atomic values for all attributes
- Split `User.address` into:
  ```sql
  street_address VARCHAR
  city VARCHAR
  country VARCHAR
  postal_code VARCHAR
