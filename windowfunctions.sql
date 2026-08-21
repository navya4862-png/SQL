1.Display every employee along with the overall average salary.
SELECT
   emp_name,
   salary,
   AVG(salary) OVER() AS overall_avg_salary
FROM employee;
2. Display every employee along with the total salary of all employees.
SELECT
   emp_name,
   salary,
   SUM(salary) OVER() AS total_salary
FROM employee;
3. Display every employee along with their department's average salary.
SELECT
   emp_name,
   department,
   salary,
   AVG(salary) OVER(
       PARTITION BY department
   ) AS dept_avg_salary
FROM employee;
4.Display every employee along with their department's maximum salary.
SELECT
   emp_name,
   department,
   salary,
   MAX(salary) OVER(
       PARTITION BY department
   ) AS dept_max_salary
FROM employee;
5. Display every employee along with their department's total salary.
SELECT
   emp_name,
   department,
   salary,
   SUM(salary) OVER(
       PARTITION BY department
   ) AS dept_total_salary
FROM employee;
6. Assign a unique row number to every employee based on salary from highest to lowest.
SELECT
   emp_name,
   salary,
   ROW_NUMBER() OVER(
       ORDER BY salary DESC
   ) AS row_num
FROM employee;
7. Assign a row number separately within each department based on salary.
SELECT
   emp_name,
   department,
   salary,
   ROW_NUMBER() OVER(
       PARTITION BY department
       ORDER BY salary DESC
   ) AS row_num
FROM employee;
8. Rank all employees according to salary.
SELECT
   emp_name,
   salary,
   RANK() OVER(
       ORDER BY salary DESC
   ) AS salary_rank
FROM employee;
9. Rank employees within each department according to salary.
SELECT
   emp_name,
   department,
   salary,
   RANK() OVER(
       PARTITION BY department
       ORDER BY salary DESC
   ) AS salary_rank
FROM employee;
10. Find the highest-paid employee in each department using RANK().
WITH ranked AS (
   SELECT
       emp_name,
       department,
       salary,
       RANK() OVER(
           PARTITION BY department
           ORDER BY salary DESC
       ) AS rnk
   FROM employee
)
SELECT *
FROM ranked
WHERE rnk = 1;
11. Find the second-highest salary in each department.
WITH ranked AS (
   SELECT
       emp_name,
       department,
       salary,
       DENSE_RANK() OVER(
           PARTITION BY department
           ORDER BY salary DESC
       ) AS rnk
   FROM employee
)
SELECT *
FROM ranked
WHERE rnk = 2;
12. Find the third-highest salary in the company using DENSE_RANK().
WITH ranked AS (
   SELECT
       emp_name,
       salary,
       DENSE_RANK() OVER(
           ORDER BY salary DESC
       ) AS rnk
   FROM employee
)
SELECT *
FROM ranked
WHERE rnk = 3;


13. Find each employee's salary and department average salary.
SELECT
   emp_name,
   department,
   salary,
   AVG(salary) OVER(
       PARTITION BY department
   ) AS dept_avg_salary
FROM employee;
14. Find each employee's salary and department maximum salary.
SELECT
   emp_name,
   department,
   salary,
   MAX(salary) OVER(
       PARTITION BY department
   ) AS dept_max_salary
FROM employee;
15. Find each employee's salary as a percentage of their department's total salary.
SELECT
   emp_name,
   department,
   salary,
   ROUND(
       salary * 100.0 /
       SUM(salary) OVER(
           PARTITION BY department
       ),
       2
   ) AS salary_percentage
FROM employee;
16. Display each employee's salary and the previous employee's salary when ordered by salary.
SELECT
   emp_name,
   salary,
   LAG(salary) OVER(
       ORDER BY salary
   ) AS previous_salary
FROM employee;
17. Display each employee's salary and the next employee's salary.
SELECT
   emp_name,
   salary,
   LEAD(salary) OVER(
       ORDER BY salary
   ) AS next_salary
FROM employee;
18. Find the salary difference between the current and previous employee.
SELECT
   emp_name,
   salary,
   LAG(salary) OVER(
       ORDER BY salary
   ) AS previous_salary,
  
   salary - LAG(salary) OVER(
       ORDER BY salary
   ) AS salary_difference
FROM employee;




