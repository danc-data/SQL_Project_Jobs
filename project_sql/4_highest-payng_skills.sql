/*
Question: What are the highest-paying skills?
- Find the average salary associated with each skill for data analyst positions. 
- Focus on roles with specified salaries, regardless of location.
- Why? It reveals the most financially rewarding skills to help make informed decisions for career progression.
*/

SELECT 
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON  skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
ORDER BY
    avg_salary DESC
LIMIT 25

/*
The results show the highest-paying skills are far from the most generally in demand.
A quick third-party analysis of the results shows us that specialist knowledge, like big data and machine 
    learning skills appear to be very well-paid, along with 
    software development & deployment skills, and cloud computing expertise.
*/


