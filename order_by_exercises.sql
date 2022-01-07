# Exercises from https://ds.codeup.com/sql/order-by/

USE employees;

# 2 Specific first names using 'IN' and ordered by first name
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
ORDER BY first_name ASC;
# The first row is Irena Reutenauer
# The last row is Vidya Simmen

# 3 Specific first names and ordered by first and then last names
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
ORDER BY first_name ASC, last_name ASC;
# The first row is Irena Acton
# The last row is Vidya Zweizig

# 4 Specific first names and ordered by last and then first names
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
ORDER BY last_name ASC, first_name ASC;
# The first row is Irena Acton
# The last row is Maya Zyda

# 5 - Last name starts and ends with 'E', sorted by employee number
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E'
ORDER BY emp_no ASC;
# 899 employees returned
# First employee number is 10021 who is Ramzi Erde
# Last employee number is 499648 who is Tadahiro Erde

# 6 - Last name starts and ends with 'E', sorted by hire date, newest first
SELECT emp_no, first_name, last_name, hire_date, birth_date
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E'
ORDER BY hire_date DESC;
# 899 employees returned, newest employee is Teiji Eldridge, the longest employed is Sergi Erde
# 6 - Last name starts and ends with 'E', oldest employee
SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E'
ORDER BY birth_date ASC;
# Oldest employee is Piyush Erbe


# 7 - Employees hired in the 90s and born on Christmas, sorted by birth date and hire date
SELECT emp_no, first_name, last_name, hire_date, birth_date
FROM employees
WHERE birth_date LIKE '%12-25'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY birth_date ASC, hire_date DESC;
# 362 rows returned
# Oldest employee who was hired last is Khun Bernini
# Youngest employee who was hired first is Douadi Pettis



