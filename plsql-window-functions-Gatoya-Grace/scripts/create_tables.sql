--Patients information table

CREATE TABLE patients_info 
(
patient_id SERIAL PRIMARY KEY, --Auto incrementing
patient_fname VARCHAR(100),
patient_lname VARCHAR(100),
Birth_date DATE,
Gender VARCHAR(10),
Address VARCHAR(100)
);

-- Departments in the Hospital information table

CREATE TABLE departments
(
dept_id SERIAL PRIMARY KEY,
dept_name VARCHAR(50)
);

-- Visits of patients in the hospital information table

CREATE TABLE visits
(
visit_id SERIAL PRIMARY KEY,
patient_id INT REFERENCES patients_info(patient_id),
dept_id INT REFERENCES departments(dept_id),
visit_date DATE,
treatment VARCHAR(100),
price_cost NUMERIC(10,2)
);
--inserting values in the Patients_info table

INSERT INTO patients_info(patient_fname,patient_lname,birth_date,Gender,Address)
VALUES ('Esther','MUGISHA','1999-07-20','Female','Ndera'),
       ('Sam','NSHUTI','1996-03-30','Male','Kicukiro'),
	   ('Francois','NKUNDIMANA','1990-01-01','Male','Gasogi'),
	   ('Odette','IGIHOZO','1987-08-29','Female','Kacyiru'),
	   ('Ines','IHOGOZA','2010-04-30','Female','Gikondo'),
	   ('Grace','CYUZUZO','2008-07-11','Female','Nyamirambo'),
	   ('Bosco','NGENZI','1998-05-12','Male','Masoro');

	   
--inserting values in the Departments table

INSERT INTO departments(dept_name)
VALUES('Surgery'),
      ('Cardiology'),
	  ('Maternity'),
	  ('Pediatrics'),
	  ('Optics');

SELECT*FROM Patients_info;
SELECT*FROM Departments;

--inserting values in the Visits table

INSERT INTO visits(patient_id,dept_id,visit_date,treatment,Price_cost)
VALUES (1,4,'2025-01-02','Check up',15000),
       (2,2,'2025-01-26','Heart scan',10500),
	   (4,3,'2025-02-05','Normal Delivery',150000),
	   (1,1,'2025-03-01','Surgery Prep',20000),
	   (5,5,'2025-03-12','Eye Checkup',1250),
	   (1,3,'2025-03-27','Normal Delivery',150000),
	   (7,2,'2025-04-12','Angiopasty',3572),
	   (3,5,'2025-05-16','Cataract Surgery',12000),
	   (6,4,'2025-07-19','Checkup',15000),
	   (2,5,'2025-07-31','Eye Checkup',1250);


SELECT*FROM visits;
