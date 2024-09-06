SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category;



SELECT 
    job_id,
    CASE
        WHEN salary_year_avg < 70000 THEN 'Low-Pay'
        WHEN salary_year_avg >= 70000 AND salary_year_avg < 100000 THEN 'Mid-Pay'
        WHEN salary_year_avg >= 100000 THEN 'High-Pay'
        ELSE 'High-Pay'
    END AS salary_group
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;




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
