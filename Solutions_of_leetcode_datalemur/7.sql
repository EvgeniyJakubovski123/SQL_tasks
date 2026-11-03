-- Assume you're given a table containing job postings from various companies on the LinkedIn platform. Write a query to retrieve the count of companies that have posted duplicate job listings.

-- Definition:

-- Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
WITH tab1 as(SELECT
 company_id,
 title,
 description,
 COUNT(*) as job_id
FROM
 job_listings
GROUP BY
 company_id,title,description
)

SELECT
 COUNT(DISTINCT company_id) as duplicate_companies
FROM 
  tab1
WHERE 
 job_id >1 
 
