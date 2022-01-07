# Exercises from https://ds.codeup.com/sql/functions/

USE employees;

# 2 - Last name starts and ends with 'E'
SELECT emp_no, first_name, last_name, CONCAT(first_name," ", last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E';
# 899 employees returned

# 3 - Convert to Uppercase the full names of those whose last name starts and ends with 'E'
SELECT emp_no, first_name, last_name, UPPER(CONCAT(first_name," ", last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E';
	
# 4 - Employees hired in the 90s and born on Christmas
SELECT emp_no, first_name, last_name, hire_date, datediff(CURDATE(),hire_date) AS days_at_company
FROM employees
WHERE birth_date LIKE '%12-25'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';

# 5 Smallest and largest current salary from salaries
SELECT max(salary) AS Largest_salary, min(salary) AS Smallest_salary 
FROM salaries;
# highest salary is 158220 and lowest is 38623

/* 6 Username generation for all employees - 
	-all lowercase
	-first character of first name
	-first 4 characters if last name
	-_
	-month born
	-last two digits of year born
*/

SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),"_",SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username, first_name, last_name, birth_date
FROM employees;



