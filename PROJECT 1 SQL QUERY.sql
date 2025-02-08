DATA CLEANING -----
SELECT * FROM retail_sales
 WHERE 
 transactions_id IS Null
 OR
 sale_date IS Null
 OR
 sale_time IS Null
 OR 
 customer_id IS Null
 OR
 gender IS NUll
 OR
 age IS NULL
 OR
 category IS Null
 OR
 quantiy IS Null
 OR
 price_per_unit IS Null
 OR
 cogs IS NUll
 OR
 total_sale IS Null

----
DELETE FROM retail_sales

 WHERE 
 transactions_id IS Null
 OR
 sale_date IS Null
 OR
 sale_time IS Null
 OR 
 customer_id IS Null
 OR
 gender IS NUll
 OR
 age IS NULL
 OR
 category IS Null
 OR
 quantiy IS Null
 OR
 price_per_unit IS Null
 OR
 cogs IS NUll
 OR
 total_sale IS Null
 -----
SELECT * from retail_sales

-------------DATA EXPLORATION

Q1-- HOW MANY SALES WE HAVE?

SELECT COUNT(total_sale) AS numbers,SUM(total_sale) AS revenue
FROM retail_sales;
ans --- numbers = 1987
        revenue = 908230

Q2--- How many unique customers we have?
SELECT COUNT(distinct (customer_id)) as customers from retail_sales;
ans --- 155

q3--- How many unique categroy we have?
SELECT distinct (category) as customers from retail_sales;

ans--3

----data analysis/bussiness key problems:

--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05?

 SELECT count (sale_date) as sale_date FROM retail_sales
  WHERE sale_date = '2022-11-05';

  ANS - 11

--2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is
---more than 4 in the month of Nov-2022**:

 SELECT * FROM retail_sales
  WHERE category = 'Clothing'
  AND
  TO_CHAR (sale_date,'YYYY-MM') = '2022-11'
  AND
  quantiy >=4;

  ans - 17
--3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

SELECT category,COUNT(category) as category,SUM(total_sale) as sale 
  FROM  retail_sales
  GROUP BY 1;
 ans--
"Electronics" 678	311445
"Clothing"	  698   309995
"Beauty"	  611   286790

--4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

SELECT category,
ROUND (AVG (age),2) from 
 retail_sales
 WHERE category = 'Beauty'
 GROUP BY category;

 ans- "Beauty"	40.41
 
---5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

 SELECT * FROM retail_sales
  WHERE total_sale > 1000;
 
ANS- 306

---6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender
--in each category.**:


SELECT category,gender,count(gender) as gender_total
 FROM retail_sales
 GROUP BY 1,2;

 --"Clothing"	"Female"	347
"Electronics"	"Male"	343
"Beauty"	"Female"	330
"Electronics"	"Female"	335
"Clothing"	"Male"	351
"Beauty"	"Male"	281


--7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

SELECT * 
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
WHERE rank = 1;


2022	7	541.3414634146342	1
2023	2	535.531914893617	1

--8. **Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT customer_id, SUM (total_sale)
  FROM retail_sales
  GROUP BY 1
  ORDER BY 2 desc
  LIMIT 5;

 3	38440
1	30750
5	30405
2	25295
4	23580
SELECT * from retail_sales

--9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

SELECT category,
  COUNT(DISTINCT customer_id) AS customer_id
 FROM retail_sales
 GROUP BY category;


 --10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

WITH hourly_shift
 AS
(
SELECT *,
  CASE 
  WHEN EXTRACT (HOUR FROM sale_time) <12  THEN 'Morning'
  WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
ELSE 'evening'
  END AS shift
  FROM retail_sales
 ) 
 
 SELECT  shift,
  COUNT (*) AS sales
  FROM hourly_shift
  GROUP BY shift
  
--ANS 
"evening"	1062
"afternoon"	377
"Morning"	548

--END OF PROJECT














 

