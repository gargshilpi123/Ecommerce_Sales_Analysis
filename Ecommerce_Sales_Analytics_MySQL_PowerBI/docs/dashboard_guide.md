# Power BI Dashboard Build Guide

## Model
Use a simple star-like relational model with the three relationships described in README. Keep filter direction single (dimension to fact) where possible. For date analysis, create a calendar table:

```DAX
Date =
CALENDAR(MIN(Orders[order_date]), MAX(Orders[order_date]))
```
Add Year, Month Number and Month columns, then mark it as the Date table and relate Date[Date] to Orders[order_date]. Sort Month by Month Number.

## Page 1 — Executive Overview
- KPI cards: Revenue, Profit, Profit Margin %, Total Orders, Average Order Value
- Line chart: Revenue by Date[Month]
- Clustered bar chart: Revenue by Products[category]
- Donut chart: Orders by Orders[order_status]
- Slicers: Date, Customers[state], Products[category]

## Page 2 — Product Performance
- Bar chart: Top 10 products by Revenue
- Matrix: Category → Product, Revenue, Units Sold, Profit, Profit Margin %
- Column chart: Units Sold by Category
- Slicers: Category and Date

## Page 3 — Customer & Geography
- Bar chart: Revenue by State
- Bar chart: Top customers by Revenue
- Cards: Total Customers, Repeat Customers
- Table: Customer name, City, State, Revenue
- Slicer: State

## Page 4 — Orders & Payments
- Column chart: Orders by Month
- Donut chart: Orders by Payment Method
- Bar chart: Revenue by Payment Method
- Cards: Cancelled Orders, Returned Orders
- Table: Order ID, Date, Status, Payment Method

## Design tips
- Use a 16:9 canvas.
- Put the report title at the top and KPI cards directly below.
- Use a restrained 2–3 colour palette, consistent number formatting and readable labels.
- Add informative tooltips and descriptive visual titles.
- Test slicers and cross-filtering before publishing.
