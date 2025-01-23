-- CREATING TABLE 
DROP TABLE IF EXISTS sales;
CREATE TABLE sales 
	(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,	
	gender VARCHAR(15),
	age INT,
	category VARCHAR(50),
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
	);

SELECT * 
FROM sales
LIMIT 5;

/*DATA CLEANING*/

-- Checking for any null values 

SELECT * 
FROM sales 
WHERE transactions_id IS NULL 
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL 
	OR
	customer_id  IS NULL 
	OR	
	gender IS NULL 
	OR
	age IS NULL 
	OR
	category IS NULL 
	OR
	quantity IS NULL 
	OR
	price_per_unit IS NULL 
	OR
	cogs IS NULL 
	OR
	total_sale IS NULL;

-- Deleting records with null values 

DELETE FROM sales 
WHERE transactions_id IS NULL 
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL 
	OR
	customer_id  IS NULL 
	OR	
	gender IS NULL 
	OR
	age IS NULL 
	OR
	category IS NULL 
	OR
	quantity IS NULL 
	OR
	price_per_unit IS NULL 
	OR
	cogs IS NULL 
	OR
	total_sale IS NULL;

-- Data Exploration 

-- How many unique customers does the business have? 

SELECT COUNT(DISTINCT(customer_id))
FROM sales;

-- How many categories does the business have and what are they? 

SELECT COUNT(DISTINCT(category))
FROM sales;

SELECT DISTINCT(category)
FROM sales;

-- Key Business Problems 

-- Write a SQL query to retrieve all columns for sales made in December 2022 and then in christmas and boxing day. 

SELECT * 
FROM sales 
WHERE sale_date BETWEEN '2022-12-01' AND '2022-12-31';

SELECT * 
FROM sales 
WHERE sale_date IN ('2022-12-25', '2022-12-26');

-- Write a SQL query to calculate the total sales for each category :

SELECT category, COUNT(total_sale),SUM(total_sale)
FROM sales 
GROUP BY category
ORDER BY 3 DESC;

-- Write a SQL query to find the number of unique customers who purchased items from each category :

SELECT category, COUNT(DISTINCT(customer_id)) 
FROM sales 
GROUP BY category 
ORDER BY 2 DESC;

-- Write a SQL query to retrieve all transactions where the category is 
--'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * 
FROM sales 
WHERE (category = 'Clothing' AND quantity > 3) 
AND  
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT * 
FROM (
SELECT category, ROUND(AVG(age),1)
FROM sales 
GROUP BY category)
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT *
FROM sales 
WHERE total_sale > 1000;

/*Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:*/

SELECT category, gender,COUNT(transactions_id) AS number_of_transactions
FROM sales 
GROUP BY category,gender
ORDER BY 3 DESC;


-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT EXTRACT(YEAR FROM sale_date) AS year, 
EXTRACT(MONTH FROM sale_date) AS month,
ROUND(AVG(total_sale::double precision)),
RANK () OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale::double precision) DESC) as rank
FROM sales 
GROUP BY 1,2; 

SELECT *
FROM sales
LIMIT 5;



