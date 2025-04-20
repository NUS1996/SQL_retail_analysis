# 🧾 Sales Data Analysis — SQL Project

Welcome to my Sales Data Analysis project!  
This project demonstrates how to create, clean, explore, and analyze a sales dataset using SQL.

---

## 📂 Project Overview

In this project, I designed and worked with a structured `sales` table that simulates transaction data for a retail business. The focus is on using SQL for:

- Data Cleaning 🧹  
- Data Exploration 🔍  
- Business Problem Solving 💡  

---

## 💾 Table Schema

```sql
CREATE TABLE sales (
    transactions_id INT NOT NULL,	
    sale_date DATE,	
    sale_time TIME,	
    customer_id INT,
    gender VARCHAR(10),	
    age INT,	
    category TEXT,	
    quantity INT,	
    price_per_unit FLOAT,	
    cogs FLOAT,	
    total_sale FLOAT,
    PRIMARY KEY (transactions_id)
);



⚙️ Data Cleaning Steps
Null Value Detection
Checked for NULL values in all key columns.

Handling Missing Age
Updated NULL values in the age column by replacing them with the average age.

Deleting Incomplete Sales
Deleted records with NULL quantity, as these are incomplete transactions.

🔍 Data Exploration Highlights
Total Number of Sales

sql
Copy
Edit
SELECT COUNT(total_sale) FROM sales;
Unique Customers

sql
Copy
Edit
SELECT COUNT(DISTINCT(customer_id)) FROM sales;
Distinct Product Categories

sql
Copy
Edit
SELECT DISTINCT(category) FROM sales;
💡 Business Problem Solving
Retrieve Sales from November 2022

sql
Copy
Edit
CREATE VIEW Nov_2022_sales AS (
    SELECT * FROM sales
    WHERE EXTRACT(YEAR FROM sale_date) = 2022 
    AND EXTRACT(MONTH FROM sale_date) = 11
);
High-Value Clothing Sales in Nov-2022

sql
Copy
Edit
SELECT * FROM Nov_2022_sales 
WHERE category = 'Clothing' AND total_sale > 1000;
Total Sales and Transactions per Category

sql
Copy
Edit
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders
FROM sales
GROUP BY category;
Average Age of Beauty Product Buyers

sql
Copy
Edit
SELECT ROUND(AVG(age),0) AS average_age
FROM sales 
WHERE category = 'Beauty';
Sales Breakdown by Gender and Category

sql
Copy
Edit
SELECT gender, category, COUNT(transactions_id), SUM(total_sale)
FROM sales 
GROUP BY gender, category
ORDER BY SUM(total_sale) DESC;
Best Selling Month Per Year

sql
Copy
Edit
SELECT * FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS Year,
           EXTRACT(MONTH FROM sale_date) AS Month,  
           SUM(total_sale) AS total_sales, 
           RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY SUM(total_sale) DESC) AS ranking
    FROM sales
    GROUP BY 1,2
) AS sub 
WHERE ranking = 1;
Top 5 Customers by Sales

sql
Copy
Edit
SELECT customer_id, SUM(total_sale) AS total_sales
FROM sales 
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
Unique Customers per Category

sql
Copy
Edit
SELECT category, COUNT(DISTINCT(customer_id))
FROM sales 
GROUP BY category
ORDER BY 2 DESC;
Order Distribution by Time of Day

sql
Copy
Edit
WITH shift_timing AS (
    SELECT *,
           CASE 
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS Time_of_day
    FROM sales 
)
SELECT Time_of_day, COUNT(transactions_id) AS total_orders 
FROM shift_timing 
GROUP BY Time_of_day
ORDER BY total_orders DESC;
📊 Key Learnings
Data cleaning techniques using UPDATE and DELETE.

Creating reusable VIEWS for filtered data.

Advanced aggregations using GROUP BY and RANK().

Business-focused queries for actionable insights.

🚀 Conclusion
This project strengthened my skills in SQL for data cleaning, exploration, and real-world problem-solving. The queries simulate typical questions a business would ask to drive decision-making.

💡 How to Use
Clone this repository.

Run the provided SQL scripts in any SQL-compatible environment (PostgreSQL, MySQL, or SQLite with minor tweaks).

Modify queries to suit your business needs or datasets!

If you'd like help setting this up or adapting it to your own dataset, feel free to reach out!
Happy querying! 🎯
