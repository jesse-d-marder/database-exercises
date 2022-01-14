# Exercises from https://ds.codeup.com/sql/more-exercises/

USE sakila;
# 7 sales per store
SELECT LEFT(payment_date,7) AS payment_month, store_id, SUM(amount) AS sales
FROM store
JOIN staff
	USING(store_id)
JOIN payment
	USING (staff_id)
WHERE LEFT(payment_date,7) LIKE '%2005%'
GROUP BY payment_month, store_id
ORDER BY payment_month ASC;

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

### PIZZZZZZAAA

# avg price of pizza that have no cheese
USE pizza;

CREATE TEMPORARY TABLE innis_1659.topping_multiple AS
SELECT pizza_id, topping_id, topping_price,
	CASE 
		WHEN topping_amount = 'extra' THEN 1.5
		WHEN topping_amount = 'double' THEN 2
		WHEN topping_amount = 'light' THEN 0.5
		ELSE 1.0
	END AS topping_amount_multiple
FROM pizza_toppings
JOIN toppings
	USING (topping_id);
	
DROP TABLE innis_1659.topping_multiple;

SELECT * FROM innis_1659.topping_multiple;

CREATE TEMPORARY TABLE innis_1659.total_top_price AS
SELECT pizza_id, 
		SUM(topping_price*topping_amount_multiple) AS total_toppings_price 
FROM innis_1659.topping_multiple
GROUP BY pizza_id;


SELECT AVG(modifier_price+size_price+total_toppings_price) AS avg_pizza_price
FROM pizzas
JOIN pizza_modifiers
	USING (pizza_id)
JOIN modifiers
	USING (modifier_id)
JOIN sizes
	USING (size_id)
JOIN innis_1659.total_top_price
	USING (pizza_id)
WHERE modifier_name = 'no cheese';
# $14.58 is average price of pizzas without cheese

# most common size of pizza that have extra cheese

SELECT COUNT(*) AS num_pizzas, size_name
FROM pizzas
JOIN pizza_modifiers
	USING (pizza_id)
JOIN modifiers
	USING (modifier_id)
JOIN sizes
	USING (size_id)
WHERE modifier_name = 'extra cheese'
GROUP BY size_name
ORDER BY num_pizzas DESC
LIMIT 1;
# medium is most common - 575

# Most common topping for pizzas that are well done
SELECT topping_name, COUNT(topping_name) AS num_pizzas_w_topping
FROM pizzas
JOIN pizza_modifiers
	USING (pizza_id)
JOIN modifiers
	USING (modifier_id)
JOIN pizza_toppings
	USING (pizza_id)
JOIN toppings
	USING (topping_id)
WHERE modifier_name = 'well done'
GROUP BY topping_name
ORDER BY num_pizzas_w_topping DESC
LIMIT 1;
# Bacon is most common topping for well done pizzas

# How many pizzas are only cheese i.e. no toppings
SELECT COUNT(*)
FROM pizzas
WHERE pizza_id NOT IN (SELECT pizza_id FROM pizza_toppings); 
# Explaination - if they have a topping they should be in pizza_toppings
# 2548 just cheese

# total orders
SELECT COUNT(order_id) FROM pizzas; # 20001

# How many orders consist of pizza(s) that are only cheese? What is the average price of these orders? The most common pizza size?
SELECT order_id AS only_cheese_order_id,
			size_price+modifier_price AS total_price # doesn't like the nulls
FROM pizzas
LEFT JOIN pizza_modifiers
	USING (pizza_id)
LEFT JOIN modifiers
	USING (modifier_id)
JOIN sizes
	USING (size_id)
WHERE order_id IN (
SELECT order_id
FROM pizzas
WHERE pizza_id NOT IN (SELECT pizza_id FROM pizza_toppings)) # order_id should be in the cheese pizza list
AND order_id NOT IN (
SELECT order_id
FROM pizzas
WHERE pizza_id IN (SELECT pizza_id FROM pizza_toppings)); # order_id should not be in the non-cheese pizza list

# 572 only cheese orders