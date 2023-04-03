/* --------------------
   Case Study Questions
   --------------------*/
-- Author: Sankalp Sachan
-- Tool: MySQL Server


-- How many pizzas were ordered?
SELECT 
    COUNT(*) AS pizza_count
FROM
    customer_orders;
    
-- How many unique customer orders were made?

SELECT 
    COUNT(DISTINCT order_id) AS unique_customer_orders
FROM
    customer_orders;

-- How many successful orders were delivered by each runner?

SELECT 
    runner_id, COUNT(order_id) AS orders_delivered
FROM
    runner_orders
WHERE
    cancellation IS NULL
GROUP BY runner_id;

-- How many of each type of pizza was delivered?

SELECT 
    pn.pizza_name, COUNT(co.pizza_id)
FROM
    runner_orders ro
        JOIN
    customer_orders co ON co.order_id = ro.order_id
        JOIN
    pizza_names AS pn ON co.pizza_id = pn.pizza_id
WHERE
    cancellation IS NULL
GROUP BY pn.pizza_name;

-- How many Vegetarian and Meatlovers were ordered by each customer?

SELECT 
    co.customer_id, pn.pizza_name, COUNT(co.pizza_id)
FROM
    customer_orders co
        JOIN
    pizza_names AS pn ON co.pizza_id = pn.pizza_id
GROUP BY co.customer_id , pn.pizza_name
ORDER BY customer_id;

-- What was the maximum number of pizzas delivered in a single order?

SELECT 
    co.order_id, COUNT(co.pizza_id)
FROM
    runner_orders ro
        JOIN
    customer_orders co ON co.order_id = ro.order_id
WHERE
    cancellation IS NULL
GROUP BY co.order_id
ORDER BY COUNT(co.pizza_id) DESC
LIMIT 1;

-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT 
    co.customer_id,
    SUM(CASE
        WHEN exclusions IS NULL AND extras IS NULL THEN 1
        ELSE 0
    END) AS 'no_change',
    SUM(CASE
        WHEN
            exclusions IS NOT NULL
                OR extras IS NOT NULL
        THEN
            1
        ELSE 0
    END) AS 'changes'
FROM
    runner_orders ro
        JOIN
    customer_orders co ON co.order_id = ro.order_id
WHERE
    cancellation IS NULL
GROUP BY customer_id;
    
-- How many pizzas were delivered that had both exclusions and extras?
SELECT 
    SUM(CASE
        WHEN
            exclusions IS NOT NULL
                AND extras IS NOT NULL
        THEN
            1
        ELSE 0
    END) AS 'both_exclusives_extras'
FROM
    runner_orders ro
        JOIN
    customer_orders co ON co.order_id = ro.order_id
WHERE
    cancellation IS NULL;
    
-- What was the total volume of pizzas ordered for each hour of the day?

SELECT 
    COUNT(pizza_id) AS pizza_ordered,
    HOUR(order_time) AS hour_of_the_day
FROM
    CUSTOMER_ORDERS
GROUP BY HOUR(order_time);
    
    
-- What was the volume of orders for each day of the week?
SELECT 
    COUNT(pizza_id) AS pizza_ordered,
    DAYNAME(order_time) AS day_of_week
FROM
    customer_orders
GROUP BY DAYNAME(order_time)
ORDER BY COUNT(pizza_id)