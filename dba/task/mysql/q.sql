create database sakila;

use sakila;

source sakila_mysql_dump.sql;

SHOW FULL TABLES WHERE table_type = 'BASE TABLE';