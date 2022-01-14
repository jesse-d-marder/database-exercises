# Exercises from https://ds.codeup.com/sql/case-statements/

USE employees;

# 1 - Return employees, dept_no, start_date, end_date and new column is_current_employee

SELECT first_name, last_name, hire_date, to_date, to_date>CURDATE() AS is_current_employee
FROM employees
JOIN dept_emp as de
USING (emp_no);

### Cleaner looking results that removes redundant rows (ie people who have changed departments - don't really care about them)
SELECT first_name, last_name, h.emp_no, h.dept_no, h.latest_from_date, h.to_date, 
IF(to_date>CURDATE(),1,0) AS is_current_employee
FROM 
(SELECT dept_emp.emp_no, dept_emp.dept_no, latest_from_date, dept_emp.to_date 
FROM dept_emp
JOIN 
		(SELECT emp_no, MAX(from_date) AS latest_from_date
		FROM dept_emp 
		GROUP BY emp_no) as g # Finds the max from date so we only have data for the latest department employee is in
ON (g.emp_no = dept_emp.emp_no AND g.latest_from_date = dept_emp.from_date)) as h # Adds in dept_no and to_date data. Joined on both the latest from date and the emp_no
JOIN
employees as e #Employees table gives us the first and last names
USING (emp_no);

# 2 - Return employee names and a new column 'alpha_group' that returns 'A-H','I-Q', or 'R-Z' depending on first letter of last name

SELECT first_name, 
		  last_name, 
		  CASE 
		  	WHEN SUBSTR(last_name,1,1) BETWEEN 'A' AND 'H' THEN 'A-H'
		  	WHEN SUBSTR(last_name,1,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
		  	WHEN SUBSTR(last_name,1,1) BETWEEN 'R' AND 'Z' 
THEN 'R-Z'
			END as alpha_group
FROM employees;

# 3 - How many employees born in each decade
SELECT sum(decade_50), sum(decade_60)
FROM
(SELECT first_name, birth_date, 
		if (birth_date LIKE '195%',1,0) AS decade_50,
		if (birth_date LIKE '196%',1,0) AS decade_60
FROM employees) as g;
# 182,886 born in 50s, 117,138 born in 60s

# 4 - What is current average salary for each department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service

SELECT dept_group, ROUND(AVG(salary),2) AS avg_salary FROM 
(SELECT emp_no, salary, dept_name,
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		  WHEN dept_name IN ('Finance','Human Resources') THEN 'Finance & HR'	
       ELSE dept_name
END AS dept_group
FROM departments
JOIN dept_emp AS de
	USING (dept_no)
JOIN salaries AS s
	USING (emp_no)
WHERE de.to_date>CURDATE() AND s.to_date>CURDATE()) AS g
GROUP BY dept_group
ORDER BY avg_salary DESC;
/*
Sales & Marketing	86368.86
Finance & HR	71107.74
R&D	67709.26
Prod & QM	67328.50
Customer Service	67285.23
*/