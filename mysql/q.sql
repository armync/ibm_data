SHOW FULL TABLES WHERE table_type = 'BASE TABLE';

SELECT * FROM staff;

mysqldump --host=mysql --port=3306 --user=root --password sakila staff > sakila_staff_mysql_dump.sql

cat sakila_staff_mysql_dump.sql