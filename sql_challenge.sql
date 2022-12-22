create database if not exists sql_challenge;
use sql_challenge;

create table if not EXISTS city(
ID int,
NAME varchar(17),
COUNTRYCODE varchar(3),
DISTRICT VARCHAR(20),
POPULATION INT

);
#1 Query all columns for all American cities in the CITY table with populations larger than 100000.

SELECT 
    name
FROM
    city
WHERE
    POPULATION > 100000 AND COUNTRYCODE = 'USA';

#2 Query the NAME field for all American cities in the CITY table with populations larger than 120000.
SELECT 
    name
FROM
    city
WHERE
    POPULATION > 120000 AND COUNTRYCODE = 'USA';

#3 Query all columns (attributes) for every row in the CITY table.    
SELECT 
    *
FROM
    city;

#4 Query all columns for a city in CITY with the ID 1661.
SELECT 
    *
FROM
    city
WHERE
    ID = 1661   ;
    
#5 Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT 
    *
FROM
    city
WHERE
    COUNTRYCODE = 'JPN';    
    
#6 Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.    

SELECT 
    name
FROM
    city
WHERE
    COUNTRYCODE = 'JPN'