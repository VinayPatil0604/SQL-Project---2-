# SQL-Project---2-
Built a PostgreSQL analytics project on e-commerce data, using window functions, joins, and CASE logic to analyze sales trends, customer value, return rates, and shipping inefficiencies.
# E-Commerce Analytics (PostgreSQL)
Datasets: 34,500 order-level transactions (Sep 2023 to Sep 2025, 7,903 customers, 7 categories, 5 regions) plus a 3,500-row sales/profit dataset.
## Dataset
ecommerce_sales_34500.csv
ecommerce_sales_data.csv
## Key Insights   
1. Revenue and profit: about $5.87M total revenue and $970K profit, a 16.5% profit margin, with an average order value of $170.
2. Electronics drives the business: it brings in ~57% of revenue ($3.32M), well ahead of Home ($1.08M) and Sports ($0.63M).
3. Grocery loses money: it has a negative total profit (-$9.2K) despite ~6K units sold, so its pricing and shipping costs need review.
4. Discounts erode margin: average profit per order falls from about $30 at 0% discount to $19 at 30% discount.
5. Shipping cost leakage: ~38% of orders have shipping costs above 15% of order value, a major operational inefficiency.
6. Return rate: 5.5% overall. Fashion (8.3%) and Electronics (7.3%) return most; Grocery returns least (1.3%).
7. Regional performance: South leads in revenue ($1.30M) and Central is lowest ($0.94M). East has the slowest delivery (about 6 days vs about 4 in North and Central).
8. Customer value: the top 10% of customers generate ~36% of revenue, and 4,943 customers (about 63%) placed more than 3 orders.
9. Payments: cards dominate (credit 35%, debit 25%), followed by COD and UPI (about 12% each).
10. Customers: ages 18 to 69 (average 43), with spend split almost evenly between Female and Male customers.
11. Loss-making orders: about 17.7% of orders have negative profit.
12. Secondary dataset: the 3,500-row set shows a 17.3% margin and consistent margins across categories (Electronics, Accessories, Office). Camera and Monitor are the top products.
## SQL Techniques
## Files (SQL script, CSVs)
## How to run
