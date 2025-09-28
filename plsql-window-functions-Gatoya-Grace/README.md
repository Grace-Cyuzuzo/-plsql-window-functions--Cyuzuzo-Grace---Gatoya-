PLSQL Window Functions Project

Author: GATOYA CYUZUZO Grace
Date: 2025-09-29

1. Problem Statement

This project demonstrates the use of PLSQL window functions to analyze the hospital patients entered recorsds on how the visited the hospital in different months,
The goal is to compute trends, rankings, and aggregated insights across different data entered.

2. Database Schema
The database schema was implemented using the SQL script file: [create_tables.sql](scripts/create_tables.sql)

```sql
--snippet from create_table.sql

CREATE TABLE patients_info 
(
patient_id SERIAL PRIMARY KEY, --Auto incrementing
patient_fname VARCHAR(100),
patient_lname VARCHAR(100),
Birth_date DATE,
Gender VARCHAR(10),
Address VARCHAR(100)
);
```
3. Queries
[window.queries.sql](scripts/window.queries.sql)

```sql
--snippet from window.queries.sql
--ROW_NUMBER

SELECT patient_id,dept_id, 
COUNT(*) AS total_visits,
ROW_NUMBER() OVER(
PARTITION BY dept_id
ORDER BY COUNT(*) DESC
) AS RN
FROM visits
GROUP BY patient_id,dept_id;


--RANK

SELECT patient_id,dept_id,
COUNT(*)AS total_visits,
RANK() OVER(
PARTITION BY dept_id
ORDER BY COUNT(*)DESC
) AS  patientvisit_rank
FROM visits
GROUP BY patient_id,dept_id;

--DENSE_RANK()

SELECT patient_id, dept_id,
COUNT(*) AS total_visits,
DENSE_RANK() OVER(
PARTITION BY dept_id
ORDER BY COUNT(*)DESC
) AS visitdense_rank
FROM visits
GROUP BY patient_id,dept_id;
```

4. Results Analysis
Descriptive (What happened?)

Multiple patients visited different departments,for surgey and maternity departments showed higher costs compared to others.Vists generally increase over time.

Diagnostic (Why?)

High costs in Maternity and Surgery departments are due to the nature of treatments (deliveries, operations)and the peaks in visits could be linked to seasonal health patterns


Prescriptive (What next?)

Allocate more resources to the high-cost departments and monitor monthly fluctuations to improve staffing and resource planning.

5. Screenshots
[AVG()QUERY.PNG](screenshotS/AVG()QUERY.PNG)
[COST()QUERY.PNG](screenshots/COST()QUERY.PNG)
[CUM_DISTQUERY.PNG](screenshots/CUM_DIST QUERY.PNG)
[DENSE_RANKQUERY.PNG](screenshots/DENSE_RANKQUERY.PNG)
[GROWTH%()QUERY.PNG](screenshots/GROWTH%()QUERY.PNG)
[PERCENT_RANK QUERY.PNG](screenshots/PERCENT_RANK QUERY.PNG)
[LAG()QUERY.PNG](screenshots/LAG()QUERY.PNG)
[LEAD()QUERY.PNG](screenshots/LEAD()QUERY.PNG)
[MIN()QUERY.PNG](screenshots/MIN()QUERY.PNG)
[MAX()QUERY.PNG](screenshots/MAX()QUERY.PNG)
[NTILE() QUERY.PNG](screenshots/NTILE() QUERY.PNG)
[RANK QUEYR.PNG](screeshots/RANK QUEYR.PNG)
[ROW_NUM QUERY.PNG](screenshots/ROW_NUM QUERY.PNG)
[SUM()QUERY.PNG](screenshots/SUM()QUERY.PNG)
[PLSQL31.PNG](screenshots/PLSQL31.PNG)


6. References

PostgreSQL Window Functions Tutorial – https://www.postgresqltutorial.com/postgresql-window-function/

“SQL Window Functions: A Comprehensive Guide” – TutorialPoint

W3Schools SQL Tutorial – https://www.w3schools.com/sql/

Oracle PLSQL Documentation – https://docs.oracle.com/en/database/oracle/oracle-database/


“Analyzing Data with SQL Window Functions” – Medium Article

Academic Paper: “Window Functions in Database Systems” – ACM Digital Library

Stack Overflow discussions on window functions


Oracle Live SQL Examples – https://livesql.oracle.com/

Business Analytics Reports on Healthcare Databases

Any other relevant tutorial, article, or documentation



Statement on Originality:


“All sources were properly cited. Implementations and analysis represent original work. No AI generated content was copied without attribution or adaptation.”
