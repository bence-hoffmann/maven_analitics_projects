-- Final question: Most expensive order
-- Run this against the restaurant_db schema.

-- How much was the most expensive order in the dataset?
-- Note: Returns the order_id and total spent amount for the highest spend order.

WITH temp_spent_order AS (
    SELECT
        order_id
        ,SUM(mi.price) AS spent_money
    FROM order_details od
    LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
    GROUP BY order_id
)

SELECT TOP 1
    order_id
    ,spent_money
FROM temp_spent_order
ORDER BY spent_money DESC
