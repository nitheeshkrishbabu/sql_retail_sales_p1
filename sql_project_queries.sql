-- SQL Retail Sales Analysis 

select * from retail_sales;

select 
	count(*) 
from retail_sales;

-- Data Cleaning

select * from retail_sales
where 
transactions_id is null
or 
sale_date is null
or 
sale_time is null
or 
age is null
or
gender is null
or 
category is null
or 
cogs is null
or 
total_sale is null;

Delete from retail_sales
where 
transactions_id is null
or 
sale_date is null
or 
sale_time is null
or 
age is null
or
gender is null
or 
category is null
or 
cogs is null
or 
total_sale is null;

-- Data exploration

-- How many sales we have?

select count(1) as Total_sales
from retail_sales;

-- How many customers we have?

select distinct count(customer_id) as no_of_customer
from retail_sales;


-- Data Analysis & Business Key Problems & Answers

-- Q1: Write a SQL Query to retrive all columns for sales made on '2022-11-05'

select * 
	from retail_sales
where 
	sale_date = '2022-11-05';


-- Q2: Write a SQL Query to retrive all transactions where the category is 'clothing and the quantity sold is more than 4 in the month of Nov-2022'

select *
from retail_sales
where 
	category = 'Clothing'
	and 
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	and 
	quantiy >=4
order by sale_date;

-- Q3: Write a SQL Query to calculate the total sales & total orders for each category

select 
	category,
	sum(total_sale) as total_sales_category,
	count(1) as total_orders_category
from retail_sales
group by 
	category
order by 1;

-- Q4: Write a SQL Query to find the average age of customers who purshased items from the 'Beauty' category

-- OverAll Average Age:

select 
	round(avg(age),2) as average_age
from retail_sales
where 
	category in ('Beauty');

-- Average Age per customerid, gender:

select 
	customer_id,
	gender, 
	round(avg(age),2) as average_age
from retail_sales
where 
	category in ('Beauty')
group by 
	customer_id, gender
order by 1;

-- Q5: Write a SQL Query to find all transactions where total sale is greater than 1000

select *
from retail_sales
where total_sale > 1000;

-- Q6: Write a SQL Query to find the total number of transactions(transactions_id) made by each gender in each category

select 
	gender, 
	category,
	count(transactions_id) as total_transactions
from retail_sales
group by 
	gender, category
order by 2;

-- Q7: Write a SQL Query to calculate the average sale for each month. Find out best selling month in each year

select 
	months as best_selling_month, 
	years, 
	cast(avg_sales as int) as average_sales
from 
	(
		select *,
		row_number() over(partition by years order by avg_sales desc) as rn 
		from(

				select 
					extract (month from sale_date) as months, 
					extract (year from sale_date) as years, 
					avg(total_sale) as avg_sales
					from 
						retail_sales
							group by 
								extract (month from sale_date), extract (year from sale_date)
							order by 
								years, months
			) as x
		) as y 
where rn = 1;

-- Q8: Write a SQL Query to find the top 5 customers based on the highest total sales

select 
	customer_id, 
	sum(total_sale) as highest_sales
from retail_sales
group by 1
order by highest_sales desc
limit 5;

-- Q9: Write a SQL Query to find the number of unique customers who purchased items from each category:


select 
	category, 
		count( distinct customer_id) as no_of_unique_customers
from retail_sales
group by 1;

-- Q10: Write a SQL Query to create each shift and no.of orders(Example: Morning shift <=12, Afternoon shift between 12 & 17, Evening >17) 

select * from 
(
	select
	case
		when extract(hour from sale_time) < 12 then 'Morning_shift'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon_shift'
		else 'Night_shift'
	end as shifts,
	count(1) as no_of_orders
from retail_sales
GROUP BY shifts
) as x
ORDER BY 
	case
		when shifts = 'Morning_shift' then 1
		when shifts = 'Afternoon_shift' then 2
		else 3
	end;

-- End Of the Project




	
		












