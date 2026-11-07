-- Assume you're given a table containing information about Wayfair user transactions for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

-- The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.



WITH tab1 AS(
SELECT
  EXTRACT(YEAR FROM transaction_date) as year,
  product_id,
  spend as curr_year_spend,
  
  LAG(spend) OVER(
    PARTITION BY product_id 
    ORDER BY product_id, EXTRACT(YEAR FROM transaction_date) ASC
  ) as prev_year_spend
FROM 
  user_transactions
)
SELECT
  *,
  ROUND(((curr_year_spend - prev_year_spend)/prev_year_spend*100),2) as yoy_rate
  
FROM tab1
