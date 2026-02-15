-- Objective 1: menu analysis queries
-- Run these against the restaurant_db schema.

-- Find the number of items on the menu
-- Note: Counts all rows in menu_items.

SELECT 
    COUNT(item_name) AS number_of_items
FROM menu_items;

-- Identify the least and most expensive items
-- Note: Returns one row for min and max price. When tied, min and max are equal.

WITH temp_most_expensive AS (
    SELECT 
        TOP 1 'Most expensive' AS price_type
        ,menu_item_id
    FROM menu_items
    ORDER BY price DESC
),
temp_least_expensive AS (
    SELECT 
        TOP 1 'Least expensive' AS price_type
        ,menu_item_id
    FROM menu_items
    ORDER BY price ASC
),
temp_price_extremes AS (
    SELECT *
    FROM temp_most_expensive
    UNION ALL
    SELECT *
    FROM temp_least_expensive
)

SELECT *
FROM temp_price_extremes tpe
LEFT JOIN menu_items mi ON tpe.menu_item_id = mi.menu_item_id
ORDER BY mi.price DESC;

-- Determine how many Italian dishes are on the menu and their price range
-- Note: Uses category-level grouping with a case-insensitive filter.

SELECT 
    COUNT(1) AS number_of_items
    ,MIN(1) AS minimum_price
    ,MAX(1) AS maximum_price
FROM menu_items
GROUP BY category
HAVING LOWER(category) = 'italian';

-- Count dishes by category and calculate average price per category
-- Note: Returns one row per category with counts and average price.

SELECT
    category
    ,COUNT(category)
    ,AVG(price)
FROM menu_items
GROUP BY category;