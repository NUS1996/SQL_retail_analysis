# 🧾 Retail Sales Data Analysis — SQL Project

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
```

---

## ⚙️ Data Cleaning Steps

1. **Null Value Detection**  

```sql
SELECT * 
FROM sales 
WHERE (transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL 
OR customer_id IS NULL OR gender IS NULL OR age IS NULL
OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL 
OR cogs IS NULL OR total_sale IS NULL);
```

2. **Handling Missing Age Values**  

```sql
UPDATE sales 
SET age = sub.avg_age FROM 
(SELECT ROUND(AVG(age),2) AS avg_age FROM sales WHERE age IS NOT NULL) AS sub
WHERE age IS NULL;
```

3. **Deleting Incomplete Sales**  

```sql
DELETE FROM sales 
WHERE quantity IS NULL;
```

---

## 🔍 Data Exploration Highlights

- **Total Number of Sales**

```sql
SELECT COUNT(total_sale) FROM sales;
```

- **Unique Customers**

```sql
SELECT COUNT(DISTINCT(customer_id)) FROM sales;
```

- **Distinct Product Categories**

```sql
SELECT DISTINCT(category) FROM sales;
```

---

## 💡 Business Problem Solving

1. **Retrieve Sales from November 2022**

```sql
CREATE VIEW Nov_2022_sales AS (
    SELECT * FROM sales
    WHERE EXTRACT(YEAR FROM sale_date) = 2022 
    AND EXTRACT(MONTH FROM sale_date) = 11
);
```

2. **High-Value Clothing Sales in Nov-2022**

```sql
SELECT * FROM Nov_2022_sales 
WHERE category = 'Clothing' AND total_sale > 1000;
```

3. **Total Sales and Transactions per Category**

```sql
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders
FROM sales
GROUP BY category;
```

4. **Average Age of Beauty Product Buyers**

```sql
SELECT ROUND(AVG(age),0) AS average_age
FROM sales 
WHERE category = 'Beauty';
```

5. **Sales Breakdown by Gender and Category**

```sql
SELECT gender, category, COUNT(transactions_id), SUM(total_sale)
FROM sales 
GROUP BY gender, category
ORDER BY SUM(total_sale) DESC;
```

6. **Best Selling Month Per Year**

```sql
SELECT * FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS Year,
           EXTRACT(MONTH FROM sale_date) AS Month,  
           SUM(total_sale) AS total_sales, 
           RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY SUM(total_sale) DESC) AS ranking
    FROM sales
    GROUP BY 1,2
) AS sub 
WHERE ranking = 1;
```

7. **Top 5 Customers by Sales**

```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM sales 
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

8. **Unique Customers per Category**

```sql
SELECT category, COUNT(DISTINCT(customer_id))
FROM sales 
GROUP BY category
ORDER BY 2 DESC;
```

9. **Order Distribution by Time of Day**

```sql
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
```

---

## 📊 Key Learnings

- Data cleaning techniques using `UPDATE` and `DELETE`.
- Creating reusable `VIEWS` for filtered data.
- Advanced aggregations using `GROUP BY` and `RANK()`.
- Business-focused queries for actionable insights.

---

## 🚀 Conclusion

This project strengthened my skills in SQL for data cleaning, exploration, and real-world problem-solving. The queries simulate typical questions a business would ask to drive decision-making.

---

## 💡 How to Use

1. Clone this repository.
2. Run the provided SQL scripts in any SQL-compatible environment (PostgreSQL, MySQL, or SQLite with minor tweaks).
3. Modify queries to suit your business needs or datasets!

---

If you'd like help setting this up or adapting it to your own dataset, feel free to reach out!  
Happy querying! 🎯

---
