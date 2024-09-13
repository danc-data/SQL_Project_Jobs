/*
Question: Wht are the most optimal skills to learn by the criteria of combined high-demand and high-paying?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Focus on accessible positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial incentive (high salary,)
    offering strategic insights for career development in data analysis.
*/

-- Please scroll down if you want to see the concise, final code.

-- Using the code from (3), we create a new CTE for skill demand. 

WITH skill_demand AS (
    WITH jobs_per_skill_id AS (
        SELECT 
            skills_job_dim.skill_id,
            COUNT(job_postings_fact.job_id) AS job_count
        FROM skills_job_dim
        INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
        WHERE 
            job_postings_fact.job_title_short = 'Data Analyst'
            AND job_work_from_home = TRUE
            AND salary_year_avg IS NOT NULL
        GROUP BY skill_id
    )

    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        jobs_per_skill_id.job_count AS demand_count
    FROM skills_dim
    INNER JOIN jobs_per_skill_id ON jobs_per_skill_id.skill_id = skills_dim.skill_id
),


average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON  skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
)

SELECT 
    skill_demand.skill_id,
    skill_demand.skills,
    skill_demand.demand_count,
    average_salary.avg_salary
FROM 
    skill_demand
INNER JOIN
    average_salary ON average_salary.skill_id = skill_demand.skill_id
WHERE
    demand_count > 20
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 100


-- Rewriting the same code more concisely, with some extra tweaks:


SELECT 
    skills_dim.skill_id, 
    skills_dim.skills,  
    COUNT(job_postings_fact.job_id) AS demand_count,  -- Count the number of jobs (demand) per skill
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary  -- Calculate the average salary per skill
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id  -- Join to associate jobs with skill IDs
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id  -- Join to associate skill IDs with skill names => jobs to skills
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst'  -- Filter for 'Data Analyst' jobs
    AND job_postings_fact.salary_year_avg IS NOT NULL  -- Remove jobs with no salary data
    AND job_postings_fact.job_location IN ('Anywhere', 'United Kingdom')  -- Filter for accessible jobs
GROUP BY 
    skills_dim.skill_id  -- Group by skill ID (and implicitly skill name)
HAVING 
    COUNT(job_postings_fact.job_id) > 10  -- Filter to remove jobs with little demand
ORDER BY 
    avg_salary DESC,  -- Sort by average salary in descending order
    demand_count DESC;  -- Sort by job demand (number of jobs) in descending order, secondarily

/*
The preceding code was successful, providing useful insights into the optimal skills to target for me. 
This exercise has informend me further, that SAS may be a useful skill to master for my career development.
*/