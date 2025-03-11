mysql --host=mysql --port=3306 --user=root --password -t < employees.sql

use employees

show tables;

SELECT * FROM employees;

EXPLAIN SELECT * FROM employees;

SELECT * FROM employees WHERE hire_date >= '2000-01-01';

EXPLAIN SELECT * FROM employees WHERE hire_date >= '2000-01-01';

CREATE INDEX hire_date_index ON employees(hire_date);

SHOW INDEX FROM employees;

SELECT * FROM employees WHERE hire_date >= '2000-01-01';

EXPLAIN SELECT * FROM employees WHERE hire_date >= '2000-01-01';

DROP INDEX hire_date_index ON employees;

SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

EXPLAIN SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

CREATE INDEX first_name_index ON employees(first_name);
CREATE INDEX last_name_index ON employees(last_name);

SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

EXPLAIN SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

SELECT * FROM employees WHERE first_name LIKE 'C%' UNION ALL SELECT * FROM employees WHERE last_name LIKE 'C%';

SELECT * FROM employees WHERE first_name LIKE '%C';

SELECT * FROM employees;

SELECT first_name, last_name, hire_date FROM employees;

EXPLAIN SELECT * FROM salaries;

SELECT emp_no, salary FROM salaries;

EXPLAIN SELECT emp_no, salary FROM salaries;

SELECT emp_no, title FROM titles;

EXPLAIN SELECT emp_no, title FROM titles;