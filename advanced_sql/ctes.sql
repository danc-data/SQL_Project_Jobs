WITH skill_job_count AS (
    SELECT 
        skill_id,
        COUNT(*) AS total_jobs
    FROM 
        skills_job_dim
    GROUP BY 
        skill_id
)

SELECT 
    skills_dim.skills,
    skill_job_count.total_jobs
FROM skills_dim
LEFT JOIN skill_job_count ON skill_job_count.skill_id = skills_dim.skill_id
ORDER BY total_jobs DESC;



WITH jobs_per_company AS(
    SELECT 
        company_id,
        COUNT(*) AS job_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name,
    jobs_per_company.job_count,
    CASE
        WHEN job_count < 10 THEN 'Small'
        WHEN job_count >= 10 AND job_count <= 50 THEN 'Medium'
        WHEN job_count > 50 THEN 'Large'
    END AS company_size
FROM
    company_dim
LEFT JOIN jobs_per_company ON jobs_per_company.company_id = company_dim.company_id




WITH jobs_per_skill_id AS (
    SELECT 
        skills_job_dim.skill_id,
        COUNT(*) AS job_count
    FROM skills_job_dim
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_postings_fact.job_work_from_home = TRUE AND
        job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY skill_id
)

SELECT 
    skills_dim.skills,
    jobs_per_skill_id.job_count
FROM skills_dim
INNER JOIN jobs_per_skill_id ON jobs_per_skill_id.skill_id = skills_dim.skill_id
ORDER BY job_count DESC;