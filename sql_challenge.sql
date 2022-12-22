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

#7 Query a list of CITY and STATE from the STATION table.
SELECT 
    city, state
FROM
    station;   

#8 Query a list of CITY names from STATION for cities that have an even ID number. Print the results
# in any order, but exclude duplicates from the answer.

SELECT DISTINCT
    city, id
FROM
    station
WHERE
    id % 2 = 0;   

#9 Find the difference between the total number of CITY entries in the table and the number of
# distinct CITY entries in the table.    

SELECT 
    COUNT(city) - COUNT(DISTINCT city) AS difference
FROM
    station;
	
#10 Query the two cities in STATION with the shortest and longest CITY names, as well as their
#respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
# largest city, choose the one that comes first when ordered alphabetically.  

(select city,length(city) as length
 from station 
 order by length,city limit 1)
union all
(select city,length(city) as length
 from station 
 order by length desc,city limit 1)	