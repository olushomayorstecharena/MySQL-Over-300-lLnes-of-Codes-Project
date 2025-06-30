-- Total view of data set
SELECT *
FROM luke.luke_excel_sql;

-- the unique conut of job seeker
select distinct
	job_title_short,
	count(*) job_title_short_count
from 
	luke.luke_excel_sql
group by 
	job_title_short
order by job_title_short_count desc
limit 10;

-- Platform that job seeker that get job opppurtunity the most. The answer is Linkdein
select distinct
	job_via,
	count(*) job_via_count
from 
	luke.luke_excel_sql
group by 
	job_via
order by job_via_count desc;

-- The total number of Senior Data Engineer or Data Engineer that got their job through linkedin nd their salary
SELECT distinct
	job_title_short, 
	job_via, 
	job_location, 
	salary_year_avg
FROM 
	luke.luke_excel_sql
WHERE (job_title_short = "Senior Data Engineer" or "Data Engineer") 
and job_via = "via LinkedIn"
order by 
	salary_year_avg desc;

-- The total number of Senior Data Scientist or Data Scientist that got their job through linkedin nd their salary
SELECT distinct
	job_title_short, 
	job_via, 
	job_location, 
	salary_year_avg
FROM 
	luke.luke_excel_sql
WHERE (job_title_short = "Senior Data Scientist" or "Data Scientist") 
and job_via = "via LinkedIn"
order by 
	salary_year_avg desc;

-- Data Analysts that get their job throungh ziprecruiter
select 
	job_title_short, 
	job_via, 
	count(job_via) 
from 
	luke.luke_excel_sql
where 
	job_title_short = 'Data Analyst'
group by
	job_title_short, 
	job_via
having 
	job_via = 'via ZipRecruiter';

-- The total number of Senior Data Analysts or Data Analysts that got their job through linkedin nd their salary
SELECT 
	job_title_short, 
	job_via, 
	job_location, 
	salary_year_avg
FROM 
	luke.luke_excel_sql
WHERE 
	(job_title_short = "Senior Data Analyst" or "Data Analyst") 
and 
	job_via = 'via LinkedIn'
order by 
	salary_year_avg desc;
    
-- Data Analysts that work in United Stated and they are full time and their salary is greater than $70000
SELECT 
	job_title_short, 
	Job_schedule_type,
	Job_country, 
	salary_year_avg
from 
	luke.luke_excel_sql
where 
	(job_country = "United States" and job_title_short = 'Data Analyst') 
and salary_year_avg > 70000 
order by 
	salary_year_avg desc;

-- employees that got employed throug ZipRecruiter 
select 
	job_title_short, 
	job_via, 
	count(job_via) job_via_count
from 
	luke.luke_excel_sql
where 
	job_via = 'via ZipRecruiter'
group by
	job_title_short, 
	job_via
order by 
	job_via_count desc;

select distinct 
	job_title_short, 
	job_via,  
	count(*) job_via_count
from 
	luke.luke_excel_sql
group by 
	job_title_short
order by 
	job_via_count desc;

--  Maximum and average salary of employees
select distinct 
	job_title_short, 
	MAX(salary_year_avg) as max_sal,
    avg(salary_year_avg) as avg_salary
from 
	luke.luke_excel_sql
group by 
	job_title_short
order by 
	max_sal desc, avg_salary;

-- full time workers in US
select count(*) full_time_workers_in_US
from (
SELECT 
	job_country,
	job_schedule_type
FROM 
	luke.luke_excel_sql
WHERE 
	job_country = "United States"     
AND job_schedule_type = "Full-time" ) full_time_workers_in_US; 


-- Count of full time workers across the world (top 10)
SELECT
	job_country,
	job_schedule_type,
	count(job_country) job_country_fulltime_count
FROM 
	luke.luke_excel_sql
WHERE 
	job_schedule_type = "Full-time"  
group by 
	job_country,
	job_schedule_type
order by 
	job_country_fulltime_count desc
limit 
	10;
    
-- The result that shows that part time workers do noot enjoy health insurance
SELECT 
	job_country,
	job_schedule_type,
    job_health_insurance,
	count(job_health_insurance) job_health_insurance_count
FROM luke.luke_excel_sql
where 
	job_schedule_type = "Contractor"
    and job_health_insurance != "TRUE"
group by job_country,
	job_schedule_type,
    job_health_insurance
order by job_health_insurance_count desc
limit 10;

-- Companies that employ data analysts based on hierarchy
select 
	job_title_short,
	job_country,
	company_name,
	count(company_name) AS company_count
from 
	luke.luke_excel_sql
where 
	job_title_short = "Data Analyst"
group by
	job_title_short,
	job_country,
	company_name
order by company_count desc;

-- Companies that employ and positions they employ most based on hierarchy
select distinct
	job_title_short,
	company_name,
	count(company_name) AS company_count
from 
	luke.luke_excel_sql
group by
	job_title_short,
	company_name
order by 
	company_count desc
limit 15;

-- count of full time workers
select count(job_schedule_type) full_time_workers_count
from(
select
	job_title_short,
	job_schedule_type,
	job_work_from_home
from luke.luke_excel_sql
where
	job_schedule_type = "Full-time"
    and job_work_from_home != "False"
group by job_title_short,
	job_schedule_type,
	job_work_from_home) total_work_at_home;

-- highly paid workers indicating layoff
select count(*)
from(
 select  job_title_short, salary_year_avg 
from 
	luke.luke_excel_sql
where 
	(job_title_short = "Senior Data Analyst" or  "Data Analyst") 
and 
	salary_year_avg > 100000  
union
select  
	job_title_short, salary_year_avg 
from 
	luke.luke_excel_sql
where 
	(job_title_short = "Senior Data Engineer" or  "Data Engnineer") 
and  salary_year_avg > 100000) as highy_paid_analysts;

-- hourly paid workers 
SELECT distinct 
	job_title_short, 
    job_country, 
	salary_rate, 
   salary_hour_avg
FROM 
	luke.luke_excel_sql
where 
	salary_rate = "hour"
order by 
	salary_hour_avg desc; 

-- monthly paid workers
SELECT distinct 
	job_title_short, 
    job_country, 
	salary_rate, 
    salary_year_avg
FROM 
	luke.luke_excel_sql
where 
	salary_rate != "hour"
order by 
	salary_year_avg desc; 

-- Analystical tools you need to know as a data analysts
SELECT  distinct
	job_title_short, 
    custom,
    count(custom) custom_count,
    RANK() OVER (PARTITION BY job_title_short ORDER BY COUNT(custom) DESC) AS rank_within_title
from 
	luke.luke_excel_sql
where 
	job_title_short = "Senior Data Analyst" 
    or job_title_short = "Data Analyst"
group by 
	job_title_short, custom
order by 
	custom_count desc
limit 10;

-- top 10 tools you need to master well as a data engineer
SELECT  distinct
	job_title_short, 
    custom,
    count(custom) custom_count,
    RANK() OVER 
		(PARTITION BY job_title_short ORDER BY COUNT(custom) DESC) AS rank_within_title
from 
	luke.luke_excel_sql
where 
	job_title_short = "Senior Data Engineer" 
    or job_title_short = "Data Engineer"
group by 
	job_title_short, custom
order by 
	custom_count desc
limit 10;

-- top 10 tools you need to master well as a data scientist
SELECT  distinct
	job_title_short, 
    custom,
    count(custom) custom_count,
    RANK() OVER 
	(PARTITION BY job_title_short ORDER BY COUNT(custom) DESC) AS rank_within_title
from 
	luke.luke_excel_sql
where 
	job_title_short = "Senior Data Scientist" 
    or job_title_short = "Data Scientist"
group by 
	job_title_short, custom
order by 
	custom_count desc
limit 10;
