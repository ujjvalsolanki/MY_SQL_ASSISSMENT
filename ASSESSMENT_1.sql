CREATE DATABASE TOPS4;
use TOPS4;

create table country
( country_id int primary key ,
  country_name varchar(50),
  country_name_eng varchar(50),
  country_code varchar(50)
);

insert into  country values
(1,"Deutschland","germany","DEU"),
(2,"Srbij","serbia","SRB"),
(3,"Hrvatska","croatia","HRV"),
(4,"US","us","USA"),
(5,"Polska","poland","POL"),
(6,"Espana","spain","ESP"),
(7,"Rossiya","russia","RUS");

create table city 
( city_id int primary key ,
  city_name varchar(50),
  lat int ,
  long_name int ,
  country_id int , 
  foreign key (country_id) references country(country_id)
);


insert into city values
(1,"Berlin",52.520008,13.404954,1),
(2,"Belgrade",44.787197,20.457273,2),
(3,"Zagreb",45.815399,15.966568,3),
(4,"New York",40.730610,-73.935242,4),
(5,"Los Angeles",34.052235,-118.243683,4),
(6,"Warsaw",52.237049,21.017532,5);


create table customer 
( id int primary key ,
  customer_name varchar(50),
  city_id int ,
  customer_address varchar(50),
  next_call_date varchar(50),
  ts_inserted int,
  foreign key(city_id)  references city(city_id)
  );
  alter table customer
   add column next_call_date date ;
  alter table customer 
  drop column ts_inserted;
  alter table customer 
  add column ts_inserted date;
 insert  into customer values
 (1,"jewelary stor",4,"long street 120","2020-01-21","2020-01-09"),
 (2,"bakery stor",1,"kurftedamm 25","2020-02-21","2020-01-09"),
 (3,"cafe",1,"tauetzienstrabe 44","2020-01-21","2020-01-09"),
 (4,"restaurant",3,"ulica lipa 15","2020-01-21","2020-01-09");
 
/*1 While each city has a related country, not all countries have related cities (Spain &
Russia don’t have them)*/

 select c.country_name_eng,ci.city_name
 from city ci 
 right join country c 
 on ci.country_id = c.country_id
 where  country_name_eng  <> "spain" and country_name_eng  <> "russia"  ;
 
 /*Same stands for the customers. Each customer has the city_id value defined, but only
3 cities are being used (Berlin, Zagreb & New York)*/
select c.customer_name ,ci.city_name
from customer c
left join city ci
on c.city_id  = ci.city_id
where ci.city_name = " Berlin"and ci.city_name = "Zagreb" and ci.city_name = "New York";

select c.customer_name,ci.city_name
from customer c 
inner join city ci
on c. city_id = ci.city_id
where ci.city_name="Berlin" "Zagreb""New York";

-- 3 List all Countries and customers related to these countries.
select c.country_name,  cu.customer_name
from country c
join costomer cu
on c.id = cu.id;
 /*4 For each country displaying its name in English, the name of the city customer is located in as
    well as the name of the customer. */

select c.country_name as "country",
       ci.city_name as "city",
       cu.customer_name as "customer"
from country c 
left join  
    customer cu 
on  c.country_id= cu.country_id
left join  city ci 
on   cu.city_id = ci.city_id;  

/*Return the list of all countries that have pairs(exclude countries which are not referenced by any
city). For such pairs return all customers.*/


