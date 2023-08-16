-- QUESTIONS
USE projects;
-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS Count
FROM humanresources
WHERE age >= 18  and termdate IS NULL
GROUP BY gender;


-- 2. What is the race/ethnicity breakdown of employees in the company?
select race,COUNT(*) AS Count
FROM humanresources
WHERE age >= 18  and termdate IS NULL
GROUP BY race
ORDER BY COUNT(*) Desc;

-- 3. What is the age distribution of employees in the company?
select
     min(age) as youngest,
     max(age) as oldest
FROM humanresources
WHERE age >= 18  and termdate IS NULL;

SELECT AGE
FROM humanresources;

SELECT CASE
    WHEN age >=18 and age<=24 Then '18-24'
	WHEN age >=25 and  age <=34 Then '25-34'
    WHEN age >=35  and  age<=44 Then '35-44'
    WHEN age >=45  and  age <=54 Then '	45-54'
    ELSE '55+'
END  AS age_group,
count(*) As count
From humanresources
WHERE age >= 18  and termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

SELECT CASE
    WHEN age >=18 and age<=24 Then '18-24'
	WHEN age >=25 and  age <=34 Then '25-34'
    WHEN age >=35  and  age<=44 Then '35-44'
    WHEN age >=45  and  age <=54 Then '	45-54'
    ELSE '55+'
END  AS age_group,gender,
count(*) As count
From humanresources
WHERE age >= 18 and termdate IS NULL
GROUP BY age_group,gender
ORDER BY age_group,gender;
    
-- 4. How many employees work at headquarters versus remote locations?
SELECT location,count(*) As count
From humanresources
WHERE age >= 18 and termdate IS NULL
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
select 
round(avg(datediff(termdate,hire_date))/365,0) as avg_length_employment
From humanresources
Where termdate <=curdate() AND termdate is not null and age >= 18;


-- 6. How does the gender distribution vary across departments and job titles?
select department,gender, COUNT(*) AS count
from humanresources
WHERE age >= 18  and termdate IS NULL
GROUP BY  department,gender
ORDER BY  department;

-- 7. What is the distribution of job titles across the company?
select jobtitle, COUNT(*) AS count
from humanresources
WHERE age >= 18  and termdate IS NULL
GROUP BY  jobtitle
ORDER BY  jobtitle desc;

-- 8. Which department has the highest turnover rate?
SELECT department,
      total_count,
      terminated_count,
      terminated_count/total_count AS termination_rate
From(
   SELECT department,
   count(*) as total_count,
   SUM(CASE WHEN termdate is Not null and termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
   from humanresources
   WHERE age >= 18  
   group by department
) AS subquery
ORDER BY termination_rate DESC;
   
-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state,COUNT(*) AS count
from humanresources
WHERE age >= 18  and termdate IS NULL
GROUP BY  location_state
ORDER BY  count desc;


-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT 
   year,
   hires,
   terminations,
   hires-terminations AS net_change,
   round((hires-terminations)/hires*100,2) AS net_change_percent
   FROM(
   SELECT year(hire_date) AS year,
   count(*) as hires,
   SUM(case when termdate is not null and termdate <=curdate() THEN 1 ELSE 0 END) AS terminations
   from humanresources
WHERE age >= 18  
GROUP BY year(hire_date)
)AS subquery
ORDER BY year ASC;

-- 11. What is the tenure distribution for each department?
SELECT department,round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
    from humanresources
    WHERE termdate <= curdate() AND termdate is not null AND age >= 18
	GROUP BY department;