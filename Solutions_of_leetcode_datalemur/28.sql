-- A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.

-- Write a query that identifies the customer IDs of these Supercloud customers.
WITH tab1 as(

SELECT *


FROM
  customer_contracts
  
LEFT JOIN products
USING(product_id)

),
tab2 as(
SELECT
  customer_id,
  product_category
FROM 
  tab1
GROUP BY
  customer_id,product_category
ORDER BY
  customer_id ASC
)

SELECT
  customer_id
FROM
  tab2
GROUP BY
  customer_id
HAVING COUNT(DISTINCT product_category) = 3
