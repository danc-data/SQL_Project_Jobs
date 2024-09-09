/*
Question: What are the most in-demand skills for data analysts?
- Join job postings similar to Query 2.
- Identify the top 5 in-demand skills for data analysts. 
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job-seeking data analysts.
*/


WITH jobs_per_skill_id AS (
    SELECT 
        skills_job_dim.skill_id,
        COUNT(job_postings_fact.job_id) AS job_count
    FROM skills_job_dim
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY skill_id
)

SELECT 
    skills_dim.skills,
    jobs_per_skill_id.job_count
FROM skills_dim
INNER JOIN jobs_per_skill_id ON jobs_per_skill_id.skill_id = skills_dim.skill_id
ORDER BY job_count DESC
LIMIT 5;


/*
Therefore, according to the data and the code above, the 5 most in-demand skills for data analysts are as follows:
    1. SQL
    2. Excel
    3. Python
    4. Tableau
    5. Power BI
*/