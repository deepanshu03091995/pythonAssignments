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

#20 Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
#Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
#tie. 

select ad_id,
       ifnull(round(sum(action='Clicked')/sum(action!='Ignored')*100,2),0) as ctr
       from ads
       group by ad_id
       order by ctr desc,ad_id        

#21 Write an SQL query to find the team size of each of the employees.   
SELECT 
    e1.employee_id, COUNT(e2.team_id) AS team_size
FROM
    Employee e1
        INNER JOIN
    Employee e2 ON e1.team_id = e2.team_id
GROUP BY e1.employee_id , e2.team_id
order by e1.employee_id;

create table if not exists Countries(
country_id int,
country_name varchar(10)
);
create table if not exists Weather(
country_id int,
weather_state int,
`day` date 
);

insert into Countries values(2,'USA'),(3,'Australia'),
							(7,'Peru'),(5,'China'),
                            (8,'Morocco'),(9,'Spain');
                            
insert into weather values(2,15,'2019-11-01'),(2,12,'2019-10-28'),(2,12,'2019-10-27'),
                          (3,-2,'2019-11-10'),(3,0,'2019-11-11'),(3,3,'2019-11-12'),
                          (5,16,'2019-11-07'),(5,18,'2019-11-09'),(5,21,'2019-11-23'),
                          (7,25,'2019-11-28'),(7,22,'2019-12-01'),(7,20,'2019-12-02'),
                          (8,25,'2019-11-05'),(8,27,'2019-11-15'),(8,31,'2019-11-25'),
                          (9,7,'2019-10-23'),(9,3,'2019-12-23');
                          
#22 Write an SQL query to find the type of weather in each country for November 2019.
SELECT 
    country_name,
    CASE
        WHEN AVG(weather_state) <= 15 THEN 'Cold'
        WHEN AVG(weather_state) >= 25 THEN 'Hot'
        ELSE 'Warm'
    END AS weather_type
FROM
    Countries
        INNER JOIN
    Weather ON Countries.country_id = Weather.country_id
WHERE
    LEFT(day, 7) = '2019-11'
GROUP BY country_name;


create table if not exists Prices(
product_id int,
start_date date,
end_date date,
price int
);

create table if not exists UnitsSold(
product_id int,
purchase_date date,
units int
);

INSERT into Prices values(1,'2019-02-17','2019-02-28',5),
						(1,'2019-03-01','2019-03-22',20),
                        (2,'2019-02-01','2019-02-20',15),
                        (2,'2019-02-21','2019-03-31',30);

insert into UnitsSold values(1,'2019-02-25',100),(1,'2019-03-01',15),
						    (2,'2019-02-10',200),(2,'2019-03-22',30);
##23 Write an SQL query to find the average selling price for each product. average_price should be
# rounded to 2 decimal places.
SELECT 
    p.product_id, round(AVG(p.price) * u.units /sum(u.units),2) as average_price
FROM
    Prices p
        INNER JOIN
    UnitsSold u ON p.product_id = u.product_id
GROUP BY p.product_id;

# create Activity Table.

create table if not exists Activity(
player_id int,
device_id int,
event_date date,
games_played int
);

insert into Activity values(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),
						   (2,3,'2017-06-25',1),(3,1,'2016-03-02',0),
                           (3,4,'2018-07-03',5);
                           

#24 Write an SQL query to report the first login date for each player.

SELECT 
    player_id, MIN(event_date) as first_login
FROM
    Activity
GROUP BY player_id;    

#25 Write an SQL query to report the device that is first logged in for each player.
SELECT 
    player_id, MIN(device_id) as device_id
FROM
    Activity
GROUP BY player_id; 

#26 Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
# and their amount.

SELECT 
    p.product_name, SUM(unit)
FROM
    Products p
        INNER JOIN
    Orders o ON p.product_id = o.product_id
where left(order_date,7)='2020-02'    
group by 1
having sum(unit)>=100;    

#create table Users
create table if not exists Users(
user_id int,
name varchar(20),
mail varchar(50)
);

insert into Users values(1,'Winston','winston@leetcode.com'),
                         (2,'Jonathan','Jonathanisgreat'),
                         (3,'Annabelle','bella-@leetcode.com'),
                         (4,'sally','sally.come@leetcode.com'),
                         (5,'Marwan','quarz#2020@leetcode.com'),
                         (6,'David','david69@gmail.com'),
                         (7,'Shapiro','.shapo@leetcode.com');

#27 Write an SQL query to find the users who have valid emails

SELECT 
    *
FROM
    Users
WHERE
    mail regexp '^[a-zA-Z][a-zA-Z0-9\_.-]*@leetcode.com';
   
   
# create Customers Table
create table if not Exists Customers(
customer_id int,
name Varchar(20),
country varchar(20)
); 

create table if not exists Products2(
product_id int,
description varchar(60),
price int

);

create table if not exists orders2(
order_id int,
customer_id int,
product_id int,
order_date date ,
quantity int

);

insert into Customers values(1,'Winston','USA'),
                             (2,'Jonathan','Peru'),
                             (3,'Moustafa','Egypt');
insert into Products2 values(10,'LC Phone',300),
							(20,'LC T-Shirt',10),
                            (30,'LC Book',45),
                            (40,'LC Keychain',2);
                            
insert into orders2 values(1,1,10,'2020-06-10',1),(2,1,20,'2020-07-01',1),
                          (3,1,30,'2020-07-08',2),(4,2,10,'2020-06-15',2),
                          (5,2,40,'2020-07-01',10),(6,3,20,'2020-06-24',2),
                          (7,3,30,'2020-06-25',2),(9,3,30,'2020-05-08',3);
                          
#28 Write an SQL query to report the customer_id and customer_name of customers who have spent at
# least $100 in each month of June and July 2020.

SELECT 
    o.customer_id, name
FROM
    Customers c
        INNER JOIN
    orders2 o ON c.customer_id = o.customer_id
        INNER JOIN
    products2 p ON p.product_id = o.product_id
GROUP BY 1 , 2
HAVING SUM(CASE
    WHEN DATE_FORMAT(order_date, '%Y-%m') = '2020-06' THEN price * quantity
END) >= 100
    AND SUM(CASE
    WHEN DATE_FORMAT(order_date, '%Y-%m') = '2020-07' THEN price * quantity
END) >= 100;

#29 Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.

SELECT DISTINCT
    title
FROM
    Content
        JOIN
    TVProgram USING (content_id)
WHERE
    kids_content = 'Y'
        AND content_type = 'Movies'
        AND (MONTH(program_date) , YEAR(program_date)) = (6 , 2020);

#30 Write an SQL query to find the npv of each query of the Queries table.
SELECT 
    q.id, q.year, IFNULL(n.npv, 0) AS npv
FROM
    queries AS q
        LEFT JOIN
    npv AS n ON (q.id , q.year) = (n.id , n.year)
   

#31 Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.

SELECT
    unique_id,
    name
FROM (
SELECT
    e.id, 
    e.name,
    eu.unique_id
FROM EMployees as e LEFT JOIN EmployeeUNI as eu
ON e.id = eu.id
    ) x;
    
    
    
#33 Write an SQL query to report the distance travelled by each user.    
    
SELECT
    u.name,
    IFNULL(SUM(distance),0) as travelled_distance
FROM Users as u LEFT JOIN Rides as r
ON r.user_id = u.id
GROUP BY 1
ORDER BY 2 DESC, 1;


#35 Find the name of the user who has rated the greatest number of movies. In case of a tie,
#return the lexicographically smaller user name.
# Find the movie name with the highest average rating in February 2020. In case of a tie, return
# the lexicographically smaller movie name.

SELECT user_name AS results FROM
(
SELECT a.name AS user_name, COUNT(*) AS counts FROM Movie_Rating AS b
    JOIN Users AS a
    on a.user_id = b.user_id
    GROUP BY b.user_id
    ORDER BY counts DESC, user_name ASC LIMIT 1
) first_query
UNION
SELECT movie_name AS results FROM
(
SELECT c.title AS movie_name, AVG(d.rating) AS rate FROM Movie_Rating AS d
    JOIN Movies AS c
    on c.movie_id = d.movie_id
    WHERE substr(d.created_at, 1, 7) = '2020-02'
    GROUP BY d.movie_id
    ORDER BY rate DESC, movie_name ASC LIMIT 1
) second_query;

#36 Write an SQL query to report the distance travelled by each user.
#Return the result table ordered by travelled_distance in descending order, if two or more users
# travelled the same distance, order them by their name in ascending order.
SELECT 
    name, SUM(IFNULL(distance, 0)) AS travelled_distance
FROM
    rides r
        RIGHT JOIN
    users u ON r.user_id = u.id
GROUP BY name
ORDER BY 2 DESC , 1 ASC;


create table if not exists Departments(
id int,
name varchar(30)
);

create table if not exists Students (
id int,
name varchar(30),
department_id int

);

insert into Departments values(1,'Electrical Engineering'),
                               (7,'Computer Engineering'),
                               (13,'Business Administration');
insert into Students values(23,'Alice',1),
                            (1,'Bob',7),
                            (5,'Jennifer',13),
                            (2,'John',14),
                            (4,'Jasmine',77),
                            (3,'Steve',74),
                            (6,'Luis',1),(8,'Jonathan',7),
                            (7,'Daiana',33),
                            (11,'Madelynn',1);


#37 Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exists.

SELECT 
    s.id, s.name
FROM
    Students s
        LEFT JOIN
    Departments d ON s.department_id = d.id
WHERE
    d.id IS NULL;
    

#create Calls Table
create table if not exists Calls(
from_id int,
to_id int,
duration int
);

insert into Calls values(1,2,59),(2,1,11),(1,3,20),
                         (3,4,100),(3,4,200),(3,4,200),
                         (4,3,499);
    
#39 Write an SQL query to report the number of calls and the total call duration between each pair of
#distinct persons (person1, person2) where person1 < person2.
select from_id as person1,to_id as person2,
    count(duration) as call_count, sum(duration) as total_duration
from (select * 
      from Calls 
      
      union all
      
      select to_id, from_id, duration 
      from Calls) t1
where from_id < to_id
group by person1, person2
                       	   
	   