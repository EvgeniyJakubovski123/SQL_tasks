-- Assume you're given a table containing data on Amazon customers and their spending on products in different category, write a query to identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.
with tab1 as(SELECT 
category,
product,
SUM(spend) as sum_price



FROM product_spend

WHERE
 EXTRACT(year from transaction_date) = '2022'
GROUP BY category,product
ORdEr by category,sum_price ASC


)
SELECT 
category,
product,sum_price
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY sum_price DESC
        ) AS number
    FROM tab1
) AS subquery
WHERE number IN (1, 2);
