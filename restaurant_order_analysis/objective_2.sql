-- Objective 2: order analysis queries
-- Run these against the restaurant_db schema.

-- Determine the date range of orders
-- Note: Returns the earliest and latest order_date values.

SELECT
    MIN(order_date) AS first_date
    ,MAX(order_date) AS last_date
FROM order_details;

-- Identify which orders had the most items
-- Note: Returns all orders tied for the maximum item count.

WITH temp_order_counts AS (
    SELECT
        order_id
        ,COUNT(order_id) AS order_count
    FROM order_details
    GROUP BY order_id
)

SELECT
    toc.order_id
    ,toc.order_count
FROM temp_order_counts toc
WHERE toc.order_count = (SELECT MAX(order_count) FROM temp_order_counts)
ORDER BY toc.order_id;

-- Find how many orders had more than 12 items
-- Note: Returns order_id values with item counts greater than 12.

WITH temp_order_counts AS (
    SELECT
        order_id
        ,COUNT(order_id) AS order_count
    FROM order_details
    GROUP BY order_id
)

SELECT
    toc.order_id
    ,toc.order_count
FROM temp_order_counts toc
WHERE toc.order_count > 12
ORDER BY toc.order_id;