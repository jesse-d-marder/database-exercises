# Exercises from https://ds.codeup.com/sql/where/

USE employees;

# 2 Specific first names using 'IN'
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya');
# 709 records returned

# 3 Specific first names using 'OR'
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya';
# 709 records returned, matching Q2

# 4 Specific first names using 'OR' and male
SELECT emp_no, first_name, last_name
FROM employees
WHERE (first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya')
	AND gender = 'M';
# 441 records returned

# 5 - Last name starts with E
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%';
# 7330 rows returned

# 6 - Last name starts or ends with 'E'
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%'
	OR last_name LIKE '%E';
# 30723 rows returned. 30723 - 7330 = 23393 employess have a last name that ends with 'E' but does not start with 'E'

# 7 - Last name starts and ends with 'E'
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E';
# 899 rows returned. 

# Last names end with E
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%E';
# 24292 rows returned

# 8 Employees hired in the 90s
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date ASC;
# 135214 rows returned

# 9 Employees born on Christmas
SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE birth_date LIKE '%12-25';
# 842 rows returned

# 10 Employees hired in the 90s and born on Christmas
SELECT emp_no, first_name, last_name, hire_date, birth_date
FROM employees
WHERE birth_date LIKE '%12-25'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';
# 362 rows returned

# 11 Employees with 'q' in last name
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%q%';
# 1873 rows returned

# 12 Employees with 'q' in last name but not 'qu'
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';
# 547 employees


