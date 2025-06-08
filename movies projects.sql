use try to import
go 
select * from [dbo].[ks-projects-201612]
--select movies with USD currency
select name ,currency
from [dbo].[ks-projects-201612]
where currency ='USD'

-- select the most distinct projects that watched in usd currency

select distinct name ,currency ,country
from [dbo].[ks-projects-201612]
where currency='USD'
group by name ,currency ,country

-- What are the top 10 projects with the highest total pledged amount (usd pledged)?

SELECT TOP 10 name, [usd pledged]
FROM [dbo].[ks-projects-201612]
ORDER BY [usd pledged] DESC;

-- How many projects were launched in each category 

SELECT category, COUNT(*) AS project_count 
FROM [dbo].[ks-projects-201612]
GROUP BY category
ORDER BY project_count DESC;

-- What is the average funding goal (goal) for projects in each category?

select category, AVG(goal) as ave_goal
from [dbo].[ks-projects-201612]
group by category
ORDER BY average_goal DESC;


-- What is the success rate of projects based on their state (e.g., successful, failed)?

SELECT 
    state,
    COUNT(*) AS project_count
FROM [dbo].[ks-projects-201612]
GROUP BY state

--How many projects are currently in the "failed" state?

select count(*) state 
from [dbo].[ks-projects-201612]
where state= 'failed'

--What are the top 5 projects by the amount pledged?

select top 5 pledged
from [dbo].[ks-projects-201612]

-- What is the average pledged amount for projects in each main category?

select avg(pledged)
from [dbo].[ks-projects-201612]
group by main category

--How many projects have been successfully funded and had a goal of over $10,000?

select *
from [dbo].[ks-projects-201612]

SELECT COUNT(*) AS fully_funded 
FROM [dbo].[ks-projects-201612] 
WHERE state = 'successful' AND CAST(goal AS decimal(10, 2)) > 10000;

SELECT name FROM projects ORDER BY backers DESC LIMIT 1;

--Which project has the highest number of backers?

SELECT TOP 1 name 
FROM [dbo].[ks-projects-201612]
ORDER BY backers DESC;

select count(*) 
from  [dbo].[ks-projects-201612]
where state='failed' and state ='Successful'

-- What is the average goal for successful projects compared to unsuccessful ones?

SELECT state, COUNT(*) AS project_count 
FROM [dbo].[ks-projects-201612]
WHERE state IN ('failed', 'successful')
GROUP BY state;

