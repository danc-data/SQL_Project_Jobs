SELECT skills,
    type,
    q1_job_postings.job_id,
    job_title_short
FROM (

    SELECT *
    FROM january_jobs

    UNION ALL

    SELECT *
    FROM february_jobs

    UNION ALL

    SELECT *
    FROM march_jobs

) AS q1_job_postings

LEFT JOIN skills_job_dim ON skills_job_dim.job_id = q1_job_postings.job_id
LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE salary_year_avg > 70000;