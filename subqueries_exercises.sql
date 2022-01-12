# Exercises from https://ds.codeup.com/sql/subqueries/

USE employees;

# 1 - Find current employees with same hire data as employee 101010
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010) 
AND emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date>CURDATE()
	);
	
# 2 - Find all titles ever held by all current employees with first name Aamod
SELECT DISTINCT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod')
AND to_date> CURDATE();

# 3 - How many people in employees table no longer working for the company?
SELECT COUNT(emp_no)
FROM employees 
WHERE emp_no NOT IN (
	SELECT emp_no 
	FROM salaries 
	WHERE to_date>CURDATE()); # Removes those who are still at the company. If they don't have a salary with a to_date > CURDATE then they aren't at the company anymore. 
	
# Could also use dept_emp table
SELECT COUNT(emp_no)
FROM employees 
WHERE emp_no NOT IN (
	SELECT emp_no 
	FROM dept_emp
	WHERE to_date>CURDATE());	
	
# 59900 people no longer working for the company from employees

# 4 - Find all current department managers that are female
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (SELECT emp_no FROM dept_manager WHERE to_date>CURDATE()) AND
	gender = "F";
/*
Isamu	Legleitner
Karsten	Sigstam
Leon	DasSarma
Hilary	Kambil
*/

# 5 - Find all employees who currently have a higher salary than the company's overall, historical average salary
SELECT emp_no, salary
FROM salaries
WHERE (salary > (SELECT AVG(salary) FROM salaries) 
AND to_date>CURDATE());
# Returned 154,543 rows

SELECT AVG(salary)
FROM salaries; # Historical Average is 63810.7448

# 6 - How many current salaries are within 1 std of current highest salary? What % of all salaries is this?
SELECT COUNT(*) AS Within_1_STD,
100*COUNT(*)/(SELECT COUNT(*)
			FROM salaries
				WHERE to_date>CURDATE()) AS Pct_of_all_salaries
FROM salaries
WHERE to_date>CURDATE() AND
salary >= (
(SELECT MAX(salary)
	FROM salaries
		WHERE to_date>CURDATE())-
			(SELECT STD(salary)
				FROM salaries
					WHERE to_date>CURDATE()));
# 83 salaries within 1 STD of highest, which is	0.0346% of all salaries

# BONUS 1 - Find department names that currently have female managers

SELECT dept_name AS Female_Managed_Departments
FROM departments
WHERE dept_no IN (
SELECT dept_no
FROM dept_manager
WHERE to_date>CURDATE() AND
emp_no IN 
(SELECT emp_no
FROM employees
WHERE gender = 'F'));

# BONUS 2 - Find first and last name of employee with highest salary
SELECT first_name, last_name FROM employees
WHERE emp_no = (
SELECT emp_no
FROM salaries
WHERE salary = (SELECT MAX(salary) FROM salaries WHERE to_date>CURDATE()));

# BONUS 3 - Department name of the employee with highest salary
SELECT dept_name
FROM departments
WHERE dept_no = 
(SELECT dept_no FROM dept_emp 
WHERE to_date> CURDATE() AND
emp_no = (
SELECT emp_no
FROM salaries
WHERE 
salary = (SELECT MAX(salary) FROM salaries WHERE to_date>CURDATE())));