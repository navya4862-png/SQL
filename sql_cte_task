CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    department VARCHAR(50),
    experience INT
);
INSERT INTO employees (id, name, salary, department, experience)
VALUES
(1, 'Alice', 50000, 'HR', 2),
(2, 'Bob', 65000, 'IT', 6),
(3, 'Charlie', 75000, 'IT', 8),
(4, 'David', 45000, 'Finance', 3),
(5, 'Emma', 90000, 'IT', 10),
(6, 'Frank', 60000, 'HR', 5),
(7, 'Grace', 55000, 'Finance', 7),
(8, 'Henry', 75000, 'IT', 4),
(9, 'Ivy', 40000, 'HR', 1),
(10, 'Jack', 65000, 'Finance', 6);
select * from employees;
-- section A — 10 Normal / Single CTE Questions
-- 1. Find all employees whose salary is greater than 60,000 using a single CTE.
with high_salary as(
       select * 
	   from employee
       where salary >60000
)
select * 
from high_salary;
-- 2. Find the employee(s) who earn the highest salary using a single CTE.
with max_sal as(
         select max(salary) as salary
         from employees
)
select e.*
from employees e 
join max_sal m
on e.salary=m.salary;
-- 3. Find the employee(s) who earn the lowest salary using a single CTE.
with min_sal as(
         select min(salary) as salary
         from employees
)
select e.*
from employees e 
join min_sal m
on e.salary=m.salary;
-- 4. Find employees whose salary is greater than the average salary using a single CTE.
with avg_sal as(
       select avg(salary) as average_salary
       from employees
)
select e.*
from employees e
join avg_sal a
on e.salary > a.average_salary;
-- 5. Find employees whose salary is less than the average salary using a single CTE.
with avg_sal as(
       select avg(salary) as average_salary
       from employees
)
select e.*
from employees e
join avg_sal a
on e.salary < a.average_salary;

-- 6. Find the total salary paid by the company using a single CTE.
with total_sal as(
          select sum(salary) as total_salary
          from employees
)
select total_salary
from total_sal;

-- 7. Find the average salary of employees using a single CTE and display the result with a
-- meaningful column name.
with avg_sal as(
      select avg(salary) as average_salary
      from employees
)
select average_salary
from avg_sal;
-- 8. Find the employees working in the IT department using a single CTE.
with it_emp as(
       select *
       from employees
       where department='IT'
)
select *
from it_emp;
-- 9. Find the number of employees in the company using a single CTE.
with count_emp as(
      select count(*) as total_count
      from employees
)
select total_count
from count_emp;

-- 10. Find the employees who have more than 5 years of experience using a single CTE.
with experienced_employees as(
          select *
          from employees
          where experience > 5
)
select *
from experienced_employees;

-- Section B — Multiple CTE Questions
-- 1. Create one CTE to calculate the average salary and another CTE to find employees earning
-- more than the average salary.
with avg_sal as(
         select avg(salary) as avg_salary
         from employees
),
above_avg as(
        select e.*
        from employees e
        join avg_sal a
        on e.salary > a.avg_salary)
select *
from above_avg;
-- 2. Create one CTE to find the maximum salary and another CTE to find all employees earning
-- that maximum salary.
with max_sal as(
			select max(salary) as max_salary
            from employees
),
same_as_max_sal as(
               select e.*
               from employees e
               join max_sal m
               on e.salary=m.max_salary
)
select *
from same_as_max_sal;
-- 4. Create one CTE to filter employees with more than 5 years of experience and another CTE to
-- find the average salary of those employees.
with experienced_emp as(
          select *
          from employees
          where experience>5
),
avg_experienced_sal as (
        select avg(salary) as avg_salary
        from experienced_emp
)
select *
from avg_experienced_sal;
-- 5. Create one CTE to calculate total salary by department and another CTE to find departments
-- whose total salary is greater than 150,000.
with dept_sal as(
         select department,sum(salary) as total_salary
         from employees
         group by department
),
high_sal as (
        select *
        from dept_sal
        where total_salary>150000
)
select *
from high_sal;
-- 6. Create one CTE to find employees in the IT department and another CTE to find the highest-
-- paid employee among those IT employees.
with it_dep as(
      select *
      from employees
      where department='IT'
),
max_sal as(
       select max(salary) as max_salary
       from it_dep
)
select *
from max_sal;

-- 7. Create one CTE to find employees earning more than 60,000 and another CTE to count how
-- many such employees exist in each department.
with emp_earning as(
      select *
      from employees
      where salary > 60000
),
emp_count as (
      select department,count(*) as total_emp
      from emp_earning
      group BY department
)
select * 
from emp_count;
-- 8. Create one CTE to calculate the average salary by department and another CTE to find
-- departments whose average salary is greater than the company's overall average salary.
with avg_sal as (
         select department,avg(salary) as avg_salary
         from employees
         group by department
),
high_sal as(
                select *
                from avg_sal
                where avg_salary>(select avg(salary) from employees)
)
select *
from high_sal;
