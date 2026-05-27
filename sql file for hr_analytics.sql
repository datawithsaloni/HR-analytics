
use hr_analytics;

select count(EmployeeNumber) from hr_1;
select count(MonthlyIncome) from hr_2;
select count(distinct EmployeeNumber) 
from hr_combined;

show tables;

select * from hr_1 limit 10;
select * from hr_2 limit 10;

SHOW COLUMNS FROM hr_2;

ALTER TABLE hr_2
CHANGE `EmployeeID` Employee_ID INT;

create view  hr_combined as 
select * from 
hr_1 as h1 join hr_2 as h2 on h1.EmployeeNumber=h2.Employee_ID;

-- 1. Average attrition rate by department--
select department,
	round(count(case when Attrition='Yes' then 1 end)*100 / count(*),2) as Attrition_rate
from hr_combined
group by department;

-- 2. Average hourly rate of male research scientist --
Select 
	round(AVG(HourlyRate),0) as Avg_hourly_rate
from hr_combined
where Gender = 'Male'
and JobRole = 'Research Scientist';

-- 3. Attrition Rate vs Monthly Income --
SELECT 
CASE
    WHEN MonthlyIncome < 3000 THEN 'Low Income'
    WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Income'
    ELSE 'High Income'
END AS Income_Group,
ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2
) AS Attrition_rate
FROM hr_combined
GROUP BY Income_Group
ORDER BY Income_Group;


-- 4. Average working years for each department --
select
	department,
	round(avg(TotalWorkingYears),0) as Avg_working_years
from hr_combined
group by department;

-- 5.  job role vs Worklife balance
select	JobRole,
    round(avg(WorkLifeBalance),2) as Avg_work_life_balance
from hr_combined
group by JobRole
order by Avg_work_life_balance desc;

-- 6. attrition rate vs year since last promotion relation --
select
YearsSinceLastPromotion,
round(
count(case when Attrition='Yes' then 1 end)*100/count(*),2
) as Attrition_Rate
from hr_combined
group by YearsSinceLastPromotion
order by YearsSinceLastPromotion;

