# AirBnB Database ER Diagram

## Objective
Create an Entity-Relationship (ER) diagram based on the provided database specification.

## Entities and Attributes
- **User**: `user_id` (PK), `first_name`, `last_name`, `email` (UNIQUE), `password_hash`, `phone_number`, `role`, `created_at`
- **Property**: `property_id` (PK), `host_id` (FK), `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`
- **Booking**: `booking_id` (PK), `property_id` (FK), `user_id` (FK), `start_date`, `end_date`, `total_price`, `status`, `created_at`
- **Payment**: `payment_id` (PK), `booking_id` (FK), `amount`, `payment_date`, `payment_method`
- **Review**: `review_id` (PK), `property_id` (FK), `user_id` (FK), `rating`, `comment`, `created_at`
- **Message**: `message_id` (PK), `sender_id` (FK), `recipient_id` (FK), `message_body`, `sent_at`

## Relationships
- **User to Property**: One-to-Many (Hosts)
- **User to Booking**: One-to-Many (Books)
- **Property to Booking**: One-to-Many (Booked)
- **Booking to Payment**: One-to-Many (Paid)
- **User to Review**: One-to-Many (Writes)
- **Property to Review**: One-to-Many (Reviewed)
- **User to Message**: One-to-Many (Sends, Receives)

## ER Diagram
- Created using Draw.io in Crow’s Foot notation.
- Saved as `ERD/airbnb.drawio.png`.
- Exported as `ERD/airbnb.drawio.png` for reference.

## Instructions
1. Open `airbnb.drawio.png` in Draw.io to view/edit the diagram.
2. Refer to `airbnb.drawio.png` for a static view of the ER diagram.
