-- find all customers that their credit limit is over 2000
select *
from customers
where credit_limit > 2000;

-- How many customers do exist with credit limit over 2000
select count(*)
from customers
where credit_limit > 2000;

-- Dislay all customers with credit limit greater than the credit limit of customer 275
select credit_limit -- 3500
from customers
where customer_id = 275;

select customer_id, credit_limit
from customers
where credit_limit > 3500
order by credit_limit desc;

-- Find the number of customers with credit limit greater than the credit limit of customer 275
select count(*)
from customers
where credit_limit > 3500
order by credit_limit desc;

-- Using SUBQUERIES
select customer_id, credit_limit
from customers
where credit_limit > (select credit_limit -- 3500
                        from customers
                        where customer_id = 275)
order by credit_limit desc;

-- Dislay all customers with credit limit less than the credit limit of customer 275
select customer_id, credit_limit
from customers
where credit_limit < (select credit_limit -- 3500
                        from customers
                        where customer_id = 275)
order by credit_limit desc;

-- Find all employees who work for the manager that employee 106 also work for
-- Exclude employee 106
select manager_id -- 2
from employees
where employee_id = 106;

select *
from employees 
where manager_id = 2
    and employee_id <> 106;
    
-- USE SUBQUERIES
-- The subquery returns a single value
select *
from employees 
where manager_id = (select manager_id -- 2
                    from employees
                    where employee_id = 106)
    and employee_id <> 106;
    
-- How many employees work for the same manager as employee 106
select count(*)
from employees 
where manager_id = (select manager_id -- 2
                    from employees
                    where employee_id = 106)
    and employee_id <> 106;
    
-- For each category find the number of products
select category_id, count(*), sum(list_price)
from products
group by category_id
order by count(*);

-- Display categories that their number of products is less than 70
select category_id, count(*) as "Number of Products"
from products
group by category_id
having count(*) < 70
order by "Number of Products";

-- Display categories that their number of products for the categories that their number of products is
-- greater than the number of products in category 4
select count(*)
from products
where category_id = 4;

select category_id, count(*) as "Number of Products"
from products
group by category_id
having count(*) > 60;

-- USING SUBQUERIES
select category_id, count(*) as "Number of Products"
from products
group by category_id
having count(*) > (select count(*)
                    from products
                    where category_id = 4);

-- Display categories that their total list price is
-- greater than the total list price of category 4
select sum(list_price) -- 24137.59
from products
where category_id = 4;

select category_id, sum(list_price)
from products 
group by category_id
having sum(list_price) > 24137.59;


-- USING SUBQUERIES
select category_id, sum(list_price) as "Total List Price"
from products
group by category_id
having sum(list_price) > (select sum(list_price)
                            from products
                            where category_id = 4);
                            
-- Display categories that their total list price is
-- greater than the total list price of category 4 and the their number of products is less than the number of
-- products in category 4

select category_id, sum(list_price) as "Total List Price", count(*) as "Total Number of Products"
from products
group by category_id
having sum(list_price) > (select sum(list_price)
                            from products
                            where category_id = 4)
    and count(*) < (select count(*)
                            from products
                            where category_id = 4);
                            
-- For each manager display the number of employees who work for that manager
-- To find the manager ID
select manager_id, count(*)
from employees
where manager_id is not null
group by manager_id
order by manager_id;


-- Display managers and their numbre of employees with number of employees greater than 8
select manager_id, count(*) as "Number of Employees"
from employees
where manager_id is not null
group by manager_id
having count(*) > 6
order by manager_id;

-- Display managers and their numbre of employees with number of employees greater than the number of employees
-- who work for manager 48
select count(*) as "Number of Employees" -- 6
from employees
where manager_id = 48;

select manager_id, count(*) as "Number of Employees"
from employees
where manager_id is not null
group by manager_id
having count(*) > (select count(*) as "Number of Employees" -- 6
                    from employees
                    where manager_id = 48)
order by manager_id;

-- The subquery returns a single value
-- So we can use relational operators: <    >   <=  >=  =   <>  !=

-- What if the subquery returns multiple values
-- We cannot use: <    >   <=  >=  =   <>  !=
-- We can use the relationsl operators following by 
-- ALL ANY
select credit_limit 
from customers
where customer_id = 48 or customer_id = 100 or customer_id = 2;

select credit_limit 
from customers
where customer_id in (48, 100, 2);

-- show the customers if their credit limit is greater than the credit limit of customers 48, 100, and 2

-- 100
-- 600
-- 1400

select customer_id, credit_limit
from customers
where credit_limit > all (select credit_limit 
                        from customers
                        where customer_id in (48, 100, 2));
                        
select count(*)
from customers
where credit_limit > all (select credit_limit 
                        from customers
                        where customer_id in (48, 100, 2));
                        
-- show the customers if their credit limit is less than the credit limit of customers 48, 100, and 2                     
select customer_id, credit_limit
from customers
where credit_limit < all (select credit_limit 
                        from customers
                        where customer_id in (48, 100, 2)); 
                        
-- Display employees who have been hired after employees 106, 10,14
select hire_date
from employees
where employee_id in (106,10,14);

-- 16-AUG-16
-- 07-DEC-16
-- 07-JUN-16

select employee_id, hire_date
from employees
where hire_date > all (select hire_date
                        from employees
                         where employee_id in (106,10,14));

-- Display employees who have been hired before employees 106, 10,14

select employee_id, hire_date
from employees
where hire_date < all (select hire_date
                        from employees
                         where employee_id in (106,10,14));

-- Display employees who have been hired after one of the employees 106, 10,14
select employee_id, hire_date
from employees
where hire_date > any (select hire_date
                        from employees
                         where employee_id in (106,10,14));
                         
-- Display employees who have been hired before one of the employees 106, 10,14
select employee_id, hire_date
from employees
where hire_date < any (select hire_date
                        from employees
                         where employee_id in (106,10,14));
                         
-- Display employees who have been hired in the same day that employees 106, 10, or 14 were hired
-- Exclude employees 106, 10, 14
-- 16-AUG-16
-- 07-DEC-16
-- 07-JUN-16
select employee_id, hire_date
from employees
where hire_date = any (select hire_date
                        from employees
                         where employee_id in (106,10,14))
        and employee_id not in (106,10,14);
-- You can write the above query using the IN operator
select employee_id, hire_date
from employees
where hire_date in (select hire_date
                        from employees
                         where employee_id in (106,10,14))
        and employee_id not in (106,10,14);
-- (= any) is the same as IN
-- Display employees who have not been hired in the same day that employees 106, 10, or 14 were hired
-- Exclude employees 106, 10, 14
-- 16-AUG-16
-- 07-DEC-16
select employee_id, hire_date
from employees
where hire_date not in (select hire_date
                        from employees
                         where employee_id in (106,10,14))
        and employee_id not in (106,10,14);
        
-- OR
select employee_id, hire_date
from employees
where hire_date <> all (select hire_date
                        from employees
                         where employee_id in (106,10,14))
        and employee_id not in (106,10,14);