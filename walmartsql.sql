CREATE DATABASE walmart_sales;
USE walmart_sales;
CREATE TABLE sales(
Invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
Branch VARCHAR(10) NOT NULL,
City VARCHAR(30) NOT NULL,
Customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(30) NOT NULL,
Product_line VARCHAR(100) NOT NULL,
Unit_price DECIMAL(10,2) NOT NULL,
Qunatity INT NOT NULL,
VAT FLOAT(6,4) NOT NULL,
Total DECIMAL(12,4) NOT NULL,
Date DATETIME NOT NULL,
time TIME NOT NULL,
Payment_method VARCHAR(20) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_percentage FLOAT(11,9) NOT NULL,
gross_Income DECIMAL(10,2) NOT NULL,
Rating FLOAT(2,1) NOT NULL
);

DESCRIBE sales;

SELECT * FROM walmart_sales.sales;


-- data cleaning----
-- Setting the time of the day

SELECT time,
( CASE 
  WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
  WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
  ELSE "Evening"
  END
) AS Time_of_theday
FROM sales;

ALTER TABLE sales ADD COLUMN Time_of_day VARCHAR(30) ;

UPDATE sales
set Time_of_theday = ( CASE 
  WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
  WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
  ELSE "Evening"
  END)
  ;
-- Setting the day of week
SELECT date,
    DAYNAME(date) as Day
FROM sales;

ALTER TABLE sales ADD COLUMN day VARCHAR(30);

UPDATE sales
SET day = DAYNAME(date);

-- setting the Month
SELECT date,
MONTHNAME(Date) AS Month
FROM sales;

ALTER TABLE sales ADD COLUMN month varchar(30);

UPDATE sales
SET month =MONTHNAME(Date);

-- ----------------------------------------------------------------- EXPLORATORY DATA ANALYSIS ------
-- ----------------------------------------------generic question ----
--  How Many Unique cities does the data have? ----

SELECT
   DISTINCT City
FROM sales;


-- In which city is each branch?

SELECT
   DISTINCT Branch, City
FROM sales;

-- How many unique product lines does the data have?
SELECT
   COUNT( DISTINCT Product_line)
FROM sales;
-- ------------------------------------------------------ PRODUCTS QUESTIONS-----------------------------------------------------------------------
-- what is the most common payment method?

SELECT  payment_method,
   COUNT(Payment_method) 
FROM sales
GROUP BY payment_method
ORDER BY COUNT(Payment_method) DESC
;

-- -----What is the most selling product line?------ Fashion accessories with 178 counts----
SELECT  Product_line,
   COUNT(Product_line) as most_selling_productline
FROM sales
GROUP BY Product_line
ORDER BY COUNT(Product_line) DESC
;


-- total revenue by month

SELECT   
	month, 
    SUM(Total) AS Total_REVENUE
 FROM sales
 GROUP BY month
 ORDER BY Total_REVENUE DESC ;
 
 -- What month has the largest cogs?----
 
SELECT   
	month, 
    SUM(cogs) AS cogs
 FROM sales
 GROUP BY month
 ORDER BY cogs DESC ;
 
 -- What product line has the largest revenue?

 
SELECT   
	Product_line, 
    SUM(total) AS total_revenue
 FROM sales
 GROUP BY Product_line
 ORDER BY total_revenue DESC ;

-- what city has the largest revenue?
SELECT 
    Branch,  
	city, 
    SUM(total) AS total_revenue
 FROM sales
 GROUP BY city,Branch
 ORDER BY total_revenue DESC ;
 
 -- what productline has the largest VAT
 SELECT 
    Product_line, AVG(VAT) AS VAT
FROM
    sales
GROUP BY Product_line
ORDER BY VAT DESC;
 
 -- Fetch each product line and add a column to those product line showing "Good,"Bad". Good if its greater than average sales
 
 
 
 
 
 
 
 
 -- Which branch sold more product than average product sold?
 SELECT   
	Branch, 
    SUM(Quantity) AS Quantity
 FROM sales
 GROUP BY Branch
 Having SUM(Quantity) > (SELECT AVG(Quantity) FROM sales);
 
 -- What is the most product line by gender?
 
 SELECT  
	gender,
	Product_line,
    COUNT(gender) as gender_count
 FROM sales
 GROUP BY gender, Product_line
 ORDER BY gender_count DESC;
 
 -- What is the Average rating of each product line?
 SELECT 
	Product_line, 
	ROUND(AVG(Rating),2) AS avg_rating
 FROM sales
 GROUP BY Product_line
 ORDER BY avg_rating DESC ;

 -- ---------------------------------------------------------------------SALES QUESTIONS --------------
 -- Number of sales made in each time of the day per weekday?
 SELECT   
	COUNT(Total) as total, 
    time_of_theDay
FROM sales
GROUP BY time_of_theDay ;

-- Which  of the customer types brings the most revenue?
SELECT   
	customer_type ,
    ROUND(SUM(total),2) AS total
 FROM sales
 GROUP BY Customer_type
 ORDER BY total DESC ;
 
 -- Which city has the largest tax percentage (VAT) Value added tax?
 SELECT 
	Branch,
	City, 
    ROUND(AVG(VAT),2) AS vat
 FROM sales
 GROUP BY City,Branch
 ORDER BY vat DESC ;
 
 -- Which customer types pays the most in VAT?
 SELECT   
	Customer_type, 
    ROUND(AVG(VAT),2) AS VAT
 FROM sales
 GROUP BY Customer_type
 ORDER BY VAT DESC ;
 
 -- ------------------------------------------------------------CUSTOMER QUESTIONS---
 
-- how many unique customers does the dataset have?

SELECT   
	COUNT( DISTINCT(Customer_type)) AS customertype
FROM sales;

--  how many unique Payment methods does the dataset have?
SELECT   
	DISTINCT Payment_method
FROM sales;
 
 -- Which is customer type buys the most?
 SELECT   
	DISTINCT Customer_type,
    COUNT(*) as count
FROM sales
GROUP BY Customer_type
ORDER BY Customer_type DESC ;


-- What is the gender of most customers?
SELECT   
	DISTINCT gender,
    COUNT(*) as customer_count
FROM sales
GROUP BY gender
ORDER BY gender DESC ;

-- what is gender distribution per branch?
SELECT   
	DISTINCT gender,
    COUNT(*) as gender_count
FROM sales
WHERE Branch ="A"
GROUP BY gender
ORDER BY gender DESC ;

-- Which time of the day do customers give more rating?

SELECT   
    AVG(Rating) AS aver_ratinG,
    time_of_theDay
FROM sales
GROUP BY time_of_theDay
ORDER BY aver_ratinG DESC ;
-- Which time of the day do customers give more rating per branch?
SELECT  
    AVG(Rating) AS aver_ratinG,
    time_of_theDay
FROM sales
WHERE Branch = "A"
GROUP BY time_of_theDay
ORDER BY aver_ratinG DESC ;

-- Which day of the week has the best avg rating
SELECT  
    ROUND(AVG(Rating),2 )AS aver_ratinG,
	day
FROM sales
GROUP BY day
ORDER BY aver_ratinG DESC ;


-- Which day of the week has the best avg rating per branch?

SELECT  
    AVG(Rating) AS aver_ratinG,
    time_of_theDay
FROM sales
WHERE Branch = "A"
GROUP BY time_of_theDay
ORDER BY aver_ratinG DESC ;





 


















