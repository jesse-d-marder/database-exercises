# Exercises from https://ds.codeup.com/sql/joins/

USE join_example_db;

SELECT *
FROM roles;

SELECT *
FROM users;

# JOIN practice

SELECT *
FROM users
JOIN roles
ON users.role_id = roles.id;

# LEFT JOIN practice

SELECT *
FROM users
LEFT JOIN roles
ON users.role_id = roles.id;

# RIGHT JOIN practice

SELECT *
FROM users
RIGHT JOIN roles
ON roles.id = users.role_id;

# 3 - Practice with aggregate functions - number of users per role
SELECT roles.name AS role_name, COUNT(*) as Num_Users
FROM roles
JOIN users
ON users.role_id = roles.id
GROUP BY role_name;
/*
admin	1
author	1
reviewer	2
*/
### --- Employees Database Section

USE employees;

# 2 - Show department manager for each department
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager"
FROM employees AS e
JOIN dept_emp AS de
ON de.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = de.dept_no
JOIN dept_manager AS dm
ON dm.emp_no = e.emp_no
WHERE dm.to_date LIKE '99%'
ORDER BY Department_Name ASC;

# 3 - Find name of all departments managed by women
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager"
FROM employees AS e
JOIN dept_emp AS de
ON de.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = de.dept_no
JOIN dept_manager AS dm
ON dm.emp_no = e.emp_no
WHERE dm.to_date LIKE '99%' AND
		e.gender = "F"
ORDER BY Department_Name ASC;


# 4 - Titles of those currently in working in Customer Service

SELECT t.title, COUNT(*)
FROM titles as t
JOIN employees as e
ON e.emp_no = t.emp_no
JOIN dept_emp as de
ON de.emp_no = e.emp_no
JOIN departments as d
ON d.dept_no = de.dept_no
WHERE d.dept_name = "Customer Service"
	AND de.to_date LIKE '99%'
	AND t.to_date LIKE '99%'
GROUP BY t.title
ORDER BY t.title ASC; 

# 5 - Find current salary of all current managers
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager", s.salary
FROM employees AS e
JOIN dept_emp AS de
ON de.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = de.dept_no
JOIN dept_manager AS dm
ON dm.emp_no = e.emp_no
JOIN salaries as s
ON s.emp_no = e.emp_no
WHERE dm.to_date LIKE '99%' AND
	s.to_date LIKE '99%'
ORDER BY Department_Name ASC;

# 6 - Find number of current employees in each department
SELECT d.dept_no, d.dept_name, COUNT(*) AS num_employees
FROM departments as d
JOIN dept_emp as de
ON de.dept_no = d.dept_no
GROUP BY de.dept_no, de.to_date
HAVING de.to_date LIKE '99%'
ORDER BY de.dept_no ASC;

# 7 - Which department has highest average salary (among current employees)

SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM departments as d
JOIN dept_emp as de
ON de.dept_no = d.dept_no
JOIN salaries as s
ON s.emp_no = de.emp_no
WHERE de.to_date LIKE '99%' AND
	  s.to_date LIKE '99%'
GROUP BY d.dept_name, de.to_date
ORDER BY avg_salary DESC
LIMIT 1; 

# 8 - Who is highest paid Marketing employee
SELECT e.first_name, e.last_name, MAX(s.salary) AS max_salary
FROM employees AS e
JOIN salaries as s
ON s.emp_no = e.emp_no
JOIN dept_emp as de
ON de.emp_no = e.emp_no
JOIN departments as d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Marketing'
	AND s.to_date LIKE '99%'
GROUP BY e.first_name, e.last_name, s.to_date
ORDER BY max_salary DESC
LIMIT 1;

# 9 - Which current department manager has highest salary
SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM dept_manager AS dm
JOIN employees AS e 
ON e.emp_no = dm.emp_no
JOIN salaries as s
ON s.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = dm.dept_no
WHERE s.to_date LIKE '99%' AND 
	dm.to_date LIKE '99%'
ORDER BY s.salary DESC
LIMIT 1;

# 10 - Average salary for each department, using all salary information
SELECT d.dept_name, ROUND(AVG(s.salary),2) AS average_salary
FROM departments AS d
JOIN dept_emp AS de
ON de.dept_no = d.dept_no
JOIN salaries AS s
ON s.emp_no = de.emp_no
GROUP BY d.dept_name
ORDER BY average_salary DESC;

# 11 - Names of all current employees, their department name, and current manager
SELECT g.emp_name AS 'Employee Name', 
g.dname AS 'Department Name',
CONCAT(mgr_emp.first_name," ",mgr_emp.last_name) AS 'Manager Name' 
FROM
(SELECT CONCAT(e.first_name," ",e.last_name) AS emp_name, 
	   d.dept_name AS dname,
	   dm.emp_no AS mgr_emp_no
FROM employees as e
JOIN dept_emp as de
ON e.emp_no = de.emp_no
JOIN departments as d
ON d.dept_no = de.dept_no
JOIN dept_manager as dm
ON dm.dept_no = d.dept_no
WHERE de.to_date LIKE '99%'
	AND dm.to_date LIKE '99%') as g
JOIN employees AS mgr_emp 
ON g.mgr_emp_no = mgr_emp.emp_no;
# Utilized a sub-query

# 12 - Who is the highest paid employee in each department

SELECT h.dept_name AS 'Department Name', CONCAT (e.first_name, ' ',e.last_name) AS 'Highest Paid Employee', max_dept_sal AS 'Highest Department Salary' FROM
(SELECT * FROM
(
SELECT d.dept_name,
		d.dept_no,
	   MAX(s.salary) AS max_dept_sal
FROM employees AS e
JOIN dept_emp AS de
ON de.emp_no = e.emp_no
JOIN salaries AS s
ON s.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = de.dept_no
WHERE s.to_date > CURDATE() AND
		de.to_date > CURDATE()
GROUP BY d.dept_name, d.dept_no) AS g

JOIN salaries AS s
ON s.salary = g.max_dept_sal
WHERE s.to_date> CURDATE()) AS h

JOIN employees AS e
ON e.emp_no = h.emp_no
ORDER BY max_dept_sal ASC; 

## Walkthrough of 12
# First produce table with Department Name and Max Salary per Department. DeptNo is useful for future joins ---- 
SELECT d.dept_name, d.dept_no, MAX(s.salary) AS max_dept_sal
FROM employees AS e # Start with employees
JOIN dept_emp AS de
ON de.emp_no = e.emp_no # Get department info for each employee
JOIN salaries AS s
ON s.emp_no = e.emp_no # Get salary info for each employee
JOIN departments AS d
ON d.dept_no = de.dept_no # Get department name for each department number
WHERE s.to_date > CURDATE() AND
		de.to_date > CURDATE() # Only want to compare salaries with those currently employed and those currently in the same department
GROUP BY d.dept_name, d.dept_no;

## Now we want to get the employees who match up with the max salary and dept number
SELECT * FROM
(
SELECT d.dept_name,
		d.dept_no,
	   MAX(s.salary) AS max_dept_sal
FROM employees AS e
JOIN dept_emp AS de
ON de.emp_no = e.emp_no
JOIN salaries AS s
ON s.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = de.dept_no
WHERE s.to_date > CURDATE() AND
		de.to_date > CURDATE()
GROUP BY d.dept_name, d.dept_no) AS g

JOIN salaries AS s
ON s.salary = g.max_dept_sal
WHERE s.to_date> CURDATE();

## Now we want the first and last names based on emp_no, so joining to employees Table
SELECT h.dept_name AS 'Department Name', CONCAT (e.first_name, ' ',e.last_name) AS 'Highest Paid Employee', max_dept_sal AS 'Highest Department Salary' FROM
(SELECT * FROM
(
SELECT d.dept_name,
		d.dept_no,
	   MAX(s.salary) AS max_dept_sal
FROM employees AS e
JOIN dept_emp AS de
ON de.emp_no = e.emp_no
JOIN salaries AS s
ON s.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = de.dept_no
WHERE s.to_date > CURDATE() AND
		de.to_date > CURDATE()
GROUP BY d.dept_name, d.dept_no) AS g

JOIN salaries AS s
ON s.salary = g.max_dept_sal
WHERE s.to_date> CURDATE()) AS h

JOIN employees AS e
ON e.emp_no = h.emp_no
ORDER BY max_dept_sal ASC; 
