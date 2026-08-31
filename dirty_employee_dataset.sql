#use data base
use ddata;
#retrive data from table
select * 
from dirty_employee_dataset;

#rename table name
rename table dirty_employee_dataset to employee;

#check null values
select employee_id 
from employee
where employee_id is null or employee_id="";

select * from employee;


#turn of safe update
set sql_safe_updates=0;

#employee_name trim white spaces
update employee
set Employee_Name = trim(Employee_Name);

select * from employee;

#check null values
select employee_name 
from employee
where employee_name is null or employee_name="";

# change name into upper case
update employee
set employee_name=upper(employee_name);

select * from employee;

# change m into male
update employee
set gender= (case 
                 when gender="M" then "Male"
                 when gender="F" then "Female"
                 else gender
			end);
# captization of 1st letter male --> Male
update employee
set gender= concat(
					upper(left(gender,1)),
                    lower(substring(gender,2))
                    );
                    
select * from employee;

# update department column
update employee
set department= case
                     when department="Information Technology" then "IT"
                     when department="hr" then "Hr"
                     else department 
                     end;
                     
select * from employee;

update employee
set department=concat(
			   upper(left(department,1)),
               lower(substring(department,2))
               );
                
select * from employee;

#trim white spaces
update employee
set department=trim(department);

select * from employee;

select job_role from employee  where job_role is null or job_role="" ;
select city from employee  where city is null or city="" ;
#trim white spaces in city
update employee
set city=trim(city);

select * from employee;

# update city 
update employee
set city="Hyderabad"
where city="Hyd" ;

select * from employee;

# captization of 1st letter male --> Male
update employee
set gender= concat(
					upper(left(gender,1)),
                    lower(substring(gender,2))
                    );
                    
select * from employee;

# update department column
update employee
set department= case
                     when department="Information Technology" then "IT"
                     when department="hr" then "Hr"
                     else department 
                     end;
                     
select * from employee;

update employee
set city=concat(
			   upper(left(city,1)),
               lower(substring(city,2))
               );
select * from employee;

# check null values in email
select *
from employee
where email is null or email="";

# repalce null with unkown
update employee
set email="unavailable"
where email is null or email="";

select * from employee;

# remove +91- in phone col
update employee
set phone = replace(phone,"+91-","");

select * from employee;

# remove "+91 "in phone col
update employee
set phone = replace(phone,"+91 ","");

select * from employee;

# remove space 98765 43212
update employee
set phone=replace(phone," ","");

select * from employee;

# null values
select * from employee where phone is null or phone="";

update employee
set phone="unkonwn"
where phone is null or phone="";

update employee
set phone=null
where phone="unkonwn";

select * from employee;

#change data type into big int
alter table employee
modify column phone bigint;

desc employee;

update employee
set phone=0
where phone is null or phone="";

select * from employee;

#remove dollar symbol in salary
UPDATE employee
SET salary = REPLACE(salary, 'â‚¹', '');


#change the formate '%Y-%m-%d' 
update employee
set joining_date=
case
   when joining_date like '____-__-__'
   then date_format(str_to_date(joining_date, '%Y-%m-%d'), '%Y-%m-%d')
   when joining_date like '__/__/____'
   then date_format(str_to_date(joining_date, '%d/%m/%Y'), '%Y-%m-%d')
   when joining_date like '____/__/__'
   then date_format(str_to_date(joining_date,'%Y/%m/%d'), '%Y-%m-%d')
   when joining_date like '__-__-____'
   then date_format(str_to_date(joining_date,'%d-%m-%Y'),'%Y-%m-%d')
   else null
   end;
   
select * from employee;

# remove year
update employee
set experience=replace(experience,"years","");

select * from employee;

#check null
select *
from employee
where experience is null or experience="";

#set null value with 1 year experience
update employee
set experience=1
where experience is null or experience="";

# capitalize the fist letter
update employee
set performance=concat(
               upper(left(performance,1)),
               lower(substring(performance,2))
               );

select * from employee;

update employee
set status='Active'
where status='A';

select * from employee;

# capitalize the fist letter
update employee
set status=concat(
               upper(left(status,1)),
               lower(substring(status,2))
               );
