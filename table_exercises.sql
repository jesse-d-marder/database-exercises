# Exercises from https://ds.codeup.com/sql/tables/

# 3 Use the employees database
USE employees;

# 4 Lists all the tables in the database 
SHOW TABLES;

# 5 Exploring the employees table
DESCRIBE employees; 
# ...Shows the different data types present in the table which include int, date, varchar, and enum

# 6 I think the employees and salaries tables contain a numeric type column

# 7 I think the departments, titles, and employees tables contain string type columns

# 8 I think the employees, dept_emp, and departments table contain date type columns

# 9 Based on the "Relations" tab there doesn't appear to be a explicit relationship between the employees and departments tables but looking at the dept_emp table shows that the employee id is matched up to a department number.

# 10 Show the SQL that created the dept_manager table
SHOW CREATE TABLE dept_manager;

