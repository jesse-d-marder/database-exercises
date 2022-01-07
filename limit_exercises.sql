# Exercises from https://ds.codeup.com/sql/limit/

USE employees;

# 2 - List first 10 distinct last names sorted in descending order
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

# 3 Employees hired in 90s and born on Christmas, first 5 employees
SELECT last_name, first_name
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date LIKE '%12-25'
ORDER BY hire_date ASC
LIMIT 5;
/* 
First 5 employees:
Cappello	Alselm
Mandell	Utz
Schreiter	Bouchung
Kushner	Baocai
Stroustrup	Petter
*/

# 4 10th page of results from 3
SELECT last_name, first_name
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date LIKE '%12-25'
ORDER BY hire_date ASC
LIMIT 5
OFFSET 45;
/* The relationship between OFFSET, LIMIT, and page number (assuming first n results are page 1) is page number = (OFFSET/LIMIT)+1, or OFFSET = LIMIT * (page number - 1)

The 10th page of results:
Narwekar	Pranay
Farrow	Marjo
Karcich	Ennio
Lubachevsky	Dines
Fontan	Ipke
*/
