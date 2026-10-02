USE ecommerce_analytics;

-- 1. Overall sales, cost and profit (exclude cancelled/returned orders)
SELECT ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),2) AS revenue,
       ROUND(SUM(oi.quantity*oi.unit_cost),2) AS cost,
       ROUND(SUM(oi.quantity*(oi.unit_price*(1-oi.discount_pct)-oi.unit_cost)),2) AS profit
FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
WHERE o.order_status NOT IN ('Cancelled','Returned');

-- 2. Monthly revenue trend
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
       ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),2) AS revenue
FROM orders o JOIN order_items oi USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY month ORDER BY month;

-- 3. Revenue by product category
SELECT p.category, ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),2) revenue
FROM orders o JOIN order_items oi USING(order_id) JOIN products p USING(product_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY p.category ORDER BY revenue DESC;

-- 4. Top 10 products by revenue
SELECT p.product_name, SUM(oi.quantity) units_sold,
       ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),2) revenue
FROM orders o JOIN order_items oi USING(order_id) JOIN products p USING(product_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY p.product_id,p.product_name ORDER BY revenue DESC LIMIT 10;

-- 5. Sales by state
SELECT c.state, ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),2) revenue
FROM orders o JOIN customers c USING(customer_id) JOIN order_items oi USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY c.state ORDER BY revenue DESC;

-- 6. Customer lifetime value
SELECT c.customer_id,c.customer_name,
       ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),2) lifetime_revenue
FROM customers c JOIN orders o USING(customer_id) JOIN order_items oi USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY c.customer_id,c.customer_name ORDER BY lifetime_revenue DESC;

-- 7. Repeat customers
SELECT COUNT(*) AS repeat_customers FROM (
  SELECT o.customer_id FROM orders o
  WHERE o.order_status NOT IN ('Cancelled','Returned')
  GROUP BY o.customer_id HAVING COUNT(DISTINCT o.order_id)>1
) x;

-- 8. Average order value
SELECT ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct))/COUNT(DISTINCT o.order_id),2) AS avg_order_value
FROM orders o JOIN order_items oi USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned');

-- 9. Payment method mix
SELECT payment_method, COUNT(*) orders_count
FROM orders GROUP BY payment_method ORDER BY orders_count DESC;

-- 10. Order status distribution
SELECT order_status, COUNT(*) order_count FROM orders GROUP BY order_status;

-- 11. Monthly profit
SELECT DATE_FORMAT(o.order_date,'%Y-%m') month,
 ROUND(SUM(oi.quantity*(oi.unit_price*(1-oi.discount_pct)-oi.unit_cost)),2) profit
FROM orders o JOIN order_items oi USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY month ORDER BY month;

-- 12. Discount impact by discount band
SELECT CASE WHEN discount_pct=0 THEN 'No discount'
            WHEN discount_pct<=0.10 THEN 'Up to 10%'
            ELSE 'Above 10%' END discount_band,
       ROUND(SUM(quantity*unit_price*(1-discount_pct)),2) revenue,
       SUM(quantity) units
FROM order_items oi JOIN orders o USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY discount_band;

-- 13. Best selling category by units
SELECT p.category,SUM(oi.quantity) units_sold
FROM order_items oi JOIN products p USING(product_id)
JOIN orders o USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY p.category ORDER BY units_sold DESC;

-- 14. New customers by month
SELECT DATE_FORMAT(signup_date,'%Y-%m') month,COUNT(*) new_customers
FROM customers GROUP BY month ORDER BY month;

-- 15. Cancellation and return rate
SELECT order_status, ROUND(100*COUNT(*)/(SELECT COUNT(*) FROM orders),2) pct_of_orders
FROM orders GROUP BY order_status;

-- 16. Revenue by payment method
SELECT o.payment_method,ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),2) revenue
FROM orders o JOIN order_items oi USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY o.payment_method ORDER BY revenue DESC;

-- 17. Orders per customer segment
SELECT CASE WHEN order_count=1 THEN 'One-time'
            WHEN order_count BETWEEN 2 AND 4 THEN 'Repeat'
            ELSE 'Loyal (5+)' END customer_segment, COUNT(*) customers
FROM (SELECT customer_id,COUNT(*) order_count FROM orders
      WHERE order_status NOT IN ('Cancelled','Returned') GROUP BY customer_id) t
GROUP BY customer_segment;

-- 18. Product-level profit margin
SELECT p.product_name,
 ROUND(SUM(oi.quantity*(oi.unit_price*(1-oi.discount_pct)-oi.unit_cost)),2) profit,
 ROUND(100*SUM(oi.quantity*(oi.unit_price*(1-oi.discount_pct)-oi.unit_cost))/
 NULLIF(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),0),2) margin_pct
FROM order_items oi JOIN products p USING(product_id) JOIN orders o USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY p.product_id,p.product_name ORDER BY profit DESC;

-- 19. Weekday performance
SELECT DAYNAME(o.order_date) weekday,
 ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct)),2) revenue
FROM orders o JOIN order_items oi USING(order_id)
WHERE o.order_status NOT IN ('Cancelled','Returned')
GROUP BY DAYOFWEEK(o.order_date),weekday ORDER BY DAYOFWEEK(o.order_date);

-- 20. Monthly order count
SELECT DATE_FORMAT(order_date,'%Y-%m') month,COUNT(*) orders
FROM orders WHERE order_status NOT IN ('Cancelled','Returned')
GROUP BY month ORDER BY month;
