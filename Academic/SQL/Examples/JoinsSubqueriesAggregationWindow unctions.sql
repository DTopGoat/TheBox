--SQL query that showcases various SQL features such as joins, subqueries, aggregation functions, and window functions. Here's an example:

-- A query that returns the top 3 selling products for each category in a store
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
WITH sales_data AS (
    SELECT 
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(o.quantity) OVER (PARTITION BY p.product_id) AS total_sales
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    JOIN orders o ON p.product_id = o.product_id
),
ranked_sales AS (
    SELECT 
        product_id,
        product_name,
        category_name,
        total_sales,
        RANK() OVER (PARTITION BY category_name ORDER BY total_sales DESC) AS sales_rank
    FROM sales_data
)
SELECT 
    product_id,
    product_name,
    category_name,
    total_sales
FROM ranked_sales
WHERE sales_rank <= 3;

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

--This SQL script does the following:

--Joins the products, categories, and orders tables to get the total sales for each product.
--Ranks the products within each category based on their total sales.
--Returns the top 3 selling products in each category.
--Please note that this is a general example and may need to be modified to fit your specific database schema.