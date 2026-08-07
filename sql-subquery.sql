-- Drop tables if they exist
DROP TABLE IF EXISTS emp;
DROP TABLE IF EXISTS dept;

-- Create DEPT table
CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dname VARCHAR(20),
    loc VARCHAR(20)
);

-- Create EMP table
CREATE TABLE emp (
    empno INT PRIMARY KEY,
    ename VARCHAR(20),
    job VARCHAR(20),
    mgr INT,
    hiredate DATE,
    sal DECIMAL(10,2),
    comm DECIMAL(10,2),
    deptno INT,
    FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

-- Insert data into DEPT
INSERT INTO dept (deptno, dname, loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

-- Insert data into EMP
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
(7369, 'SMITH',  'CLERK',     7902, '1980-12-17',  800,  NULL, 20),
(7499, 'ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600,   300, 30),
(7521, 'WARD',   'SALESMAN',  7698, '1981-02-22', 1250,   500, 30),
(7566, 'JONES',  'MANAGER',   7839, '1981-04-02', 2975,  NULL, 20),
(7654, 'MARTIN', 'SALESMAN',  7698, '1981-09-28', 1250,  1400, 30),
(7698, 'BLAKE',  'MANAGER',   7839, '1981-05-01', 2850,  NULL, 30),
(7782, 'CLARK',  'MANAGER',   7839, '1981-06-09', 2450,  NULL, 10),
(7788, 'SCOTT',  'ANALYST',   7566, '1982-12-09', 3000,  NULL, 20),
(7839, 'KING',   'PRESIDENT', NULL, '1981-11-17', 5000,  NULL, 10),
(7844, 'TURNER', 'SALESMAN',  7698, '1981-09-08', 1500,     0, 30),
(7876, 'ADAMS',  'CLERK',     7788, '1983-01-12', 1100,  NULL, 20),
(7900, 'JAMES',  'CLERK',     7698, '1981-12-03',  950,  NULL, 30),
(7902, 'FORD',   'ANALYST',   7566, '1981-12-03', 3000,  NULL, 20),
(7934, 'MILLER', 'CLERK',     7782, '1982-01-23', 1300,  NULL, 10);

-- 50.WAQTD ALL THE DEATILS OF EMPLOYEES WORKING AS SALESMAN IN THE DEPT 20 AnD
-- EARNING COMM MORE THAN SMITH AND HIRED AFTER KING.
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  AND deptno = 20
  AND comm > (
        SELECT COALESCE(comm, 0)
        FROM emp
        WHERE ename = 'SMITH'
    )
  AND hiredate > (
        SELECT hiredate
        FROM emp
        WHERE ename = 'KING'
    );
-- 51.WAQTD NAMES OF THE EMPLOYEES EARNING MORE THAN SMITH IN SALES DEPT.
SELECT ename
FROM emp
WHERE sal > (SELECT sal 
             FROM emp 
             WHERE ename = 'SMITH')
AND deptno = (SELECT deptno 
              FROM dept 
              WHERE dname = 'SALES');
-- 52.WAQTD DETAILS OF THE EMPLOYEES WORKING AS ANALYST IN THE LOCATION DALLAS.
SELECT *
FROM emp
WHERE job = 'ANALYST'
AND deptno = 
(
    SELECT deptno
    FROM dept
    WHERE loc = 'DALLAS'
);
-- 53.DISPLAY ALL THE EMPLOYEES WHOSE LOCATION NAME ENDING WITH 'S'.
SELECT *
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM dept
    WHERE loc LIKE '%S'
);
-- 54.WAQTD NAME , ANNUAL SALARY OF THE EMPLOYEES IF THEIR ANNUAL SALARY IS MORE
-- THAN ALL THE MANAGER.
select *
from emp
where (sal*12) > all (select (sal*12)
from emp
where job="manager");
-- 55.WAQTD DETAILS OF EMPLOYESS WHOSE HIREDATE GREATER THAN SALESMAN.
SELECT *
FROM emp
WHERE hiredate > ALL
(
    SELECT hiredate
    FROM emp
    WHERE job = 'SALESMAN'
);
-- 57.WAQTD THE COUNT OF EMP IN EACH DEPT.
SELECT d.deptno,
       d.dname,
       (SELECT COUNT(*)
        FROM emp e
        WHERE e.deptno = d.deptno) AS emp_count
FROM dept d;

SELECT e.ename,
       (SELECT d.dname
        FROM dept d
        WHERE e.deptno = d.deptno)  as dept_name
FROM emp e;
-- 59.WAQTD SALARY GREATER THAN ALLEN AND SMITH.
SELECT *
FROM emp
WHERE sal > ALL
(
    SELECT sal
    FROM emp
    WHERE ename IN ('ALLEN','SMITH')
);
-- 60.WAQTD DETAILS OF AN EMPLOYEE WHOSE SALARY IS GREATER THAN ALLEN AFTER THE HIKE
-- OF 10%.
SELECT *
FROM emp
WHERE sal >(select sal+(sal* 0.10)
from emp 
where ename="Allen");

-- 61.WAQTD DEPARTMENT NAME OF THE EMPLOYEES WHO ARE HIRED AFTER TEH ALLEN INTO
-- SALES DEPARTMENT.
SELECT dname
FROM dept
WHERE deptno IN 
(
    SELECT deptno
    FROM emp
    WHERE hiredate > 
    (
        SELECT hiredate
        FROM emp
        WHERE ename = 'ALLEN'
    )
    AND deptno =
    (
        SELECT deptno
        FROM dept
        WHERE dname = 'SALES'
    )
);
-- 62.WAQTD JOINED DATE AND REPOTRTING MANAGER NUMBER IF AN EMPLOYEE WORKING IN BOSTON.
SELECT hiredate, mgr
FROM emp
WHERE deptno = 
(
    SELECT deptno
    FROM dept
    WHERE loc = 'BOSTON'
);
-- 63.WAQTD NAMES AND JOB OF AN EMPLOYEES IN EACH JOB IF THERE ARE TWO EMPLOYEES
-- NAME SHOULD STARTS WITH 'S' OR 'P'.
SELECT ename, job
FROM emp
WHERE (ename LIKE 'S%' OR ename LIKE 'P%')
AND job IN
(
    SELECT job
    FROM emp
    GROUP BY job
    HAVING COUNT(*) >= 2
);
-- 65.WAQTD EMP NAME, JOB, LOCATION OF ALL EMPLOYEES WHO ARE WORKING AS A
-- MANAGER AND WORKS AT CHICAGO.
select ename,job,(select loc
                  from dept
                  where deptno=e.deptno) as loc
from emp e
where job='MANAGER' and deptno=(select deptno
                  from dept
                  where loc="CHICAGO");
-- 66.LIST EMPLOYEES FROM SALES AND RESEARCH DEPARTMENT HAVING ATLEAST 2 REPORTING
-- EMPLOYEES.
SELECT *
FROM emp
WHERE deptno IN 
(
    SELECT deptno
    FROM dept
    WHERE dname IN ('SALES','RESEARCH')
)
AND empno IN
(
    SELECT mgr
    FROM emp
    GROUP BY mgr
    HAVING COUNT(*) >= 2
);
-- 67.DISPLAY THE LOCATION OF ALL THE DEPARTMENTS WHICH HAVE EMPLOYEES JOINED IN THE
-- YEAR 81.
SELECT loc
FROM dept
WHERE deptno IN
(
    SELECT deptno
    FROM emp
    WHERE YEAR(hiredate) = 1981
);
-- 68.WAQTD NAME OF THE EMPLOYEES EARNING SALARY MORE THAN THE ANALYST.
SELECT ename
FROM emp
WHERE sal > ALL
(
    SELECT sal
    FROM emp
    WHERE job = 'ANALYST'
);
-- 69.WAQTD NAME OF THE EMPLOYEES IF THE EMPLOYEE EARNS SALARY LESS THAN ATLEAST A
-- MANAGER.
SELECT ename
FROM emp
WHERE sal < ANY
(
    SELECT sal
    FROM emp
    WHERE job = 'MANAGER'
);
-- 70.WAQTD EMP NAMES IF EMPLOYEES ARE HIRED AFTER ALL THE EMPLOYEES OF DEPT 30.
SELECT ename
FROM emp
WHERE hiredate > 
(
    SELECT MAX(hiredate)
    FROM emp
    WHERE deptno = 30
);
-- 71.WAQTD DETAILS IF THE EMPLOYEES WORKING IN NEWYORK OR DALLAS.
SELECT *
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM dept
    WHERE loc IN ('NEW YORK','DALLAS')
);
-- 72.WAQTD LOC OF THE EMPLOYEES IF THEY EARN COMISSION IN DEPT 20.
SELECT loc
FROM dept
WHERE deptno IN
(
    SELECT deptno
    FROM emp
    WHERE comm IS NOT NULL
    AND deptno = 20
);
-- 73.WAQTD ALL THE DETAILS OF EMPLOYEES WORKING IN THE SAME DESIGNATION AS JONES
-- AND WORKS IN LOCATION CHICAGO.
SELECT *
FROM emp
WHERE job = 
(
    SELECT job
    FROM emp
    WHERE ename = 'JONES'
)
AND deptno =
(
    SELECT deptno
    FROM dept
    WHERE loc = 'CHICAGO'
);
-- 74.WAQTD NAMES OF THE EMPLOYEES WHO EARNING MORE THAN SCOTT.
SELECT ename
FROM emp
WHERE sal > 
(
    SELECT sal
    FROM emp
    WHERE ename = 'SCOTT'
);
-- 75.WAQTD NUMBER OF EMPLOYEES AND AVG SALARY NEEDED TO PAY THE EMPLOYEES WHOSE
-- SALARY GREATER THAN 3000 IN EACH DEPT.
SELECT deptno,
       COUNT(*) AS no_of_employees,
       AVG(sal) AS avg_salary
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM emp
    WHERE sal > 3000
)
AND sal > 3000
GROUP BY deptno;
-- 76.WAQTD ENAME AND SAL OF ALL THE EMPLOYEE WHO ARE EARNING MORE THAN CLARK
-- BUT LESS THAN CLARK.
SELECT ename, sal
FROM emp
WHERE sal > (SELECT sal 
             FROM emp 
             WHERE ename = 'CLARK')
and sal < (SELECT sal 
           FROM emp 
           WHERE ename = 'CLARK');
-- 77.WAQTD DETAILS OF ALL THE EMPLOYEES WORKING IN DEPT 30 AND WORKING IN THE SAME
-- DESIGNATION AS JAMES.
SELECT *
FROM emp
WHERE deptno = 30
AND job = (
    SELECT job
    FROM emp
    WHERE ename = 'JAMES'
);
-- 78.WAQTD NAME OF THE EMPLOYEES WHO'S NAME STARTS WITH 'B' AND WORK IN THE SAME DESIGNATION AS CLARK.
SELECT ename
FROM emp
WHERE ename LIKE 'B%'
AND job = (SELECT job
           FROM emp
           WHERE ename = 'CLARK');
-- 79.WAQTD LOC AND DNAME OF THE EMPLOYEES WHOS SALARY IS 1250 RUPEES.
SELECT loc, dname
FROM dept
WHERE deptno IN 
(
    SELECT deptno
    FROM emp
    WHERE sal = 1250
);
-- 80.WAQTD DNAME AND LOC OF THE EMPLOYEES WHO'S NAME HAS CHARACTER 'M' IN IT.
SELECT dname, loc
FROM dept
WHERE deptno IN 
(
    SELECT deptno
    FROM emp
    WHERE ename LIKE '%M%'
) and dname="IT";

