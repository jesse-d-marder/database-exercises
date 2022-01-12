# Exercises from https://ds.codeup.com/sql/more-exercises/

# Employees database - 1 - How much do current managers of each department get paid relative to the average salary for the department? Any department where the department manager gets paid less than the average salary??

USE employees;


SELECT i.dept_name, i.manager_salary, i.Dept_Avg_Salary, (i.manager_salary - i.Dept_Avg_Salary) AS Mgr_Sal_Rel_Avg
FROM
(SELECT g.dept_name, h.manager_salary, AVG(g.salary) AS Dept_Avg_Salary
FROM (
SELECT s.emp_no, s.salary, de.dept_no, d.dept_name
FROM salaries as s
JOIN dept_emp as de
ON de.emp_no = s.emp_no
JOIN departments as d
ON d.dept_no = de.dept_no
WHERE s.to_date>CURDATE()
AND de.to_date>CURDATE()) AS g # This table consists of employee no, salary, dept_no, and dept_name
JOIN 
(SELECT salary AS manager_salary, dept_no 
FROM salaries as s
JOIN dept_emp as de
ON de.emp_no = s.emp_no
WHERE s.to_date>CURDATE() AND
s.emp_no IN (SELECT emp_no FROM dept_manager WHERE to_date>CURDATE())) as h # This table gets manager salaries
ON h.dept_no = g.dept_no
GROUP BY g.dept_name, h.manager_salary) as i;
/* Output shows salary per manager by deparment, as well as dept average salary, and then the difference between the manager's salary and the average salary in the department. Two managers make less than their department's average! */

# World Database
USE world;
# Languages spoken in Santa Monica
SELECT Language, Percentage
FROM countrylanguage
WHERE CountryCode = (SELECT CountryCode FROM city WHERE Name= 'Santa Monica')
ORDER BY Percentage ASC;
# Different countries in each region
SELECT Region, COUNT(Region) AS num_countries
FROM country
GROUP BY Region
ORDER BY num_countries ASC;
# Population for each region
SELECT Region, SUM(Population) AS Regional_population
FROM country
GROUP BY Region
ORDER BY Regional_population DESC;
# Population for each continent
SELECT Continent, SUM(Population) AS population
FROM country
GROUP BY Continent
ORDER BY population DESC;
# Average global life expectancy
SELECT AVG(LifeExpectancy)
FROM country;
