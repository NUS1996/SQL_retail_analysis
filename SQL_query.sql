-- Creating Table 
DROP TABLE if exists retail_sales;
CREATE TABLE retail_sales 
( 		transactions_id INT PRIMARY KEY,	
		sale_date DATE,	
		sale_time TIME,	
		customer_id INT,
		gender VARCHAR(15),	
		age INT,
		category VARCHAR(15),	
		quantiy INT,
		price_per_unit FLOAT,	
		cogs FLOAT,	
		total_sale FLOAT
)

SELECT COUNT(*)
FROM retail_sales;

SELECT * 
FROM retail_sales
LIMIT 2;

-- Detecting any null values 
SELECT * 
FROM retail_sales 
WHERE transactions_id IS NULL OR	
		sale_date IS NULL OR
		sale_time IS NULL OR
		customer_id IS NULL OR
		gender IS NULL OR	
		age IS NULL OR
		category IS NULL OR
		quantiy IS NULL OR	
		price_per_unit IS NULL OR	
		cogs IS NULL OR
		total_sale IS NULL;

-- Deleting any null values 
DELETE FROM retail_sales 
WHERE transactions_id IS NULL OR	
		sale_date IS NULL OR
		sale_time IS NULL OR
		customer_id IS NULL OR
		gender IS NULL OR	
		age IS NULL OR
		category IS NULL OR
		quantiy IS NULL OR	
		price_per_unit IS NULL OR	
		cogs IS NULL OR
		total_sale IS NULL;

ALTER TABLE retail_sales
RENAME COLUMN  quantiy TO quantity;

-- Data Exploration 

-- How many sales do we have? 

SELECT COUNT(*) FROM retail_sales;

-- How many customers?

SELECT COUNT(DISTINCT(customer_id)) AS unique_customers
FROM retail_sales;

-- ALl the categories 

SELECT DISTINCT(category)
FROM retail_sales;

-- Data Analysis and Findings 
SELECT * 
FROM retail_sales
LIMIT 5;

/*1. Write a SQL query to retrieve all columns for sales made on Dec 2022, 
also how many of them were male and female customers */

SELECT * 
FROM retail_sales
WHERE sale_date BETWEEN '2022-12-01' AND '2022-12-31';

SELECT gender, COUNT(gender)
FROM retail_sales 
WHERE sale_date BETWEEN '2022-12-01' AND '2022-12-31'
GROUP BY gender;

/*
2. Write a SQL query to retrieve all transactions where the category is 
'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
*/

SELECT *
FROM retail_sales 
WHERE (sale_date BETWEEN '2022-11-01' AND '2022-11-30') AND (category = 'Electronics' AND quantity > 3);

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category and how many orders.

SELECT category, SUM(total_sale) AS sales_in_total, COUNT(*) AS total_orders
FROM retail_sales 
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT category, ROUND(AVG(age),1) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY 1;

SELECT category,gender, COUNT(*), ROUND(AVG(age),1) AS avg_age
FROM retail_sales
GROUP BY 1,2 
ORDER BY 2 ;

-- 5. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT *
FROM retail_sales 
LIMIT 5;

SELECT * 
FROM 
(SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	TRUNC(AVG(total_sale)::numeric,2) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1,2) as t1
WHERE rank = 1;

-- 6. *Write a SQL query to find the top 5 customers based on the highest total sales

SELECT * 
FROM retail_sales 
LIMIT 5;

SELECT customer_id, SUM(total_sale)
FROM retail_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- 7. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT(customer_id))
FROM retail_sales
GROUP BY category
ORDER BY 2 DESC;

/*
Write a SQL query to create each shift and number of orders
(Example Morning <12, Afternoon Between 12 & 17, Evening >17)
*/

SELECT * 
FROM retail_sales
LIMIT 5;

WITH shift_table
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)

SELECT shift, COUNT(*)
FROM shift_table
GROUP BY shift 
ORDER BY 2 DESC;







		
