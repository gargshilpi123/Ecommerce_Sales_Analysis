# Data Dictionary

| File/Table | Grain | Key fields |
|---|---|---|
| customers | One row per customer | customer_id (PK), city, state, signup_date |
| products | One row per product | product_id (PK), category, unit_price, unit_cost |
| orders | One row per order | order_id (PK), customer_id (FK), order_date, order_status, payment_method |
| order_items | One row per product line in an order | order_item_id (PK), order_id (FK), product_id (FK), quantity, unit_price, unit_cost, discount_pct |

**Revenue** = quantity × unit_price × (1 − discount_pct).  
**Cost** = quantity × unit_cost.  
**Profit** = revenue − cost.  
Cancelled and returned orders are excluded from the main revenue/profit measures; status analysis includes all orders.
