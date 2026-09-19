--Retrieve information for all TABLES
SELECT *
FROM admission_type;

SELECT *
FROM departments;

SELECT *
FROM diagnosis;

SELECT *
FROM doctors;

SELECT *
FROM hospitals;

SELECT *
FROM insurance_provider;

SELECT *
FROM admission_type;

SELECT *
FROM lumina_healthcare;

SELECT *
FROM patients;

-- the first 100 patient admissions, ordered chronologically.
SELECT *
FROM lumina_healthcare
ORDER BY admission_date ASC
LIMIT 100;

--the total number of admissions recorded
SELECT COUNT(admission_id) AS Total_Admission
FROM lumina_healthcare;

--total number of patients
SELECT COUNT(patient_id)
FROM patients;

--analysis of emergency admissions, including the total volume and corresponding
--admission records, to assess emergency care demand and support resource planning.
SELECT *
FROM lumina_healthcare
WHERE admission_type_id = 'ADT1001';

-- 2024V ADMISSION
SELECT *
FROM lumina_healthcare
WHERE admission_date BETWEEN '2023-12-31' AND '2024-12-31'
ORDER BY admission_date ASC;

--Total 2024 Admission
SELECT COUNT(admission_date) AS Total_Admission
FROM lumina_healthcare
WHERE admission_date BETWEEN '2023-12-31' AND '2024-12-31';

--organization's overall operational and financial performance by analyzing key performance indicators,
--including average length of stay (LOS), average recovery rate, total healthcare charges,
--total insurance covered amounts, and the percentage of charges funded by insurance providers.

SELECT 
	ROUND(AVG(length_of_stay)) AS "AVG length of Stay",
	ROUND(AVG(recovery_rate),2)AS "AVG Recovery Rate",
	sum(total_charge) AS "Total Charges",
	sum(insurance_covered_amount) AS "Total Insurance Paid",
	ROUND(sum(insurance_covered_amount)/sum(total_charge),2) * 100 AS "% Insurance charged",
	ROUND(sum(patient_paid)/sum(total_charge), 2) * 100 AS "% Patient Paid"
FROM lumina_healthcare;

--DEPT WITH HIGHEST RECOVERY RATE
SELECT 
	l.department_id,
	d.department_name,
	ROUND(AVG(l.recovery_rate),2)AS "AVG Recovery Rate"
FROM lumina_healthcare l
JOIN departments d ON
d.department_id = l.department_id
GROUP BY l.department_id, d.department_name
ORDER BY ROUND(AVG(recovery_rate),2)DESC;

-- Revenue by department > 68.5million
SELECT 
	l.department_id,
	d.department_name,
	ROUND(sum(l.income),2)AS "Revenue"
FROM lumina_healthcare l
JOIN departments d ON
d.department_id = l.department_id
GROUP BY l.department_id, d.department_name
HAVING sum(l.income) > 68500000
ORDER BY sum(l.income);

 -- Patients readmitted
 SELECT *
 FROM lumina_healthcare
 WHERE readmitted_30_days = 'Yes';
 
-- readmission rate
  SELECT 
  	Count(CASE WHEN readmitted_30_days = 'Yes' THEN 1 END) AS "Readmission",
  	COUNT(admission_id) AS "Total Admission",
	CAST(Count(CASE WHEN readmitted_30_days = 'Yes' THEN 1 END) AS Decimal)/COUNT(admission_id) * 100 AS "Readmission Rate",
	  	Count(CASE WHEN readmitted_30_days = 'Yes' THEN 1 END) *100/
  	COUNT(admission_id) AS "REAdmission Rate"
 FROM lumina_healthcare;

 --Readmission across Hospitals and departments

 SELECT
 	hospital_name, department_name,
	ROUND(CAST(Count(CASE WHEN readmitted_30_days = 'Yes' THEN 1 END) AS Decimal)/
	COUNT(admission_id) * 100,2) AS "Readmission Rate"
FROM lumina_healthcare l
JOIN hospitals h
ON h.hospital_id = l.hospital_id
JOIN departments d
ON d.department_id = l.department_id
GROUP BY h.hospital_name,d.department_name
ORDER BY 1;

--Age grouping of patients
SELECT *,
	CASE
	WHEN age BETWEEN 0 AND 17 THEN 'Child'
	WHEN age BETWEEN 18 AND 40 THEN 'Adult'
	WHEN age BETWEEN 0 AND 70 THEN 'Senior'
	ELSE 'Older Patients'
	END AS "Age Group"
FROM patients;

--Admission by age GROUP
SELECT CASE
	WHEN age BETWEEN 0 AND 17 THEN 'Child'
	WHEN age BETWEEN 18 AND 40 THEN 'Adult'
	WHEN age BETWEEN 0 AND 70 THEN 'Senior'
	ELSE 'Older Patients'
	END AS "Age Group",
	COUNT(admission_id)
FROM lumina_healthcare l
JOIN patients p
USING(patient_id)
GROUP BY 1
ORDER BY 2 DESC;

-- ADMISSIONS BY YEAR AND MONTH
SELECT 
	EXTRACT(YEAR FROM admission_date) AS "Years",
	EXTRACT (Month FROM admission_date) AS "Months",
	TO_CHAR(admission_date,'Month') AS "Monthname",
	COUNT(admission_id) AS "Total Admissions"
FROM lumina_healthcare
GROUP BY 1,2,3
ORDER BY 1,2,3;

--Retrieve records where patient paid more than insurance covered

SELECT *
FROM lumina_healthcare
WHERE patient_paid > insurance_covered_amount;

--Identify patient paying more than insurance covered amount
SELECT
	p.patient_name,
	l.insurance_covered_amount,
	l.patient_paid
FROM lumina_healthcare l
JOIN patients p
ON p.patient_id = l.patient_id
WHERE l.patient_paid > l.insurance_covered_amount;

--Average Revenue
SELECT AVG(income) AS Average_Revenue
FROM lumina_healthcare;

-- Revenue greater than Average Revenue
SELECT *
FROM lumina_healthcare
WHERE income >(SELECT AVG(income) AS Average_Revenue
FROM lumina_healthcare);

--Recovery
SELECT *
FROM lumina_healthcare
WHERE recovery_rate >(SELECT AVG(recovery_rate) AS Average_Recovery_rate
FROM lumina_healthcare);
--Hospitals having total income above average income
SELECT h.hospital_name,
	SUM(l.income) AS Total_income
	FROM lumina_healthcare l
	JOIN hospitals h
	ON h.hospital_id = l.hospital_id
	GROUP BY 1
	HAVING SUM(l.income) > (select Avg(Total_income)
	FROM 
	(SELECT h.hospital_name,
	SUM(l.income) AS Total_income
	FROM lumina_healthcare l
	JOIN hospitals h
	ON h.hospital_id = l.hospital_id
	GROUP BY 1));