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
 
#11 Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
#cannot contain duplicates.
SELECT 
  DISTINCT  city
FROM
    station
WHERE
    city REGEXP '^[aeiou]';
    
#12 Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
#contain duplicates.

SELECT 
    DISTINCT city
FROM
    station
WHERE
    city REGEXP '[aeiou]$';
    
#13 Query the list of CITY names from STATION that do not start with vowels. Your result cannot
# contain duplicates. 

SELECT DISTINCT
    city
FROM
    station
WHERE
    city REGEXP '^[^aeiou]';  

#14 Query the list of CITY names from STATION that do not end with vowels. Your result cannot
# contain duplicates.

SELECT DISTINCT
    city
FROM
    station
WHERE
    city REGEXP '[^aeiou]$';   

#15 Query the list of CITY names from STATION that either do not start with vowels or do not end
# with vowels. Your result cannot contain duplicates.

SELECT DISTINCT
    city
FROM
    station
WHERE
    city REGEXP '^[^aeiou]'
        AND city REGEXP '[^aeiou]$';    

# create Product table
create table if not exists Product(
product_id int,
product_name varchar(20),
unit_price int
);

#Inserting data in Product table
insert into Product values(1,'S8',1000),(2,'G4',800),(3,'iPhone',1400);

# creating Sales table
create table if not EXISTS Sales(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int
);

#inserting data into sales.

insert into sales values(1,1,1,'2019-01-21',2,2000),
                        (1,2,2,'2019-02-17',1,800),
                        (2,2,3,'2019-06-02',1,800),
                        (3,3,4,'2019-05-13',2,2800);
#17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
# between 2019-01-01 and 2019-03-31 inclusive.

SELECT 
    p.product_id, p.product_name
FROM
    Product p
        LEFT JOIN
    Sales s ON p.product_id = s.product_id
GROUP BY product_id
HAVING MIN(s.sale_date) >= '2019-01-01'
    AND MAX(s.sale_date) <= '2019-03-31';   

# create Views Table
create table if not exists Views(
article_id int,
author_id int,
viewer_id int,
view_date date
);    

insert into Views values(1,3,5,'2019-08-01'),
						(1,3,6,'2019-08-02'),
                        (2,7,7,'2019-08-01'),
                        (2,7,6,'2019-08-02'),
                        (4,7,1,'2019-07-22'),
                        (3,4,4,'2019-07-21'),
                        (3,4,4,'2019-07-21');
    

#18 Write an SQL query to find all the authors that viewed at least one of their own articles.
# Return the result table sorted by id in ascending order.

SELECT DISTINCT
    author_id AS id
FROM
    views
WHERE
    author_id = viewer_id
ORDER BY id;

#create Delivery table
create table if not exists Delivery(
delivery_id int,
customer_id int,
order_date date,
customer_pref_delivery_date date
);

insert into Delivery values(1,1,'2019-08-01','2019-08-02'),
                            (2,5,'2019-08-02','2019-08-02'),
                            (3,1,'2019-08-11','2019-08-11'),
                            (4,3,'2019-08-24','2019-08-26'),
                            (5,4,'2019-08-21','2019-08-22'),
                            (6,2,'2019-08-11','2019-08-13');
                            
                            
#19 Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
# places. 

with result as (
select * from (
select delivery_id,
       customer_id,
       order_date,
       customer_pref_delivery_date,
       (case when order_date=customer_pref_delivery_date then 1 else 0 end) as immediate,
       rank() over(partition by customer_id order by order_date) as first_order
       from delivery
) x
where first_order =1

)               

select Round(sum(immediate)*100/count(first_order),2) as immediate_percentage from result            