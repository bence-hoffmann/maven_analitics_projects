# Restaurant Order Analysis

## Overview
This project analyzes order data from a fictitious international cuisine restaurant to identify the most and least popular menu items and types of cuisine.

## Dataset
**Restaurant Orders** - A quarter's worth of orders from a restaurant with international cuisine
- **Records**: 12,266
- **Fields**: 8
- **Structure**: Multiple tables
- **Type**: MySQL file converted to T-SQL

## Project Structure
- `create_restaurant_db.sql` - Database creation and data insertion script
- `restaurant_db_data_dictionary.csv` - Data dictionary for reference
- SQL queries for analysis

## Analysis Objectives

### Objective 1: Menu Analysis
View the menu_items table and:
- Find the number of items on the menu
- Identify the least and most expensive items
- Determine how many Italian dishes are on the menu and their price range
- Count dishes by category and calculate average price per category

### Objective 2: Order Details Analysis
View the order_details table and:
- Determine the date range of orders
- Count total orders and items ordered
- Identify which orders had the most items
- Find how many orders had more than 12 items

### Objective 3: Combined Analysis
Combine menu_items and order_details tables to:
- Find the least and most ordered items and their categories
- Identify the top 5 orders that spent the most money
- View details of the highest spend order and specific items purchased
- BONUS: View details of the top 5 highest spend orders

### Final Question
How much was the most expensive order in the dataset?