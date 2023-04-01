/* --------------------
   Case Study Questions
   --------------------*/
   
-- Author: Sankalp Sachan
-- Date: 24/1/2022
-- Tool: MySQL Server
# What is the total amount each customer spent at the restaurant?

SELECT 
    S.customer_id, CONCAT('$', SUM(M.price)) AS Total_sales
FROM
    sales S
        JOIN
    menu M ON S.product_id = M.product_id
GROUP BY S.customer_id;

# How many days has each customer visited the restaurant?

SELECT 
    customer_id, COUNT(DISTINCT order_date) AS No_of_visits
FROM
    sales
GROUP BY customer_id;

#What was the first item from the menu purchased by each customer?

WITH cte AS (SELECT DISTINCT  customer_id,order_date,product_name,
DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS rnk
FROM
    sales S
        JOIN
    menu M ON S.product_id = M.product_id)
    SELECT customer_id,product_name FROM cte WHERE rnk =1; 

#What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT 
    product_name, COUNT(order_date) AS order_count
FROM
    sales S
        JOIN
    menu M ON S.product_id = M.product_id
GROUP BY product_name
ORDER BY order_count DESC
LIMIT 1;

# Which item was the most popular for each customer?

WITH CTE AS
           (SELECT S.customer_id, M.product_name , count(order_date) as order_count,
            DENSE_RANK() OVER(PARTITION BY S.customer_id ORDER BY count(order_date) DESC) AS rnk
			FROM
            sales S
            JOIN
            menu M ON S.product_id = M.product_id
            GROUP BY customer_id,product_name)

SELECT customer_id ,product_name FROM CTE WHERE rnk =1
GROUP BY customer_id;

 #Which item was purchased first by the customer after they became a member?
 
With cte AS 
    (SELECT 
    S.customer_id, order_date, join_date, product_name,
    DENSE_RANK() OVER(PARTITION BY S.CUSTOMER_ID ORDER BY ORDER_DATE) AS RNK
    
    FROM
    sales S
        INNER JOIN
    members MEM ON S.customer_id = MEM.customer_id
        INNER JOIN
    menu M ON S.product_id = M.product_id
    WHERE
    order_date >= join_date)
SELECT customer_id,product_name FROM cte
WHERE rnk =1;

# Which item was purchased just before the customer became a member?

With cte AS 
    (SELECT 
    S.customer_id, order_date, join_date, product_name,
    DENSE_RANK() OVER(PARTITION BY S.CUSTOMER_ID ORDER BY ORDER_DATE DESC) AS RNK
    
    FROM
    sales S
        INNER JOIN
    members MEM ON S.customer_id = MEM.customer_id
        INNER JOIN
    menu M ON S.product_id = M.product_id
    WHERE
    order_date < join_date)
SELECT customer_id,product_name FROM cte
WHERE rnk =1;

# What is the total items and amount spent for each member before they became a member?

SELECT 
    S.customer_id, order_date, join_date, Count(product_name) AS total_item,SUM(price) AS amount_spent
    FROM
    sales S
        INNER JOIN
    members MEM ON S.customer_id = MEM.customer_id
        INNER JOIN
    menu M ON S.product_id = M.product_id
    WHERE
    order_date < join_date
    GROUP BY customer_id;
    
 /* If each $1 spent equates to 10 points and sushi has a 2x points multiplier -
 how many points would each customer have?   
 */
SELECT 
    s.customer_id,
    product_name,
    price,
    SUM(CASE
        WHEN product_name = 'sushi' THEN price * 10 * 2
        ELSE price * 10
    END) AS points
FROM
    menu m
        JOIN
    sales s ON s.product_id = m.product_id
GROUP BY customer_id;

/*
 In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi 
 - how many points do customer A and B have at the end of January?
 */
SELECT 
    S.customer_id,
    SUM(CASE
        WHEN order_date BETWEEN MEM.join_date AND DATE_ADD(MEM.join_date, INTERVAL 6 DAY) THEN price * 10 * 2
        WHEN product_name = 'sushi' THEN price * 10 * 2
        ELSE price * 10
    END) AS points
FROM
    menu M
        JOIN
    sales S ON S.product_id = M.product_id
        JOIN
    members MEM ON S.customer_id = mem.customer_id
WHERE
    order_date <= '2021-01-31'
GROUP BY S.customer_id
