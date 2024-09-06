SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY 
    job_posted_count DESC;


SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS month
FROM 
    job_postings_fact
GROUP BY
    month
ORDER BY
    month ASC;


SELECT company_dim.name,
    job_postings_fact.job_health_insurance,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(YEAR FROM job_posted_date) AS year
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_health_insurance = TRUE AND
    EXTRACT(MONTH FROM job_posted_date) IN (4, 5, 6) AND
    EXTRACT(YEAR FROM job_posted_date) = 2023
LIMIT 100;