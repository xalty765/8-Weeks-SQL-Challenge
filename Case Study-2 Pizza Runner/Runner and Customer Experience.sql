
/* --------------------
   Case Study Questions
   --------------------*/
-- Author: Sankalp Sachan
-- Tool: MySQL Server

-- Runner and Customer Experience

-- How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
select * from runners ;

SELECT 
    COUNT(*), WEEK(registration_date)
FROM
    runners
GROUP BY WEEK(registration_date);

-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

SELECT 
    runner_id,
    AVG(TIMESTAMPDIFF(MINUTE,order_time,pickup_time)) AS time_differnce
FROM
    runner_orders ro
        JOIN
    customer_orders co ON co.order_id = ro.order_id
WHERE
    cancellation IS NULL
GROUP BY runner_id;

-- Is there any relationship between the number of pizzas and how long the order takes to prepare?

WITH CTE AS (
      SELECT 
       co.order_id,
       count(co.pizza_id) as pizza_count,
       AVG(TIMESTAMPDIFF(MINUTE,order_time,pickup_time)) AS prep_time
       FROM
       runner_orders ro
	   JOIN
	   customer_orders co ON co.order_id = ro.order_id
	   WHERE
       cancellation IS NULL
       group by co.order_id)
SELECT  pizza_count,AVG(prep_time) AS avg_prep_time FROM cte
GROUP BY  pizza_count;   

-- What was the average distance travelled for each customer?
SELECT 
    co.customer_id, ro.order_id, AVG(distance)
FROM
    runner_orders ro
        JOIN
    customer_orders co ON co.order_id = ro.order_id
WHERE
    cancellation IS NULL
GROUP BY customer_id;

-- What was the difference between the longest and shortest delivery times for all orders?

SELECT 
    MAX(duration),
    MIN(duration),
    MAX(duration) - MIN(duration) AS maximum_difference
FROM
    runner_orders ro
        JOIN
    customer_orders co ON co.order_id = ro.order_id
WHERE
    cancellation IS NULL;
    
-- What was the average speed for each runner for each delivery and do you notice any trend for these values?    
  
SELECT 
    runner_id,
    ro.order_id,
    ROUND(AVG(distance / (duration / 60)), 1) AS avg_speed
FROM
    runner_orders ro
WHERE
    cancellation IS NULL
GROUP BY runner_id , order_id
ORDER BY runner_id;
    
-- What is the successful delivery percentage for each runner?

SELECT 
    runner_id,
    (SUM(CASE
        WHEN cancellation IS NULL THEN 1
        ELSE 0
    END) / COUNT(order_id)) * 100 AS successful_delivery_percentage
FROM
    runner_orders
GROUP BY runner_id;

	
    
