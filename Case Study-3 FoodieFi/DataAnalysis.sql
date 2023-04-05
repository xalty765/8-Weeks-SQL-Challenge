
/* --------------------
   Case Study Questions
   --------------------*/
-- Author: Sankalp Sachan
-- Tool: MySQL Server


-- How many customers has Foodie-Fi ever had?

SELECT 
    COUNT(DISTINCT customer_id)
FROM
    subscriptions;

-- What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

SELECT 
    MONTH(s.start_date) AS months,
    COUNT(distinct customer_id) AS distribution
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    p.plan_name = 'trial'
GROUP BY MONTH(s.start_date)
ORDER BY MONTH(s.start_date);

-- What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

SELECT 
    p.plan_name, COUNT(DISTINCT customer_id)
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    YEAR(s.start_date) > '2020'
GROUP BY p.plan_name;

-- What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

SELECT 
    COUNT(DISTINCT customer_id) AS 'churned_customers',
    ROUND((COUNT(DISTINCT customer_id) / (SELECT 
                    COUNT(DISTINCT customer_id)
                FROM
                    subscriptions) * 100),
            2) AS churn_percentage
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    plan_name = 'churn';

-- How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

WITH CTE as (
	SELECT
		s.customer_id, s.plan_id, s.start_date,
		ROW_NUMBER()
			OVER(PARTITION BY s.customer_id
				ORDER BY s.start_date) AS rnk
	FROM subscriptions s)
    
SELECT COUNT(customer_id) AS number_of_churn_after_trial
FROM CTE
WHERE rnk = 2 AND plan_id = 4;

-- What is the number and percentage of customer plans after their initial free trial?

WITH cte AS (
	SELECT
		s.customer_id, s.plan_id, s.start_date,p.plan_name,
		ROW_NUMBER()
			OVER(PARTITION BY s.customer_id
				ORDER BY s.start_date) AS rnk
	FROM subscriptions s
    join plans p on s.plan_id =p.plan_id)
    
SELECT  plan_name ,COUNT(distinct customer_id) FROM cte where rnk =2 
GROUP BY plan_name;

-- How many customers have upgraded to an annual plan in 2020?
    
SELECT 
	COUNT(DISTINCT customer_id) AS number_of_customer_annual_plan
FROM subscriptions s
LEFT JOIN plans p
ON s.plan_id = p.plan_id
WHERE 
	(YEAR(start_date) = 2020 AND 
    plan_name LIKE '%annual%');
    
-- How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
 
 WITH trial AS
  (SELECT * FROM subscriptions
  WHERE plan_id = 0),
  annual as 
   (SELECT * FROM subscriptions 
   WHERE plan_id =3)

SELECT AVG(datediff(a.start_date,t.start_date)) AS  average_days_to_annual
FROM rial t 
    JOIN annual a 
   ON a.customer_id = t.customer_id

-- Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)


-- How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

