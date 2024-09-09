/*
Question: What are the top-paying data analyst jobs relevant to me?
- Identify the top 10 highest-paying data analyst roles that are available remotely and locally. 
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying, most-accessible opportunities for data analysts, offering insights into the optimal employment opportunities to target. 
*/

SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    salary_year_avg,
    job_schedule_type,
    job_location
FROM 
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location IN ('Anywhere', 'United Kingdom')
ORDER BY
    salary_year_avg DESC
LIMIT 10;
