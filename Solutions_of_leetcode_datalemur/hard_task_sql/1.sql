-- Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".

-- Hint:

WITH june_users AS (
  SELECT
    user_id
  FROM
    user_actions
  WHERE
    event_date >= '2022-06-01' AND event_date < '2022-07-01'


),
july_users AS(
  SELECT
    user_id 
  FROM
    user_actions
  WHERE
    event_date >= '2022-07-01' AND event_date < '2022-08-01'



)

SELECT
  7 as month,
  COUNT(DISTINCT user_id) as monthly_active_users
  
FROM june_users
INNER JOIN july_users
USING(user_id)
-- Second option of solving this task
SELECT
  EXTRACT(MONTH FROM current_month.event_date) as month,
  COUNT(DISTINCT current_month.user_id) as monthly_active_users
   
FROM user_actions as current_month
WHERE EXISTS(
  SELECT
    *
  FROM 
    user_actions as last_month
  WHERE
    last_month.user_id = current_month.user_id AND 
    EXTRACT(MONTH FROM last_month.event_date) = EXTRACT(MONTH FROM current_month.event_date - interval 
    '1 month')
    
)
 AND EXTRACT(MONTH FROM current_month.event_date) = 7
 AND EXTRACT(YEAR FROM current_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM current_month.event_date)
