create database databasename;

example:
create database snorlax;

-- for listing the created databases:
select * from sys.databases; --in sql server

show databases; --in mysql
\l -- in the terminal to list all the databases 
SELECT datname FROM pg_database; -- query for list the database name 

-- using use command connect to the database 
use databasename; -- for other sql

\c databasename -- in psql

-- list tables
show tables; --- used mysql
\dt -- psql
SELECT *
FROM sys.tables;

-- SQL Datatypes

-- String based datatypes

varchar(n)
char(n)
text

Example Query
INSERT INTO users
VALUES (
    'Prasanth',
    'IN',
    'Software Developer'
);
  

-- GENERAL QUERY
create table tablename (
  column_name datatype constraint.
  column_name datatype constraint.
);



