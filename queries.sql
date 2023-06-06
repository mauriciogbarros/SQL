-- 1.
SELECT
    employees.employeeNumber,
    employees.firstName,
    employees.lastName,
    offices.phone,
    employees.extension
FROM dbs211_employees employees
    JOIN dbs211_offices offices
        ON employees.officeCode = offices.officeCode
WHERE offices.City = 'San Francisco'
ORDER BY employees.employeeNumber;

-- 2.
SELECT DISTINCT
    managers.employeeNumber,
    managers.firstName,
    managers.lastName,
    offices.phone,
    managers.extension
FROM dbs211_employees managers
    JOIN dbs211_offices offices
        ON managers.officeCode = offices.officeCode
    JOIN dbs211_employees employees
        ON employees.reportsTo = managers.employeeNumber
ORDER BY managers.employeeNumber;

SELECT employees.employeeNumber, employees.firstName, employees.lastName, offices.phone, employees.extension FROM dbs211_employees employees JOIN dbs211_offices offices ON employees.officeCode = offices.officeCode WHERE offices.City = 'San Francisco' ORDER BY employees.employeeNumber;

SELECT DISTINCT managers.employeeNumber, managers.firstName, managers.lastName, offices.phone, managers.extension FROM dbs211_employees managers JOIN dbs211_offices offices ON managers.officeCode = offices.officeCode JOIN dbs211_employees employees ON employees.reportsTo = managers.employeeNumber ORDER BY managers.employeeNumber;