# Exercises from https://ds.codeup.com/sql/group-by/

USE employees;

# 2 - Distinct titles
SELECT count(DISTINCT title) AS unique_titles
FROM titles;
# There are 7 unique titles

# 3 - List all unique last names that start and end with 'E' using GROUP BY
SELECT DISTINCT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE 'E%E';
/*
Erde
Eldridge
Etalle
Erie
Erbe
*/

# 4 - Find all unique combinations of first and last names for employees whose last names start and end with 'E'
SELECT DISTINCT last_name, first_name
FROM employees
GROUP BY last_name, first_name
HAVING last_name LIKE 'E%E';
# 846 rows returned

# 5 - Find unique last names with a 'q' but not 'qu'
SELECT DISTINCT last_name
FROM employees
GROUP BY last_name
HAVING (last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%');
/* The names are: 
Chleq
Lindqvist
Qiwen
*/

# 6 - Find the number of employees with the same last name for each of the unique last names with a 'q' but not 'qu'

SELECT DISTINCT last_name, count(*)
FROM employees
GROUP BY last_name
HAVING (last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%');
/*
Chleq	189
Lindqvist	190
Qiwen	168
*/

# 7 - Find employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names

SELECT first_name, gender, COUNT(*) AS qty_emp
FROM employees
GROUP BY first_name, gender
HAVING first_name IN ('Irena','Vidya','Maya');

/*
Vidya	M	151
Irena	M	144
Irena	F	97
Maya	F	90
Vidya	F	81
Maya	M	146
*/

# 8 - Count of employees for each unique username. 

SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),"_",SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username, COUNT(*)
FROM employees
GROUP BY username;

# 8 - Any duplicates? 
SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),"_",SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username, COUNT(*)
FROM employees
GROUP BY username
HAVING COUNT(*)>1;
# Yes, there are duplicates. 13251 row are returned by this query so there are those many duplicate usernames

# 9 a - Avg Salary
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no;

# 9 b - Current employees in each department
SELECT dept_no, COUNT(*)
FROM dept_emp
GROUP BY dept_no;

# 9 c - How many salaries per employee
SELECT emp_no, COUNT(salary)
FROM salaries
GROUP BY emp_no;

# 9 d - Max salary for each employee
SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no;

# 9 e - Min salary for each employee
SELECT emp_no, MIN(salary)
FROM salaries
GROUP BY emp_no;

# 9 f - Standard deviation of salary for each employee
SELECT emp_no, STD(salary)
FROM salaries
GROUP BY emp_no;

# 9 g - Max salary for each employee where max is > $150k
SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no
HAVING MAX(salary)>150000;

# 9 h - Average salary for each employee where avg is between $80-90k
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) BETWEEN 80000 AND 90000;

