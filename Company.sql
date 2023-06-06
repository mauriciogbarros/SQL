CREATE TABLE customers
(
    customer_id INT,
    customer_name VARCHAR(50) NOT NULL, 
    email VARCHAR(50), 
    address VARCHAR(50),
    city VARCHAR(50), 
    province VARCHAR(2),
    postal_code VARCHAR(10),
    CONSTRAINT customer_id_PK
        PRIMARY KEY (customer_id)
);

CREATE TABLE orders
(
    order_id INT, 
    order_date DATE, 
    customer_id INT, 
    CONSTRAINT order_id_PK
        PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

CREATE TABLE product_lines
(
    product_line_id INT,
    product_name VARCHAR(50),                                                                                                                                                                                                                                                                                                                                                                                                                                         
    CONSTRAINT product_line_PK
        PRIMARY KEY (product_line_id)
);

CREATE TABLE products
(
    product_id INT,
    product_name VARCHAR (50),
    product_finish VARCHAR (50),
    price FLOAT,
    product_line_id NOT NULL,
    CONSTRAINT productd_id_PK
        PRIMARY KEY (product_id),
    FOREIGN KEY (product_line_id)
        REFERENCES product_lines (product_line_id)
);

CREATE TABLE order_lines
(
    order_id INT, 
    product_id INT, 
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);

CREATE TABLE workcenters 
(
    workcenter_id INT, 
    center_location VARCHAR(50), 
    center_field VARCHAR (50),
    CONSTRAINT workcenter_id_PK
        PRIMARY KEY (workcenter_id)
);

CREATE TABLE workcenter_products
(
    workcenter_id INT,
    product_id INT,
    PRIMARY KEY (product_id, workcenter_id),
    FOREIGN KEY (workcenter_id)
        REFERENCES workcenters (workcenter_id),
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);

/******************************************************************************
* Part III. Data Manipulation 
*******************************************************************************/
--*********** Enter Data 
-- In this section, write all SQL statements to insert data to your tables.
-- You write four INSERT statements.

/* CUSTOMERS */
INSERT ALL
    INTO customers VALUES (1,'Contemporary Casuals','NULL','1335 S Hines Blvd','Gainesville','FL','32601-2871')
    INTO customers VALUES (2,'Value Furniture','NULL','14512 S.W. 17th St.','Plano','TX','75094-7743')
    INTO customers VALUES (3,'Home Furnishing','NULL','1900 Allard Ave.','Albany','NY','12209-1233')
    INTO customers VALUES (4,'Easter Furniture','NULL','1925 Beltline Rd.','Carteret','NJ','07008-1231')
    INTO customers VALUES (5,'Impressions','NULL','5585 Westcott Ct.','Sacramento','CA','94206-4056')
    INTO customers VALUES (6,'Furniture Gallery','NULL','325 Flatiron Dr.','Boulder','CO','80514-2254')
    INTO customers VALUES (7,'Period Furniture','NULL','394 Rainbow Dr.','Seattle','WA','97989-5648')
    INTO customers VALUES (8,'California Classics','NULL','816 Peach Rd.','Santa Clara','CA','16915-7712')
    INTO customers VALUES (9,'M and H Casual','NULL','5585 South Ct.','Gainesville','FL','12601-2873')
    INTO customers VALUES (10,'Seminole Interior','NULL','3225 Flatiron Cir.','Plano','TX','25094-7746')
    INTO customers VALUES (11,'American Euro Furniture','NULL','5585 Eastcott Ct.','Albany','NY','42209-1235')
    INTO customers VALUES (12,'Battle Creek Furniture','NULL','325 Flatry Dr.','Carteret','NJ','67508-1235')
    INTO customers VALUES (13,'Heritage Furniture','NULL','5523 Fleming Dr.','Sacramento','CA','84206-4055')
    INTO customers VALUES (14,'Kaneohe Homes','NULL','3215 Glatiron Dr.','Boulder','CO','80514-2254')
    INTO customers VALUES (15,'Mountain Schemes','NULL','455 Westgreen Dr.','Seattle','WA','22989-5748')
    SELECT * FROM dual;
SELECT * FROM customers;

/* ORDERS */
INSERT ALL
    INTO orders VALUES (1001,to_date('1-21-2019','mm-dd-yyyy'),1)
    INTO orders VALUES (1002,to_date('1-22-2019','mm-dd-yyyy'),8)
    INTO orders VALUES (1003,to_date('1-24-2019','mm-dd-yyyy'),15)
    INTO orders VALUES (1004,to_date('1-21-2019','mm-dd-yyyy'),5)
    INTO orders VALUES (1005,to_date('1-25-2019','mm-dd-yyyy'),3)
    INTO orders VALUES (1006,to_date('1-27-2019','mm-dd-yyyy'),2)
    INTO orders VALUES (1007,to_date('2-11-2019','mm-dd-yyyy'),11)
    INTO orders VALUES (1008,to_date('2-11-2019','mm-dd-yyyy'),12)
    INTO orders VALUES (1009,to_date('2-27-2019','mm-dd-yyyy'),4)
    INTO orders VALUES (1010,to_date('2-25-2019','mm-dd-yyyy'),1)
    SELECT * FROM dual;
SELECT * FROM orders;

/* PRODUCT LINES */
INSERT ALL
    INTO product_lines VALUES(1,'Product Line 1')
    INTO product_lines VALUES(2,'Product Line 2')
    INTO product_lines VALUES(3,'Product Line 3')
    SELECT * FROM dual;
SELECT * FROM product_lines;

/* PRODUCTS */
INSERT ALL
    INTO products VALUES(1,'End Table','Cherry',175,1)
    INTO products VALUES(2,'Coffee Table','Natural Ash',170,2)
    INTO products VALUES(3,'Computer Desk','Natural Ash',435,2)
    INTO products VALUES(4,'Entertainment Centre','Natural Maple',735,3)
    INTO products VALUES(5,'Writers Desk','Cherry',540,1)
    INTO products VALUES(6,'8-Drawer Desk','White Ash',800,2)
    INTO products VALUES(7,'Dining Table','Natural Ash',500,2)
    INTO products VALUES(8,'Computer Desk','Walnut',250,3)
    SELECT * FROM dual;
SELECT * FROM products;

/* ORDER LINES */
INSERT ALL
    INTO order_lines VALUES(1001,1,2)
    INTO order_lines VALUES(1001,2,3)
    INTO order_lines VALUES(1001,3,4)
    INTO order_lines VALUES(1002,4,5)
    INTO order_lines VALUES(1003,3,1)
    INTO order_lines VALUES(1004,3,2)
    INTO order_lines VALUES(1005,6,3)
    INTO order_lines VALUES(1006,8,4)
    INTO order_lines VALUES(1006,4,5)
    INTO order_lines VALUES(1006,6,1)
    INTO order_lines VALUES(1007,5,2)
    INTO order_lines VALUES(1007,7,3)
    INTO order_lines VALUES(1008,1,4)
    INTO order_lines VALUES(1008,2,5)
    INTO order_lines VALUES(1009,3,12)
    INTO order_lines VALUES(1009,8,1)
    INTO order_lines VALUES(1010,4,3)
    SELECT * FROM dual;
SELECT * FROM order_lines;

--*********** UPDATE AND LIST DATA 
-- In this section, write queries to update ot list data based on the project 
-- instruction. 
-- You write one UPDATE and three SELECT statements.
/*
1.	Write a SQL query to change the standard price of product with product ID 2 
    to 7 and increase their standard price by 100.
    (Product IDs 2 and 7 are not included.)
*/
SELECT *
    FROM products
    WHERE product_id = 2 OR product_id = 7;
    
UPDATE products
    SET price = price + 100
    WHERE product_id = 2 OR product_id = 7;

SELECT *
    FROM products
    WHERE product_id = 2 OR product_id = 7;

/*
2.	Write a SQL query to show product ID, product name, and product line of 
    products that are not in product lines 1 and 3. Sort the result first by
    product line and then by product ID.
*/
SELECT
        product_id AS "Product ID",
        product_name AS "Product Name",
        product_line_id AS "Product Line"
    FROM products
    WHERE product_line_id <> 1 AND product_line_id <> 3
    ORDER BY product_line_id, product_id;

/*
3.	Write a SQL statement to show all customers whose city name starts with ‘s’ 
    and includes ‘t’. Sort the result by customer ID.  
*/
SELECT
    *
    FROM customers
    WHERE LOWER(city) LIKE 's%t%'
    ORDER BY customer_id;

/*
4.	Write a SQL query to show product ID, standard price, and a new column named
    list price. To calculate the column list price, increase the standard price 
    by 10 percent for every product.
*/
SELECT
    *
    FROM products;

ALTER TABLE products
    ADD list_price FLOAT;

UPDATE products
    SET list_price = price * 1.1;

SELECT
    *
    FROM products;

/*
drop table workcenter_products;
drop table workcenters;
drop table order_lines;
drop table products;
drop table product_lines;
drop table orders;
drop table customers;
*/
