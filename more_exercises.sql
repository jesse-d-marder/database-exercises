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

