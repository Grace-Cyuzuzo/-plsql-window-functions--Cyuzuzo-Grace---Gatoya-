--window functions implementations
--Ranking functions
--use case: top number of patients depending on there visits
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

--PERCENT_RANK

SELECT patient_id,dept_id,
COUNT(*)AS total_visits,
PERCENT_RANK() OVER(
PARTITION BY dept_id
ORDER BY COUNT(*)DESC
)AS visitpercent_rank
FROM visits
GROUP BY patient_id, dept_id;

--Aggregate window functions
--Use case:running the totals and trends of how patients visit the hospital for each department depending on the date
--running totals of visits for each department
-- this shows how visits accumulate in the hospital over time for each department

SELECT dept_id,visit_date,
COUNT(*) OVER(
PARTITION BY dept_id
ORDER BY visit_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)AS total_visits
FROM visits
ORDER BY dept_id,visit_id;

--running the total of costs that came to the hospital for each department
--SUM()

SELECT dept_id,visit_date,Price_cost,
SUM(Price_cost)OVER(
PARTITION BY dept_id
ORDER BY visit_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)AS total_costs
FROM visits
ORDER BY dept_id,visit_id;

--Monthly average visit cost
--AVG()

SELECT DATE_TRUNC('month',visit_date)AS month,   --groups the cost by month
AVG(Price_cost)OVER(
PARTITION BY DATE_TRUNC('month',visit_date)
ORDER BY visit_date
)AS avg_monthly_cost
FROM visits
ORDER BY month;


--tracking the lowest Price_cost

SELECT visit_id, visit_date, Price_cost,
MIN(Price_cost)OVER(
ORDER BY visit_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)AS running_min_rows, MIN(Price_cost)OVER(
ORDER BY visit_date
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_min_range
FROM visits
ORDER BY visit_date;

--tracking the highest Price_cost

SELECT visit_id, visit_date, Price_cost,
MAX(Price_cost) OVER (
ORDER BY visit_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)AS running_max_rows,
MAX(Price_cost)OVER(
ORDER BY visit_date
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)AS running_max_range
FROM visits
ORDER BY visit_date;


--NAVIGATION window functions
-- Use case: Period-to-period analysis
--Use LAG() (previous value).
--Use LEAD() (next value).

--Compare Current Month with Previous (LAG)

WITH monthly_visits AS(
SELECT DATE_TRUNC('month', visit_date) AS month,
COUNT(*)AS total_visits
FROM visits
GROUP BY DATE_TRUNC('month', visit_date)
)
SELECT month,total_visits,
LAG(total_visits, 1) OVER (
ORDER BY month
)AS prev_month_visits
FROM monthly_visits
ORDER BY month;

--Compare Current Month with Next (LEAD)


WITH monthly_visits AS(
SELECT DATE_TRUNC('month', visit_date
)AS month,
COUNT(*)AS total_visits
FROM visits
GROUP BY DATE_TRUNC('month', visit_date)
)
SELECT month,total_visits,
LEAD(total_visits, 1) OVER (ORDER BY month
)AS next_month_visits
FROM monthly_visits
ORDER BY month;



--Calculating Month-over-Month Growth %

WITH monthly_visits AS (
SELECT DATE_TRUNC('month', visit_date) AS month,
COUNT(*) AS total_visits
FROM visits
GROUP BY DATE_TRUNC('month', visit_date)
)
SELECT month,total_visits,
LAG(total_visits, 1) OVER (ORDER BY month) AS prev_month_visits,
ROUND(
( (total_visits - LAG(total_visits, 1) OVER (ORDER BY month))::NUMERIC
/ NULLIF(LAG(total_visits, 1) OVER (ORDER BY month), 0) ) * 100
, 2) AS growth_percent
FROM monthly_visits
ORDER BY month;

--Distribution window functions
--use case:Patients segmentation
--NTILE(4)-divide patient into 4 equal groups(quartiles)
--CUME_DIST() -shows relative position as cumulative proportion


--Ntile(4) by the total cost

WITH patient_spending AS (
SELECT patient_id,
SUM(Price_cost) AS total_cost
FROM visits
GROUP BY patient_id
)
SELECT patient_id,total_cost,
NTILE(4) OVER (ORDER BY total_cost DESC) AS spending_quartile
FROM patient_spending
ORDER BY spending_quartile, total_cost;

--CUME_DIST()– Calculating Cumulative Distribution of Visit Costs


SELECT visit_id, patient_id, Price_cost,
CUME_DIST() OVER (ORDER BY Price_cost DESC) AS cost_cume_dist
FROM visits
ORDER BY Price_cost DESC;
