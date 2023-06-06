----------------------------------------------------------------------------------------------------------
--Course: DBS311
-- Fall 2022
-- Sample SQL SELECT statements (Single-row Functions)
------------------------------------------------------------------

-- lower upper

select first_name, lower(first_name) as "Lower Case First Name", last_name, upper(last_name)
from employees;

-- initCap

select initcap(category_name)
from product_categories;

select email, initcap(email) as "New Email"
from employees;

--concat

select first_name || ', ' || last_name as "Employee Name"
from employees;

select concat(concat(last_name, ', '),first_name)
from employees;

select concat(concat(first_name, ', '), last_name)
from employees;

select first_name ||  ', ' || last_name
from employees;

select 'Contact Name:' || concat(concat(first_name, ' '),last_name) 
from contacts;

-- substr

select first_name, last_name
from employees
where first_name like 'Summer'; -- it has to be 'Summer'

select *
from employees
where lower(first_name) like '%t%';


-- length

select distinct length(job_title) as "Job Length"
from employees
where length(job_title) > 10
order by length(job_title) desc;

select distinct length(job_title) as "Job Length"
from employees
where length(job_title) > 10
order by "Job Length" desc;

select product_name, length(product_name) as "Length of Name"
from products
order by length(product_name);

select first_name, length(first_name) as "First Name Length"
from contacts
where length(first_name) > 6
order by length(first_name);

select first_name, length(first_name) as "First Name Length"
from contacts
where length(first_name) > 3 and length(first_name) < 6
order by "First Name Length";

select first_name, length(first_name) as "First Name Length"
from contacts
where length(first_name) between 3 and 6
order by "First Name Length";

-- instr

select instr('Hello world!', 'o')
from dual;

select product_name, instr(product_name, 't')
from products;

select product_name, instr(product_name, 't')
from products
where instr(product_name, 't') > 0;

select product_name, instr(product_name, ' ')
from products;

select first_name, instr(first_name, 'w') as "With w"
from contacts
where instr(first_name, 'w') > 1
order by "With w";

select first_name, instr(first_name, ' ') as "With space"
from contacts
where instr(first_name, ' ') > 1
order by "With space";

-- find products that have sapce character in their product name
select product_name, instr(product_name, ' ') as "With space"
from products
where instr(product_name, ' ') > 1
order by "With space";

-- Find products that do not have space character in their names
select product_name, instr(product_name, ' ') as "With space"
from products
where instr(product_name, ' ') = 0
order by "With space";


-- lpad, rpad

select first_name, lpad(first_name, 20, '*')
from contacts;

select first_name, lpad(first_name, 20, '$')
from contacts;

select first_name, lpad(first_name, 20, ' ')
from contacts;

select first_name, rpad(first_name, 30, '*')
from contacts;

-- replace
select first_name, replace(first_name, 's', '$')
from contacts
where first_name like '%s%'; -- instr(first_name, 's') > 0

select first_name, replace(lower(first_name), 's', '$')
from contacts
where lower(first_name) like '%s%';


-- trim

select first_name, trim('T' from first_name)
from contacts
where first_name like 'T%';

select first_name, '$' || trim('S' from first_name)
from contacts
where first_name like 'S%';


-- NUMERIC
--trunc 
select trunc(4.35)
from dual;
select trunc(4.65)
from dual;
select round(4.35,1)
from dual;
select trunc(4.31,1)
from dual;
select trunc(4.315,2)
from dual;
select trunc(4.365,2)
from dual;
select trunc(4.35)
from dual;
select trunc(2.352, 0)
from dual;

--round
select round(4.65)
from dual;
select round(4.35,1)
from dual;
select round(4.31,1)
from dual;
select round(4.315,2)
from dual;
select round(4.365,2)
from dual;
select round(list_price / 3,2)
from products;

select product_id, product_name, list_price, 
    list_price * 1.01 as "New Price",
    round(list_price * 1.01, 2) as "Rounded"
from products;

select round(2.552, 0)
from dual;


--mod
select mod(4,3)
from dual;

select mod(10,2)
from dual;

select employee_id, mod(employee_id, 2)
from employees;


-- NULL nvl, nvl2

select employee_id, last_name, nvl(manager_id,9999)
from employees
where manager_id is null;

select * 
from employees
where manager_id is null;


select city, nvl(state, 'unkmown') as "State"
from locations;

select city, state, nvl2(state, 'state is known', 'state is unknown')
from locations;

select city, state, nvl2(state, '1', 0)
from locations;

select city, state, nvl2(state, 1, 'unknown')
from locations; -- error occurs as no implicittly convert from 'unknow' to a number

-- coalesce

select city, state, coalesce(state,city,'unknow')
from locations;

select product_id, list_price, coalesce(list_price,standard_cost*1.1,5) as sale_price
from products
where category_id = 1
order by product_id;

select * from locations;


-- Functions for datetime

--Date Type Data
select employee_id, hire_date from employees;

-- system settings
select * from v$NLS_PARAMETERS;
select * from v$NLS_PARAMETERS WHERE parameter='NLS_DATE_FORMAT';

-- specify a DATE value
select DATE '2098-05-13' from dual;
select to_char(DATE '2098-05-13','yyyy-mm-dd') from dual;

select to_date('2098-DEC-25 17:30','YYYY-MON-DD HH24:MI') from dual;
select to_char(to_date('2098-DEC-25 17:30','YYYY-MON-DD HH24:MI'),'yyyy-mon-dd hh:mi') from dual;

-- datetime format elements p2-72 ~ p2-75


-- sysdate
select sysdate from dual;
select to_char(sysdate,'yyyy-mon-dd hh24:mi:ss') as now from dual;

SELECT SYSTIMESTAMP FROM DUAL;

select sysdate, current_date + 30 
from dual;

-- simple calculation
select employee_id, (sysdate - hire_date) / 7 as "Weeks"
from employees;

select employee_id, trunc((sysdate - hire_date) / 7,0) as "Weeks"
from employees
order by "Weeks";

-- ADD_MONTHS
select hire_date, add_months(hire_date, 1)
from employees;

-- CURRENT_DATE
select add_months(current_date,2) 
from dual;

-- current_timestamp
select current_timestamp
from dual;

-- EXTRACT
select extract (year from current_date)
from dual;

select extract (month from current_date)
from dual;

select extract (day from current_date)
from dual;

-- LAST_DAY
select last_day(current_date)
from dual;

select employee_id, hire_date, last_day(hire_date)
from employees;


-- Days between

select employee_id, trunc(current_date - hire_date)
from employees;

-- ROUND and TRUNC
select round(sysdate, 'MONTH')
from dual;

select round(sysdate, 'YEAR')
from dual;

-- TRUC
select trunc(sysdate, 'MONTH')
from dual;

select trunc(sysdate, 'MONTH')
from dual;

-- MONTHS_BETWEEN
select trunc(months_between(current_date , hire_date),0)
from employees;

-- NEXT_DAY
select next_day(current_date, 'Friday')
from dual;


-- TO_CHAR
SELECT  employee_id,
        hire_date,
        MONTHS_BETWEEN (SYSDATE, hire_date) "Seniority",
        ADD_MONTHS (hire_date, 6) "Review Date",
        NEXT_DAY (hire_date, 'Friday'),
        LAST_DAY (hire_date)
FROM    employees
WHERE   MONTHS_BETWEEN (SYSDATE, hire_date) > 70;

-- 
select last_name, hire_date,
    TO_CHAR (hire_date, 'YYYY-Month-DD')
from employees;

select last_name, hire_date,
    TO_CHAR (hire_date, 'fmYYYY-Month-DD')
from employees;

SELECT EMPLOYEE_ID,TO_CHAR (HIRE_DATE, 'MM/YY') Month_Hired
FROM EMPLOYEES
WHERE LAST_NAME like 'H%';

-- 
SELECT EMPLOYEE_ID,TO_CHAR (HIRE_DATE, 'fm   MM/DD/YY') HireDate
FROM EMPLOYEES 
WHERE LAST_NAME like 'H%';

SELECT EMPLOYEE_ID,TO_CHAR (HIRE_DATE, 'MM/DD/YY') HireDate
FROM EMPLOYEES 
WHERE LAST_NAME like 'H%';

-- MONTH
select to_char(sysdate, 'MONTH')
from dual;

select to_char(hire_date, 'MON')
from employees;

select to_char(hire_date, 'MONTH')
from employees;

select to_char(sysdate + 90, 'MON')
from dual;

select to_char(sysdate, 'DAY')
from dual;

select to_char(sysdate, 'WW') || 'th week of the year'
from dual;

select to_char(sysdate, 'W') || 'th week of the month'
from dual;

select to_char(sysdate, 'DD "of" MONTH')
from dual;

select to_char(sysdate + 1, 'ddspth "of" MONTH')
from dual;

select to_char(sysdate + 20, 'ddspth "of" MONTH')
from dual;

select sysdate,to_char(sysdate + 10, 'DD-MONTH-YYYY')
from dual;
select to_char(sysdate + 10, 'FMDD-MONTH-YYYY')
from dual;


SELECT last_name,TO_CHAR(sysdate, 'Ddspth "of" Month  YYYY   HH:MI')
FROM employees;

SELECT product_name, TO_CHAR(list_price, '$999,999,999.00') as price
FROM products;

select to_number('1234') - 2
from dual;

-- TO_DATE
select current_date, to_date('09-01-2020', 'DD-MM-YYYY')
from dual;

select employee_id, hire_date
from employees
where hire_date > to_date('09-SEP-16', 'DD-MON-YY');

select employee_id, hire_date
from employees
where hire_date > '09-SEP-16';

SELECT last_name, hire_date
from employees
where hire_date = to_date('May 24, 2016', 'Month DD, YYYY');










