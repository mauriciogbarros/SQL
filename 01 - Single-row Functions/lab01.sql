-- 1. 
-- Write a query to display tomorrow's date in the following format:
--      September 16th of year 2022
-- the result will depend on the day when you RUN/EXECUTE this query.
-- Label the column Tomorrow
SELECT TO_CHAR(SYSDATE + 1, 'fmMonth ddth "of year" yyyy') AS "Tomorrow"
FROM dual;

-- 2.
-- For each product in category 5 that its list_price is less than $100 and
-- greater than 85, show product ID, product name, list price, and the new list
-- price increased by 5%. Display a new list price as a whole number (integer).
-- In your result, add a calculated column to show the difference of old and
-- new prices. Name this column as Price Difference.
-- The query returns 5 rows.
-- Sor the result according to product ID.
SELECT 
    product_id AS "Product ID",
    product_name AS "Product Name",
    list_price AS "List Price",
    ROUND(list_price*1.05) AS "New List Price",
    (ROUND(list_price*1.05) - list_price) AS "Price Difference"
FROM products
WHERE list_price > 85 AND list_price < 100
ORDER BY product_id;
    
-- 3.
-- Write a query that displays the full name and job title of the manager for
-- employees whose job title is "Finance Manager" in the following format:
-- Jude Rivera works as Administration Vice President.
-- The query returns 1 row.
-- Sort the result based on employee ID.
SELECT 
    first_name || ' ' || last_name || ' works as ' || job_title AS "Full Name and Job Title"
FROM employees
WHERE job_title = 'Finance Manager'
ORDER BY employee_id;

-- 4.
-- For employees hired in November 2016, display the employee's last name, hire
-- date and calculate the number of months between the current date and the date
-- the employee has hired, considering that if an employee worked over half of
-- a month, it should be counted as one month.
-- Label the column Months Worked.
-- The query returns 5 rows.
-- Sort the result first based on the hire date column and then based on the
-- employee's last name.
SELECT
    last_name as "Last Name",
    hire_date as "Hire Date", 
    ROUND(MONTHS_BETWEEN(sysdate, hire_date)) AS "Months Worked"
FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = 11 AND EXTRACT(YEAR FROM hire_date) = 2016
ORDER BY hire_date, last_name;

-- 5.
-- Display each employee's last name, hire date, and the review date, which is
-- first Friday after five months of service. Show the result only for those
-- hired before January 20, 2016.
--  1. Label the column REVIEW DATE.
--  2. Format the dates to appear in the format like:
--      i. TUESDAY, January the Thirty-First of year 2016.
--      ii. You can use ddspth to have the above format for the day.
--  3. Sort first by review date and then by last name.
-- The query returns 6 rows.
SELECT
    last_name AS "Last Name",
    TO_CHAR(hire_date, 'fmDay') || ', ' || TO_CHAR(hire_date, 'fmMonth" the "Ddspth" of year "yyyy') AS "Hire Date",
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 5), 'Friday'), 'fmDay') || ', ' || TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 5), 'Friday'), 'fmMonth" the "Ddspth" of year "yyyy') AS "Review Date"
FROM employees
WHERE hire_date < TO_DATE('20-01-2016', 'DD-MM-YYYY')
ORDER BY NEXT_DAY(ADD_MONTHS(hire_date, 5), 'Friday'), last_name;

-- 6.
-- For all warehouses, display warehouse id, warehouse name, city, and state.
-- For warehouses with the null value for the state column, display "unknown".
-- Sort the result based on the warehouse ID.
-- The query returns 9 rows.
SELECT
    w.warehouse_id AS "Warehouse ID",
    w.warehouse_name AS "Warehouse Name",
    l.city AS "City",
    l.state AS "State"
FROM warehouses w
    INNER JOIN locations l
        ON w.location_id = l.location_id
ORDER BY w.warehouse_id;