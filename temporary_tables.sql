# Exercises from https://ds.codeup.com/sql/temporary-tables/

-- Use the read_only database
-- This avoids needing to re-type the db_name in front of every table_name
USE employees;

-- Specify the db where you have permissions and add the temp table name.
-- Replace "my_database_with_permissions"" with the database name where you have appropriate permissions. It should match your username.

# 1 - Create the temporary table
CREATE TEMPORARY TABLE innis_1659.employees_with_departments AS 
SELECT first_name, last_name, dept_name FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no);

-- Change the current db.
USE innis_1659;

SELECT * FROM employees_with_departments;

# 1 a - Add full name column as VARCHAR. Length is sum of lengths of first and last names

ALTER TABLE employees_with_departments ADD full_name VARCHAR (30);

# 1 b - Update table so full name column contains correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

# 1 c - Remove first and last name columns
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
USE innis_1659;

SELECT * FROM employees_with_departments;
# 1 d - Another way to get same table
USE employees;
SELECT CONCAT(first_name, ' ', last_name), dept_name
FROM employees
JOIN dept_emp
	USING (emp_no)
JOIN departments
	USING (dept_no);
	
# 2 - create temporary table based on payment table from sakila database. 
USE sakila;
SELECT * FROM payment;

USE innis_1659;

CREATE TEMPORARY TABLE innis_1659.sakila_cents AS 
SELECT * FROM sakila.payment;

SELECT * FROM sakila_cents;

# Transform amount column such that it is stored as an integer representing the number of cents of payment
ALTER TABLE sakila_cents ADD cents INT;
UPDATE sakila_cents
SET cents = 100*amount;

ALTER TABLE sakila_cents DROP COLUMN amount;
ALTER TABLE sakila_cents ADD amount INT;
UPDATE sakila_cents
SET amount = cents;
ALTER TABLE sakila_cents DROP column cents;

SELECT * FROM sakila_cents;

# 3 - How does current average pay in each department compare to overall, historical average pay? Use z-score for salaries. Which department is best/worst?
USE innis_1659;
USE employees;

# Creates table with current department average
CREATE TEMPORARY TABLE innis_1659.employee_cur_avg AS 
SELECT AVG(salary) AS cur_dept_avg_salary, dept_name
FROM salaries
JOIN dept_emp
	USING (emp_no)
JOIN departments
	USING (dept_no)
WHERE salaries.to_date>NOW() AND
	dept_emp.to_date>NOW()
GROUP BY dept_name;

# Performing zscore calculation
SELECT dept_name, (cur_dept_avg_salary-(SELECT AVG(salary) FROM salaries))/(SELECT STDDEV(salary) FROM salaries) AS zscore
FROM innis_1659.employee_cur_avg
ORDER BY zscore DESC;
# Sales has top zscore of 1.48, human resources has zscore of 0.0066, so Sales is furthest from historical average and human resources is closest

### OTHER ATTEMPTS #####

# Compares current department average to historical department average
SELECT dept_name, hist_dept_avg_salary, hist_dept_std_salary, cur_dept_avg_salary,
(cur_dept_avg_salary-hist_dept_avg_salary)/hist_dept_std_salary AS zscore  
FROM
(SELECT AVG(salary) AS hist_dept_avg_salary, STDDEV(salary) AS hist_dept_std_salary, dept_name
FROM salaries
JOIN dept_emp
	USING (emp_no)
JOIN departments
	USING (dept_no)
GROUP BY dept_name) as hist
JOIN innis_1659.employee_cur_avg
USING (dept_name)
ORDER BY zscore DESC;
# Best to work in Human Resources now as it's got highest zscore of 0.68, worst to work in Sales where zscore is 0.47

# Another way
USE innis_1659;
USE employees;

SELECT dept_name, (cur_dept_avg_salary-hist_avg)/hist_std AS zscore FROM
(SELECT dept_name, cur_dept_avg_salary, AVG(salary) AS hist_avg, STDDEV(salary) AS hist_std
FROM innis_1659.employee_cur_avg
JOIN departments
	USING (dept_name)
JOIN dept_emp
	USING (dept_no)
JOIN salaries
	USING (emp_no)
GROUP BY dept_name, cur_dept_avg_salary)
 as alldata
 ORDER BY zscore DESC;

