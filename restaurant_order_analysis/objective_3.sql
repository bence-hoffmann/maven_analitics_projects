-- Objective 3: combined analysis queries
-- Run these against the restaurant_db schema.

-- Find the least and most ordered items and their categories
-- Note: Returns one row for min and max order counts by item.

WITH item_counts AS (
    SELECT
        item_id,
        COUNT(1) AS order_count
    FROM order_details
    GROUP BY item_id
)
,temp_order_count_extremes AS (
    SELECT *
    FROM item_counts
    WHERE order_count = (SELECT MAX(order_count) FROM item_counts)

    UNION ALL

    SELECT *
    FROM item_counts
    WHERE order_count = (SELECT MIN(order_count) FROM item_counts)
)

SELECT
    mi.item_name
    ,mi.category
    ,t_oce.order_count
FROM temp_order_count_extremes t_oce
LEFT JOIN menu_items mi ON t_oce.item_id = mi.menu_item_id;

-- Identify the top 5 orders that spent the most money
-- Note: Returns top 5 orders ranked by total spending.

WITH temp_spent_order AS (
    SELECT
        order_id
        ,SUM(mi.price) AS spent_money
    FROM order_details od
    LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
    GROUP BY order_id)

SELECT TOP 5
    tso.order_id
    ,tso.spent_money
FROM temp_spent_order tso
ORDER BY tso.spent_money DESC;

-- View details of the highest spend order and specific items purchased
-- Note: Returns all items in the single highest spend order.

WITH temp_spent_order AS (
    SELECT
        order_id
        ,SUM(mi.price) AS spent_money
    FROM order_details od
    LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
    GROUP BY order_id
)
,temp_top_order AS (
    SELECT TOP 1
        order_id
        ,spent_money
    FROM temp_spent_order
    ORDER BY spent_money DESC
)

SELECT *
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
LEFT JOIN temp_top_order tto ON od.order_id = tto.order_id
WHERE tto.order_id IS NOT NULL;

-- BONUS: View details of the top 5 highest spend orders
-- Note: Returns all items across the top 5 highest spend orders.

WITH temp_spent_order AS (
    SELECT
        order_id
        ,SUM(mi.price) AS spent_money
    FROM order_details od
    LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
    GROUP BY order_id
)
,temp_top_5_orders AS (
    SELECT TOP 5
        order_id
        ,spent_money
    FROM temp_spent_order
    ORDER BY spent_money DESC
)

SELECT *
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
LEFT JOIN temp_top_5_orders t5o ON od.order_id = t5o.order_id
WHERE t5o.order_id IS NOT NULL
ORDER BY t5o.spent_money DESC, od.order_id;