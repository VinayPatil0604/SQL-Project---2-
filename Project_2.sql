-- SQL Project on :
-- E-Commerce Analytics: Deciphering Customer Behavior & Profitability (Analytical/Business focus)
DROP TABLE IF EXISTS ecommerce_sales_1;
CREATE TABLE ecommerce_sales_1 (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    discount DECIMAL(4, 2),
    quantity INT,
    payment_method VARCHAR(20),
    order_date DATE, -- Imported as text due to DD-MM-YYYY format
    delivery_time_days INT,
    region VARCHAR(10),
    returned VARCHAR(3),
    total_amount DECIMAL(10, 2),
    shipping_cost DECIMAL(10, 2),
    profit_margin DECIMAL(10, 2),
    customer_age INT,
    customer_gender VARCHAR(10)
);



DROP TABLE IF EXISTS ecommerce_Sales_2;
CREATE TABLE ecommerce_sales_2 (
    order_date DATE, -- Formatted as DD-MM-YYYY in the CSV
    product_name VARCHAR(100),
    category VARCHAR(50),
    region VARCHAR(20),
    quantity INT,
    sales DECIMAL(12, 2),
    profit DECIMAL(12, 2)
);

SELECT * FROM ecommerce_sales_1;
SELECT * FROM ecommerce_sales_2;

-- Q1: Total Record Count – How many total transactions are in this dataset?
SELECT COUNT(*) AS Total_transaction 
FROM ecommerce_sales_1;

-- Q2: Unique Customer Footprint – How many unique customers made a purchase?
SELECT COUNT(DISTINCT customer_id) AS No_Customers_Purchase
FROM ecommerce_sales_1;

-- Q3: Product Range – Count the number of unique products sold across different categories.

SELECT category, COUNT(DISTINCT product_id) AS Uique_prod_Sold
FROM ecommerce_sales_1
GROUP BY Category;

-- Q4: Category List – Distinct categories available in the store.
SELECT DISTINCT Category 
FROM ecommerce_sales_1;

-- Q5: Payment Method Popularity – Find all unique payment methods used by customers.
SELECT DISTINCT Payment_method
FROM ecommerce_Sales_1;

-- Q6: Age Demographics – What is the minimum, maximum, and average age of customers in this dataset?
SELECT MIN(customer_age) AS minimum_age,
       MAX(customer_age) AS Maximum_age,
	   ROUND(AVG(customer_age),1) as Average_age
FROM ecommerce_sales_1;
	   
-- Q7: Total Revenue & Profit – Calculate the total gross revenue (total_amount) and total net profit across the platform.
SELECT SUM(Total_Amount) AS revenue, SUM(Profit_margin) AS Profit
FROM ecommerce_sales_1;


-- Q8: Top Performing Categories – Rank product categories by total quantity sold.
SELECT Category, SUM(quantity) AS total_quantity,
    DENSE_RANK() OVER (ORDER BY SUM(quantity) DESC) AS Top_Performing_Category
FROM ecommerce_sales_1
GROUP BY Category;

-- Q9: Regional Sales Breakdown – Which geographic region generated the highest total sales volume?
SELECT REGION, ROUND(SUM(total_amount),2) AS total_sales_volume,
	   RANK() OVER (ORDER BY SUM(total_amount) DESC) AS Highest_total_sales_volume
FROM ecommerce_sales_1
GROUP BY Region;

-- Q10: Average Shipping Performance – Find the average delivery time (in days) grouped by region.
SELECT Region, ROUND(AVG(delivery_time_days),2) AS Average_delivery_time
FROM ecommerce_sales_1
GROUP BY Region;

-- Q11: The Discount Impact – What is the average discount given per product category?
SELECT Category, ROUND(AVG(Discount),3) AS Average_Discount_per_Category
FROM ecommerce_sales_1
GROUP BY Category;

-- Q12: Return Rate Analysis – Calculate the percentage of orders that were returned vs. kept.
SELECT 
    ROUND(SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS return_rate_percentage,
    ROUND(SUM(CASE WHEN returned = 'No' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS kept_rate_percentage
FROM ecommerce_sales_1;


-- Q13: Gender-Based Purchasing Habits – Compare the total amount spent and average order value (AOV) between Male, Female, and Other demographics.
SELECT customer_Gender,
    SUM(total_amount) AS total_spent,
    AVG(total_amount) AS average_order_value
FROM ecommerce_sales_1
GROUP BY customer_Gender;

-- Q14: High-Value Transactions – Extract all individual orders where the total amount exceeded $200, ordered from highest to lowest.

SELECT 
    order_id, 
    total_amount  AS High_transaction
FROM ecommerce_sales_1
WHERE total_amount > 200
ORDER BY total_amount DESC;

-- Q15: Cross-Dataset Profitability Check - Compare total profit from ecommerce_sales_2 with total profit margin from ecommerce_sales_1 using a UNION.
SELECT 'ecommerce_sales_1' AS SOURCE, SUM(Profit_margin) AS Total_profit_margin
FROM ecommerce_sales_1
UNION 
SELECT 'ecommerce_Sales_2' AS SOURCE, SUM(Profit) AS total_profit
FROM ecommerce_sales_2;

-- Q16: Monthly Sales Trend (Window Function) - Find monthly sales totals and show month-over-month growth using LAG().
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS monthly_sales,
    SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY DATE_TRUNC('month', order_date)) AS growth
FROM ecommerce_sales_1
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- Q17: Top 3 Products per Region (Ranking with PARTITION) - Identify the top 3 products by sales in each region.
SELECT region, product_id, total_sales, rank_in_region
FROM (SELECT region, product_id, SUM(total_amount) AS total_sales,
	  RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS rank_in_region
      FROM ecommerce_sales_1
      GROUP BY region, product_id
) ranked
WHERE rank_in_region <= 3
ORDER BY region, rank_in_region;

-- Q18: Customer Lifetime Value (CLV) - Calculate total spend per customer and rank them.
SELECT * from ecommerce_sales_1

SELECT customer_id, SUM(total_amount) AS lifetime_spend,
	 RANK() OVER(ORDER BY SUM(total_amount) DESC) AS Rank_ofCustomer
FROM ecommerce_Sales_1
GROUP BY customer_Id;

-- Q19: Join Analysis – Profitability by Category - Join both datasets to compare category-level profit.
SELECT e1.category, e1.order_date,
       SUM(e1.profit_margin) AS profit_dataset1,
       SUM(e2.profit) AS profit_dataset2
FROM ecommerce_sales_1 e1
JOIN ecommerce_sales_2 e2 
     ON e1.category = e2.category
	 AND e1.order_date = e2.order_date
GROUP BY e1.category, e1.order_date;

-- Q20: Rolling Cumulative Revenue – Calculate the daily running total of revenue over time.
SELECT  order_date, total_amount,
	   SUM(total_amount) OVER (ORDER BY total_amount DESC) AS Running_sum
FROM ecommerce_sales_1;

-- Q21: Customer RFM Segmentation (Monetary) – Classify customers into 'VIP' (spent > $500), 'Regular' (spent $100-$500), and 'Low Value' (spent < $100) using a CASE statement.
SELECT customer_id, SUM(total_amount) AS Spent,
    CASE  
        WHEN SUM(total_amount) > 500 THEN 'VIP'
        WHEN SUM(total_amount) BETWEEN 100 AND 500 THEN 'Regular'
        ELSE 'LOWER'
    END AS Customer_RFM
FROM ecommerce_sales_1
GROUP BY customer_id;

-- Q20: Repeat Buyer Identification – Write a subquery or CTE to find "loyal customers" who have placed more than 3 distinct orders.
SELECT customer_id, COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_sales_1
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 3;

-- Q21: Shipping Cost Leakage – Identify orders where the shipping cost ate up more than 15% of the total order value, flagging operational inefficiencies.
SELECT 
    order_id,
    customer_id,
    total_amount,
    shipping_cost,
    ROUND((shipping_cost / NULLIF(total_amount, 0)) * 100, 2) AS shipping_leak_percentage
FROM ecommerce_sales_1
WHERE (shipping_cost / NULLIF(total_amount, 0)) > 0.15
ORDER BY shipping_leak_percentage DESC;
