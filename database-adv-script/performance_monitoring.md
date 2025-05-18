# Database Performance Monitoring and Refinement

## Monitoring Methodology
Used a combination of `EXPLAIN ANALYZE`, `SHOW PROFILE`, and slow query logs to identify performance bottlenecks in the AirBnB database.

---

## Query 1: Property Search with Reviews
**Description**: Find available properties in a location with high ratings

### Initial Analysis
```sql
EXPLAIN ANALYZE
SELECT p.property_id, p.name, p.location, p.price_per_night, AVG(r.rating) as avg_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
WHERE p.location LIKE '%Paris%'
AND p.price_per_night BETWEEN 50 AND 200
GROUP BY p.property_id
HAVING AVG(r.rating) > 4.0
ORDER BY avg_rating DESC;
