## HR Analytics SQL Project

This project analyzes HR employee data (IBM Employee Attrition dataset).
The goal is to explore employee performance, attrition, salaries, and promotions

🎯 Project Objectives

- Understand salary and attrition patterns.

- Identify top performers and promotion candidates.

- Compare departments on various HR metrics.

- Apply SQL intermediate techniques to real HR problems.

1-Find the average monthly income per department.

Select AVG(monthly_income) as AVG_monthly_Income,department
from [dbo].[hr (1)]
group by department

2- List departments where the average salary is higher than the company average (use subquery or CTE).

SELECT Department, AVG(monthly_income) AS Dept_Avg_Salary
FROM [dbo].[hr (1)]
GROUP BY Department
HAVING AVG(monthly_income) > (
    SELECT AVG(monthly_income) 
    FROM [dbo].[hr (1)]
);

3- Rank employees by MonthlyIncome within their department (using ROW_NUMBER).
SELECT 
    employee_number,
    Department,
    monthly_income,
    ROW_NUMBER() OVER(PARTITION BY Department ORDER BY monthly_income DESC) AS IncomeRank
FROM [dbo].[hr (1)];


4- Get the top 3 highest-paid employees in each department.

WITH RankedSalaries AS (
    SELECT 
         employee_number,
        Department,
        monthly_income,
        ROW_NUMBER() OVER(PARTITION BY Department ORDER BY  monthly_income DESC) AS RankInDept
    FROM [dbo].[hr (1)]
)
SELECT employee_number, Department,  monthly_income, RankInDept
FROM RankedSalaries
WHERE RankInDept <= 3;


5-Find the attrition rate (%) by department.

SELECT 
    Department,
    100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*) AS AttritionRate
FROM [dbo].[hr (1)]
GROUP BY Department;

6-Compare each employee’s MonthlyIncome with the previous employee

SELECT 
    employee_number,
   monthly_income,
    LAG(monthly_income, 1) OVER (ORDER BY monthly_income) AS PrevIncome,
    monthly_income - LAG(monthly_income, 1) OVER (ORDER BY monthly_income) AS DiffFromPrev
FROM [dbo].[hr (1)];


7 Show each employee’s salary and the next higher salary in the company
SELECT 
    employee_number,
    monthly_income,
    LEAD(monthly_income, 1) OVER (ORDER BY monthly_income) AS NextIncome,
    LEAD(monthly_income, 1) OVER (ORDER BY monthly_income) - monthly_income AS DiffToNext
FROM [dbo].[hr (1)];
select * from [dbo].[hr (1)];

8. Find the average distance from home for employees who travel frequently vs. those who travel rarely.

SELECT 
    business_travel,
    AVG(distance_from_home) AS Avg_Distance
FROM [dbo].[hr (1)]
GROUP BY business_travel;

9. List the top 5 employees with the highest distance from home in each department.

WITH RankedDistances AS (
    SELECT 
        employee_number,
        Department,
        distance_from_home,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY distance_from_home DESC) AS RankInDept
    FROM [dbo].[hr (1)]
)
SELECT 
    employee_number,
    Department,
    distance_from_home,
    RankInDept
FROM RankedDistances
WHERE RankInDept <= 5;

10. Calculate the percentage of employees in each EducationField who have left the company (Attrition = 1)
SELECT 
    education_field,
    CAST(ROUND(
        100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 
        2
    ) AS DECIMAL(5,2)) AS AttritionRatePercent
FROM [dbo].[hr (1)]
GROUP BY education_field;