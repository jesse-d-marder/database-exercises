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

# 8 - Any duplicates? STILL WORKING ON THIS ONE!!!
SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),"_",SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username, COUNT(*)
FROM employees
GROUP BY username;