# triggers
use workshop;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);


delimiter //
create trigger binsert
before insert on employees
for each row
            begin 
                 if new.salary<15000 then
                 set new.salary=15000;
                 end if;
			end //
delimiter ;

insert into employees values(1,"Ravi","IT",10000);
insert into employees values(2,"Navya","IT",30000);
select * from employees;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

delimiter //
create trigger before_insert
before insert on students
for each row
            begin 
                 set new.name=upper(new.name);
			end //
delimiter ;

insert into students values(1,'siva',85);
select * from students;
insert into students values(2,'Shiva',85);
select * from students;

CREATE TABLE student_marks (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

delimiter //
create trigger b_insert
before insert on student_marks
for each row 
            begin 
                if new.marks>100 then
                signal sqlstate "45000"
                set message_text="Marks cannot be greater than 100" ;
                end if; 
			end //
delimiter ;

INSERT INTO student_marks
VALUES (1, 'Ravi', 120);

INSERT INTO student_marks
VALUES (2, 'Navya', 100);

select * from student_marks;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE employee_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    name VARCHAR(50),
    action VARCHAR(50)
);

delimiter //
create trigger ainsert
after insert on employees
for each row
           begin
               insert into employee_log(emp_id,name,action)
               values(new.emp_id,new.name,'Employee Inserted');
		   end //
delimiter ;

insert  into employees values(1,'siva',15000);

select * from employee_log;

-- Task 5 — AFTER INSERT: Update Department Count
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE department_count (
    department VARCHAR(50) PRIMARY KEY,
    total_employees INT
);

INSERT INTO department_count
VALUES
('IT', 0),
('HR', 0),
('Sales', 0);

delimiter //
create trigger a_insert
after insert on employees
for each row
             begin 
                 update department_count
                 set total_employees=total_employees+1
                 where department=new.department;
			end //
delimiter ;

INSERT INTO employees
VALUES (1, 'Ravi', 'IT');

select * from department_count;


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE product_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(50),
    message VARCHAR(100)
);

DELIMITER //

CREATE TRIGGER before_product_insert
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.price < 100 THEN
        SET NEW.price = 100;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_product_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO product_log
    (product_id, product_name, message)
    VALUES
    (NEW.product_id, NEW.product_name, 'Product inserted successfully');
END //

DELIMITER ;

INSERT INTO products
VALUES (1, 'Keyboard', 50);

SELECT * FROM products;

SELECT * FROM product_log;
		
                 
                 



