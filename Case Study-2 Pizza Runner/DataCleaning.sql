UPDATE customer_orders 
SET 
    exclusions = CASE
        WHEN exclusions IN ('' , 'null') THEN NULL
        ELSE exclusions
    END,
    extras = CASE
        WHEN extras IN ('' , 'null') THEN NULL
        ELSE extras
    END;


UPDATE runner_orders 
SET 
    pickup_time = CASE
        WHEN pickup_time = 'null' THEN NULL
        ELSE pickup_time
    END,
    distance = CASE
        WHEN distance LIKE 'null' THEN NULL
        WHEN distance LIKE '%km' THEN TRIM('km' FROM distance)
        ELSE distance
    END,
    duration = CASE
        WHEN duration LIKE 'null' THEN NULL
        WHEN duration LIKE '%mins' THEN TRIM('mins' FROM duration)
        WHEN duration LIKE '%minute' THEN TRIM('minute' FROM duration)
        WHEN duration LIKE '%minutes' THEN TRIM('minutes' FROM duration)
        ELSE duration
    END,
    cancellation = CASE
        WHEN cancellation IN ('' ,'NaN', 'null') THEN NULL
        ELSE cancellation
    END;
    
    
ALTER TABLE runner_orders
MODIFY COLUMN pickup_time  TIMESTAMP;

ALTER TABLE runner_orders
MODIFY COLUMN distance NUMERIC;

ALTER TABLE runner_orders
MODIFY COLUMN duration  INT; 

    
