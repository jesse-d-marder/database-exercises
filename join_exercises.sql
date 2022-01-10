USE join_example_db;

SELECT *
FROM roles;

SELECT *
FROM users;

# JOIN practice

SELECT users.name AS user_name, roles.name AS role_name
FROM users
JOIN roles
ON roles.id = users.role_id;

# LEFT JOIN practice

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles
ON users.role_id = roles.id;

# RIGHT JOIN practice

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles
ON roles.id = users.role_id;

# 3 - Practice with aggregate functions - number of users per role
SELECT roles.name, COUNT(*) as Num_Users
FROM roles
JOIN users
ON users.role_id = roles.id
GROUP BY roles.name;
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
GROUP BY t.title, d.dept_name, de.to_date
HAVING d.dept_name = "Customer Service"
	AND de.to_date LIKE '99%'
ORDER BY t.title ASC; # Doesn't match online answer

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
GROUP BY d.dept_name, de.to_date
HAVING de.to_date LIKE '99%'
ORDER BY avg_salary DESC
LIMIT 1; # Not consistent with online answer and not so elegant

# 8 - Who is highest paid Marketing employee
SELECT CONCAT(e.first_name, e.last_name) AS full_name, MAX(s.salary)
FROM employees AS e
JOIN salaries as s
ON s.emp_no = e.emp_no
JOIN dept_emp as de
ON de.emp_no = e.emp_no
JOIN departments as d
ON d.dept_no = de.dept_no
GROUP BY d.dept_name;



