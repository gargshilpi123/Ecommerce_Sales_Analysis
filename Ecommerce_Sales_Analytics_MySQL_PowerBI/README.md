# E-Commerce Sales Analytics | MySQL + Power BI

A portfolio-ready end-to-end data analytics project using a **synthetic Indian e-commerce dataset**. It demonstrates relational data modelling, SQL analysis, KPI development and Power BI dashboard design.

## Project contents
- `data/`: four CSV files (customers, products, orders, order_items)
- `sql/01_schema.sql`: MySQL database and table creation
- `sql/02_analysis_queries.sql`: 20 business analysis queries
- `powerbi/measures.dax`: core Power BI measures
- `docs/dashboard_guide.md`: data model, dashboard pages and visual setup

## Dataset overview
- 250 customers
- 25 products across 5 categories
- 1,200 orders
- Order line-item level data
- Dates span 2024–2025
- Synthetic data only; no real customer information

## Step 1 — Set up MySQL
1. Install MySQL Server and MySQL Workbench.
2. Open Workbench and connect to your local server.
3. Open and execute `sql/01_schema.sql`.
4. Import each CSV using **Schemas → ecommerce_analytics → Tables → right-click table → Table Data Import Wizard**.
5. Import in this order: `customers.csv`, `products.csv`, `orders.csv`, `order_items.csv`.
6. Confirm row counts:
   ```sql
   USE ecommerce_analytics;
   SELECT COUNT(*) FROM customers;
   SELECT COUNT(*) FROM products;
   SELECT COUNT(*) FROM orders;
   SELECT COUNT(*) FROM order_items;
   ```
7. Run queries from `sql/02_analysis_queries.sql`.

## Step 2 — Connect Power BI
1. Open Power BI Desktop.
2. Select **Get Data → MySQL database**.
3. Enter Server `localhost` and Database `ecommerce_analytics`.
4. Choose Import (recommended for this practice project), authenticate, and load all four tables.
5. If prompted, install the MySQL Connector/NET driver required by your Power BI installation.
6. In Model view, create/check these one-to-many relationships:
   - Customers[customer_id] → Orders[customer_id]
   - Orders[order_id] → Order_Items[order_id]
   - Products[product_id] → Order_Items[product_id]
7. Create measures from `powerbi/measures.dax`. Set Revenue/Profit/Cost/AOV to currency and margin to percentage.

## Step 3 — Build the report
Follow `docs/dashboard_guide.md` for the report layout and visuals. Add slicers for date, category, state, and payment method. Use a consistent theme and meaningful titles.

## Business questions answered
- How are revenue and profit changing over time?
- Which categories and products contribute most to revenue?
- Which states generate the most sales?
- What is the average order value?
- How many customers place repeat orders?
- Which payment methods are used most?
- What share of orders are cancelled or returned?
- How do discounts relate to revenue and units sold?

## Resume description
**E-Commerce Sales Analysis | MySQL, Power BI, SQL, DAX**
- Built a relational sales analytics dataset with customer, product, order and order-item tables.
- Wrote SQL queries using joins, aggregations, subqueries and conditional logic to analyse sales, profitability, customer behaviour and order trends.
- Developed Power BI KPI measures in DAX and designed an interactive multi-page dashboard with time, product and regional analysis.
- Identified revenue trends, top-performing categories, repeat-customer behaviour and order-status patterns.

## Important
This is a learning/portfolio project built with generated synthetic data. Do not describe its findings as real company results. Add your own screenshots of the finished Power BI report to the `docs/` folder before publishing your portfolio.
