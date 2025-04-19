-- Creating the Sales Table
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (transactions_id INT NOT NULL,	
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
)

SELECT * 
FROM sales
LIMIT 10;

SELECT COUNT(*)
FROM sales;

-- Finding any null values 

SELECT * 
FROM sales 
WHERE (transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR age IS NULL
OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL);

-- updating null values in age column to the average age 
UPDATE sales 
SET age = sub.avg_age FROM 
( SELECT ROUND(AVG(age),2) AS avg_age
FROM sales
WHERE age IS NOT NULL
) AS sub
WHERE age IS NULL  ;

-- Deleting the rest of null values as they have no sales information 

DELETE FROM sales 
WHERE quantity IS NULL;


-- Data Exploration 

-- 1. Count of total no. of sales : 1997

SELECT COUNT(total_sale)
FROM sales;

-- 2. No. of unique customers : 155 

SELECT COUNT(DISTINCT(customer_id))
FROM sales;

-- 3. No. of distinct categories and what are they 

SELECT DISTINCT(category)
FROM sales;


-- BUSINESS PROBLEMS 

-- 1.Retrieve all columns for sales made on November 2022. 
DROP VIEW IF EXISTS Nov_2022_sales;
CREATE VIEW Nov_2022_sales AS (
SELECT * 
FROM sales 
WHERE (EXTRACT(YEAR FROM sale_date) = 2022) AND (EXTRACT(MONTH FROM sale_date) = 11)
);

SELECT * 
FROM Nov_2022_sales;
 
-- 2. Write a SQL query to retrieve all transactions where the category 
--               is 'Clothing' and the total_sale is more than 1000 in the month of Nov-2022

SELECT * 
FROM Nov_2022_sales 
WHERE category = 'Clothing' AND total_sale > 1000;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category and how many transactions 

SELECT category, SUM(total_sale) AS total_sales, COUNT(*) As total_orders
FROM sales
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT ROUND(AVG(age),0) AS average_age
FROM sales 
WHERE category = 'Beauty';

-- 5. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT gender, category, COUNT(transactions_id) AS total_transactions 
FROM sales 
GROUP BY gender, category
ORDER BY 3 DESC;