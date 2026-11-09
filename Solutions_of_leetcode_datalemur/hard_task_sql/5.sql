-- Intuit, a company known for its tax filing products like TurboTax and QuickBooks, offers multiple versions of these products.

-- Write a query that identifies the user IDs of individuals who
-- have filed their taxes using any version of TurboTax for three or more consecutive years. Each user is allowed to file taxes once a year 
-- using a specific product. Display the output in the ascending order of user IDs.
WITH tab1 AS(
SELECT
  *,
  EXTRACT(year from filing_date) as year,
  LAG(EXTRACT(year from filing_date),1) OVER(
  PARTITION BY user_id
  ORDER BY EXTRACT(year from filing_date) ASC
  
  
  
  ) as prev_year,
  LAG(EXTRACT(year from filing_date),2) OVER(

  PARTITION BY user_id
  ORDER BY EXTRACT(year from filing_date) ASC
   
  
  ) as prev_2_year
FROM
  filed_taxes
)
SELECT
  DISTINCT(user_id)

FROM tab1
WHERE
  product LIKE 'Turbo%' and year is not NULL and prev_year is not NULL 
  and prev_2_year is not NULL

-- second option for solving this task

WITH tab1 AS(
SELECT *,
  EXTRACT(year from filing_date) as year
FROM 
  filed_taxes
),

tab2 as (SELECT
  tb1.product as product,
  tb1.user_id as user_id
  
FROM
  tab1 as tb1
JOIN tab1 as tb2
ON tb1.user_id = tb2.user_id
AND  tb1.year -1  = tb2.year 
JOIN tab1 as tb3
ON tb1.user_id = tb3.user_id
AND tb1.year -2 = tb3.year
)
SELECT
  DISTINCT(user_id)
FROM tab2
WHERE
  product LIKE 'Turbo%'
