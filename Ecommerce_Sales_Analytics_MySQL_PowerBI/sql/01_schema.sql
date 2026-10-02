-- E-Commerce Sales Analytics | MySQL 8+
CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  city VARCHAR(60),
  state VARCHAR(60),
  signup_date DATE
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(120) NOT NULL,
  category VARCHAR(60),
  unit_price DECIMAL(10,2),
  unit_cost DECIMAL(10,2)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  order_status VARCHAR(30),
  payment_method VARCHAR(40),
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  discount_pct DECIMAL(5,2) DEFAULT 0,
  CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);


