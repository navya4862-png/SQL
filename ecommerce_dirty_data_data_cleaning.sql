create database ddata;
use ddata;
show tables;
select * from  ecommerce_dirty_data;

#rename table name
rename table ecommerce_dirty_data to eco;
#retrive data
select * from eco;

#safe update
set sql_safe_updates=0;

#update email
update eco 
set email="NA"
where email is null or email="";

#check first name is null or not
select *
from eco
where firstname is null or firstname="";

#unique products
select distinct(product) from eco;

# update price
update eco 
set price=(case when product="Camera" then "30000"
                when product="Mouse" then "500"
                when product="Keyboard" then "1500"
                when product="Tablet" then "30000"
                when product="Headphones" then "3000"
                when product="Laptop" then "90000"
                else "0"
                end);

desc eco;

#change datatype of price
alter table eco
modify column price int;

desc eco;

#state update
update eco
set city=(case
when state="WB" then "Kolkata"
when state="DL" then "Delhi"
when state="TS" then "Hyderabad"
when state="MH" then "Mumbai"
when state="GJ" then "Gandhi Nagar"
when state="TN" then "Chennai"
when state="KA" then "Bangalore"
else "NA"
end);

#unique payment method
select distinct(payment_method) 
from eco;
#update payment method
update eco
set payment_method="COD"
where payment_method is null or payment_method="";

#change date formate
update eco 
set order_date=str_to_date(order_date,"%m/%d/%Y");
select * from eco;

# change datetype of prder date
alter table eco
modify column order_date date;
desc eco;
# find duplicates
select order_id
from (select order_id,
      row_number() over( 
      partition by order_id
      order by order_id) as rn 
      from eco
      )t
where rn>1;

#removing dupicates
DELETE FROM eco
WHERE order_id IN (
    SELECT order_id
    FROM (
        SELECT order_id,
               ROW_NUMBER() OVER (
                   PARTITION BY order_id
                   ORDER BY order_id
               ) AS rn
        FROM eco
    ) t
    WHERE rn > 1
);
select * from eco;

select distinct(order_id) from eco;
