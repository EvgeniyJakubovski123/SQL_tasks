-- Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

-- Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

-- Notes:

-- Calculate the following percentages:
-- time spent sending / (Time spent sending + Time spent opening)
-- Time spent opening / (Time spent sending + Time spent opening)
-- To avoid integer division in percentages, multiply by 100.0 and not 100.
-- Effective April 15th, 2023, the solution has been updated and optimised.
WITH tab1 as(
SELECT
age_breakdown.age_bucket,

SUM(CASE WHEN  activities.activity_type = 'open' THEN activities.time_spent ELSE 0 END) as sum_open,
SUM(CASE WHEN activities.activity_type = 'send' THEN activities.time_spent ELSE 0 END) as sum_send,
SUM(CASE WHEN activities.activity_type IN ('send','open') THEN activities.time_spent ELSE 0 END) as sum_both

FROM activities
INNER JOIN age_breakdown
USING(user_id)
GROUP BY age_breakdown.age_bucket
)

SELECT
age_bucket,
ROUND((sum_send/sum_both*100.0),2) as send_perc,
ROUND((sum_open/sum_both*100.0),2) as open_perc



  
FROM 
  tab1
