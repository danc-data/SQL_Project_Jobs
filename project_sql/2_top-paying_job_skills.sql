/*
Question: What skills are required for the top-paying data analsyst jobs?
- Use the highest-paying Data Analyst jobs from the first query. 
- Add the specific skills required for those jobs
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries.
*/



WITH top_paying_jobs_skills AS (
    WITH top_paying_jobs AS (
        SELECT 
            job_id,
            job_title,
            company_dim.name AS company_name,
            salary_year_avg
        FROM 
            job_postings_fact
        LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
        WHERE
            job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL AND
            job_location IN ('Anywhere', 'United Kingdom')
        ORDER BY
            salary_year_avg DESC
        LIMIT 100
)

    SELECT 
        top_paying_jobs.*,
        skills_dim.skills
    FROM top_paying_jobs
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
)

SELECT 
    skills,
    COUNT(job_id) AS skill_demand
FROM top_paying_jobs_skills
GROUP BY 
    skills
ORDER BY skill_demand DESC
LIMIT 10


/*

The code above shows us the following highest-demand skills based on the top 100 highest-paying jobs for me in 2023:
    1. SQL - 74
    2. Python - 50
    3. Tableau -39
    4. R - 33
    5. SAS - 28
    6. Excel - 26
    7. Power BI - 19
    Etc.

Note: I edited the first query in the nested CTE to include the top 100 highest-paying jobs that suit my needs.
    With a larger sample size, this helps add more certainty to our results. 

*/