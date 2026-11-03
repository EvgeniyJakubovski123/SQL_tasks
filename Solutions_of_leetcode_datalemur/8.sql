-- Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

-- Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. Output the city name and the corresponding number of completed trade orders.
WITH tab1 as (SELECT 
  *
FROM 
  trades
INNER JOIN users
 ON trades.user_id = users.user_id
)
SELECT
 city,
 SUM( CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) as total_orders
FROM 
 tab1
GROUP BY
 city
ORDer BY
 total_orders DESC
LIMIT 
  3
