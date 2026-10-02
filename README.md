# 🛒 E-Commerce Analytics: Customer Behavior & Profitability (PostgreSQL)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-SQL-blue?logo=postgresql&logoColor=white)
![Focus](https://img.shields.io/badge/Focus-Business%20Analytics-green)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

An SQL-based analysis of e-commerce sales data to understand customer behavior, regional performance, returns, shipping efficiency, and profitability.

---

## 📌 Project Overview

This project answers real business questions using PostgreSQL on two e-commerce datasets. It covers 20+ queries, from basic exploration to advanced analytics with window functions, joins, subqueries, and customer segmentation.

**Business questions answered:**
- Which categories and regions drive revenue and profit?
- How do discounts affect profitability?
- Which customers are the most valuable, and who are the repeat buyers?
- Where is shipping cost eating into order value?
- What is the return rate, and which categories return the most?

---

## 🗂️ Datasets

| File | Rows | Description |
|------|------|-------------|
| `ecommerce_sales_34500.csv` | 34,500 | Order-level transactions (Sep 2023 to Sep 2025): 7,903 customers, 7 categories, 5 regions. Includes price, discount, quantity, payment method, delivery time, return status, total amount, shipping cost, profit margin, customer age and gender. |
| `ecommerce_sales_data.csv` | 3,500 | Product-level sales summary: order date, product name, category (Electronics, Accessories, Office), region, quantity, sales, profit. Used for cross-dataset profitability checks. |

> Dates are in `DD-MM-YYYY` format. Empty columns and an error cell (`#REF!`) in the second file were removed before import.

---

## 🔍 Key Insights

- 💰 **Revenue and profit:** about **$5.87M** revenue and **$970K** profit, a **16.5% margin**, with an average order value of **$170**.
- 📱 **Electronics dominates:** about **57% of total revenue** ($3.32M), followed by Home ($1.08M) and Sports ($0.63M).
- ⚠️ **Grocery is loss-making:** negative total profit (about **-$9.2K**) despite high unit sales.
- 🏷️ **Discounts erode margin:** average profit per order drops from about **$30 (0% discount) to $19 (30% discount)**.
- 🚚 **Shipping cost leakage:** about **38% of orders** have shipping above 15% of order value.
- 🔁 **Return rate:** **5.5%** overall. Fashion (8.3%) and Electronics (7.3%) are highest; Grocery (1.3%) is lowest.
- 🌍 **Regions:** South leads in revenue ($1.30M), Central is lowest ($0.94M), and East has the slowest delivery (about 6 days vs about 4 in North and Central).
- 👥 **Customer value:** the top 10% of customers generate about **36% of revenue**, and about **63%** of customers placed more than 3 orders.
- 💳 **Payments:** credit card (35%) and debit card (25%) dominate, followed by COD and UPI (about 12% each).
- 📉 **Loss-making orders:** about **17.7%** of orders have negative profit.

---

## 💡 Business Recommendations

1. **Review Grocery pricing and shipping**, since it is the only category with negative profit.
2. **Cap or target discounts**, because deeper discounts consistently reduce profit per order.
3. **Renegotiate shipping rates or set minimum order values** to reduce shipping cost leakage.
4. **Investigate high return rates in Fashion and Electronics** (quality, sizing, product descriptions).
5. **Improve East-region logistics** to cut delivery times.
6. **Run loyalty programs** for the top 10% of customers who drive over a third of revenue.

---

## 🧰 SQL Techniques Used

- `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`
- `JOIN` (inner and multi-table)
- Subqueries and CTEs
- Window functions: `RANK()`, `DENSE_RANK()`, `LAG()`, `SUM() OVER()`
- `CASE` statements for customer segmentation (VIP / Regular / Low Value)
- `UNION` for cross-dataset comparison
- `NULLIF` for safe division
- `DATE_TRUNC` for monthly trend analysis

---

## 📋 Query Highlights

| # | Analysis | Technique |
|---|----------|-----------|
| 8 | Rank categories by quantity sold | `DENSE_RANK()` |
| 12 | Return vs kept percentage | `CASE` + aggregation |
| 15 | Profit comparison across datasets | `UNION` |
| 16 | Month-over-month sales growth | `DATE_TRUNC` + `LAG()` |
| 17 | Top 3 products per region | `RANK() OVER (PARTITION BY ...)` |
| 18 | Customer lifetime value ranking | `RANK()` |
| 21 | Customer segmentation by spend | `CASE` |
| 22 | Loyal customers (more than 3 orders) | `HAVING` |
| 23 | Shipping cost leakage (over 15%) | `NULLIF` |

---

## 📁 Repository Structure

```
ecommerce-sql-analysis/
│
├── README.md
├── data/
│   ├── ecommerce_sales_34500.csv
│   └── ecommerce_sales_data.csv
├── sql/
│   └── ecommerce_analysis.sql
└── images/
    └── (optional: screenshots of query results)
```

---

## ▶️ How to Run

1. Install **PostgreSQL** and open **pgAdmin** or `psql`.
2. Create a database: `CREATE DATABASE ecommerce_analysis;`
3. Run the table creation statements in `sql/ecommerce_analysis.sql`.
4. Import both CSVs from the `data/` folder (adjust the file paths in the `COPY` command, or use the pgAdmin import tool).
5. Execute the analysis queries one by one.

---

## 🛠️ Tools

PostgreSQL · SQL · pgAdmin · Excel

---

## 👤 Author

**Vinay Sanjay Patil**
MSc Statistics | Data Analytics | SQL · Python · Excel · Power BI

📧 vinaysp9307@gmail.com
🔗 [LinkedIn](#) · [GitHub](#)

---

⭐ If you found this project useful, feel free to star the repository!
