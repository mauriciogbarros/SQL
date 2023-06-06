-- Question 01
-- Display the total number of products and the total order amount for each
-- order id where the total number of products is less than 70. Sort the result
-- based on order id.
-- Order ID | Total Quantity | Total Amount
-- This query returns 4 rows.
SELECT
    order_id AS "Order ID",
    SUM(quantity) AS "Total Quantity",
    SUM(quantity*unit_price) AS "Total Amount"
FROM order_items
GROUP BY order_id
    HAVING SUM(quantity) < 70
ORDER BY order_id;
    
-- Question 02
-- For all customers, display customer number, customer full name, and the
-- total number of orders issued by the customer.
--  - If the customer does not have any orders, the number of orders shows 0.
--  - Display only customers whose customer name starts with 'G' and ends with
--      's'.
--  - Sort the result first by the number of orders and then by customer ID.
-- CUSTOMER_ID | NAME | Number of Orders
-- The query returns 6 rows.
COLUMN name FORMAT A20;
SELECT
    c.customer_id AS "CUSTOMER_ID",
    c.name AS "NAME",
    COUNT(o.order_id) AS "Number of Orders"
FROM customers c
    LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE c.name LIKE 'G%s'
GROUP BY c.customer_id, c.name
ORDER BY "Number of Orders", c.customer_id;

-- Question 03
-- Write a SQL statement to display Category ID, Category Name, the average
-- list_price, and the number of products for all categories in the
-- product_categories table.
--  - For categories in product_categories that do not have any matching
--      rows in products, the average price and the number of products are
--      shown as 0.
--  - Round the average price to one decimal place.
--  - Sort the result by category ID.
--  CATEGORY_ID | CATEGORY_NAME | Average Price | Number of Products
-- This query returns 5 rows.
COLUMN category_name FORMAT A15;
SELECT
    pc.category_id AS "CATEGORY_ID",
    pc.category_name AS "CATEGORY_NAME",
    NVL(ROUND(AVG(p.list_price),1),0) AS "Average Price",
    NVL(SUM(i.quantity),0) AS "Number of Products"
FROM product_categories pc
    LEFT JOIN products p ON pc.category_id = p.category_id
    LEFT JOIN inventories i ON p.product_id = i.product_id
GROUP BY pc.category_id, pc.category_name
ORDER BY pc.category_id;

-- Question 04
-- Write a SQL statement to display the number of different products and the
-- total quantity of all products for each warehouse.
-- Sort the result according to the quantity of all products.
-- WAREHOUSE_ID | Number of Different Products | Quantity of all products
-- This query returns 9 rows.
SELECT
    w.warehouse_id AS "WAREHOUSE_ID",
    COUNT(i.product_id) AS "Number of Different Products",
    SUM(i.quantity) AS "Quantity of All Products"
FROM warehouses w
    JOIN inventories i ON w.warehouse_id = i.warehouse_id
GROUP BY w.warehouse_id
ORDER BY "Quantity of All Products";

-- Question 05
-- Write a SQL statement to display the number of warehouses for each region.
--  - Display the region id, the region name and the number of warehouses
--      in your result.
--  - Sort the result by the region id.
--  REGION_ID | Region Name | Number of Warehouses
-- This query returns 2 rows.
COLUMN region_name FORMAT A15;
SELECT
    r.region_id AS "REGION_ID",
    r.region_name "REGION_NAME",
    COUNT(w.warehouse_id) AS "Number of Warehouses"
FROM regions r
    JOIN countries c ON r.region_id = c.region_id
    JOIN locations l ON c.country_id = l.country_id
    JOIN warehouses w ON l.location_id = w.location_id
GROUP BY r.region_id, r.region_name
ORDER BY r.region_id;