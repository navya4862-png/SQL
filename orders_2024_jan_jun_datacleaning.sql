use ddata;
select * from orders_2024_jan_jun;
desc orders_2024_jan_jun;

#rename table_name
rename table orders_2024_jan_jun to orders;
START TRANSACTION;

select * from orders;
commit;

# check null values
select * 
from orders 
where orderid is null or orderid="";

# check OrderDate null values
select * 
from orders 
where OrderDate is null or OrderDate="";

# check CustomerID null values
select * 
from orders 
where CustomerID is null or CustomerID="";

# check CustomerName null values
select * 
from orders 
where CustomerName is null or CustomerName="";

# check Region null values
select * 
from orders 
where Region is null or Region="";

# check ProductID null values
select * 
from orders 
where ProductID is null or ProductID="";

# check ProductName null values
select * 
from orders 
where ProductName is null or ProductName="";

# check Category null values
select * 
from orders 
where Category is null or Category="";

# check Quantity null values
select * 
from orders 
where Quantity is null or Quantity="";

# check Price null values
select * 
from orders 
where Price is null or Price="";

# check TotalAmount null values
select * 
from orders 
where TotalAmount is null or TotalAmount="";

# check PaymentMethod null values
select * 
from orders 
where PaymentMethod is null or PaymentMethod="";

select * from orders order by OrderID asc;

set sql_safe_updates=0;
#date modification
update orders
set orderdate=str_to_date(orderdate,'%m/%d/%Y');
#change data type into date
alter table orders
modify column OrderDate date;

desc orders;
select * from orders;

#modify region col
update orders
set region=
case
    when region="E" then "East"
    when region="S" then "South"
    else region
end;
savepoint point1;

#check duplicates
SELECT 
    OrderID,
    OrderDate,
    CustomerID,
    CustomerName,
    Region,
    ProductID,
    ProductName,
    Category,
    Quantity,
    Price,
    TotalAmount,
    PaymentMethod,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY
    OrderID,
    OrderDate,
    CustomerID,
    CustomerName,
    Region,
    ProductID,
    ProductName,
    Category,
    Quantity,
    Price,
    TotalAmount,
    PaymentMethod
HAVING COUNT(*) > 1;

commit;
drop table orders;

#remove dupilcates

CREATE TABLE orders_backup3 AS
SELECT * FROM orders;

select * from orders_backup3;

#delete duplicate
DELETE FROM orders
WHERE orderid IN (
    SELECT orderid
    FROM (
        SELECT orderid,
               ROW_NUMBER() OVER (
                   PARTITION BY orderid
                   ORDER BY orderid
               ) AS rn
        FROM orders
    ) AS t
    WHERE rn > 1
);

select * from orders order by orderid asc;

select * from orders_backup3;



