CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    appointment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

INSERT INTO patients (patient_id, name) VALUES
(1, 'Ravi'),
(2, 'Sita'),
(3, 'John'),
(4, 'Priya'),
(5, 'Kiran');
 INSERT INTO patients (patient_id, name) 
VALUES (6, 'Anil');

INSERT INTO appointments (appointment_id, patient_id, appointment_date) VALUES
(101, 1, '2026-03-01'),
(102, 1, '2026-03-10'),
(103, 2, '2026-03-02'),
(104, 3, '2026-03-05'),
(105, 3, '2026-03-08'),
(106, 3, '2026-03-15'),
(107, 4, '2026-03-20'),
(108, 5, '2026-03-22'),
(109, 5, '2026-03-23');
select * from patients;
select * from appointments;
--q1.Show patients who have appointments using IN
select *
from patients
where patient_id in (
select patient_id
from appointments
);
--q2.Show patients who do NOT have appointments
select *
from patients
where patient_id not in(select patient_id 
from appointments);
--note:OT IN can be dangerous if there are NULL values in the subquery. 

--Use NOT EXISTS (safe and optimized):
select *
from patients p
where not exists (select 1 
 from appointments a
 where a.patient_id=p.patient_id);

--q3. Show patients who have more than 1 appointment

--👉 Use subquery + COUNT + GROUP BY
select*
from patients
where patient_id in(
select patient_id
 from appointments
 group by patient_id
 having COUNT(*)>1);

 --Q4. Pattern 5: MAX (Highest)
 select *
 from patients
 where patient_id in(
 select patient_id
 from appointments
 group by patient_id
 having count(*)=(
 select max(cnt)
 from (
 select COUNT(*) as cnt
 from appointments
 group by patient_id) t
 )
 );

 --Q5.Show patients who have 
 --more than 2 appointments using a subquery.
 select *
 from patients
 where patient_id in(
 select patient_id
 from appointments
 group by patient_id
 having count(*)>2);
 
select *
from patients
where patient_id in 
(select patient_id
from appointments
group by patient_id
having count(*)>(select COUNT(*)
 from appointments
 where patient_id=1
 group by patient_id))

--Pattern 7: Compare with Specific Value (Ravi)
 SELECT *
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM appointments
    GROUP BY patient_id
    HAVING COUNT(*) = (
        SELECT COUNT(*)
        FROM appointments
        WHERE patient_id = (
            SELECT patient_id 
            FROM patients 
            WHERE name = 'Ravi'
        )
    )
);


-----JOINS------
--Q.sjow patients having more than one appointment
SELECT p.*
FROM patients p
JOIN appointments a
ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.name
HAVING COUNT(*) > 1;

--q.Using JOIN, show patients who have NO appointments
--👉 (Hint: use LEFT JOIN + NULL check)
SELECT p.*
FROM patients p
LEFT JOIN appointments a
ON p.patient_id = a.patient_id
where a.patient_id is null;

--q.find the highest appointments using JOIN question.

SELECT p.*
FROM patients p
JOIN appointments a
ON p.patient_id = a.patient_id
group by p.patient_id,p.name
having COUNT(*)=(select max(cnt)
from(select COUNT(*) as cnt
from appointments
group by patient_id)t
);

