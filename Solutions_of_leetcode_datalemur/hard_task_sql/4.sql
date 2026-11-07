-- Google's marketing team is making a Superbowl commercial and needs a simple statistic to put on their TV ad: the median number of searches a person made last year.

-- However, at Google scale, querying the 2 trillion searches is too costly. Luckily, you have access to the summary table which tells you the number of searches made last year and how many Google users fall into that bucket.

-- Write a query to report the median of searches made by a user. Round the median to one decimal point.


WITH tab1 AS(
SELECT
  *
FROM 
  search_frequency
CROSS JOIN LATERAL  GENERATE_SERIES(1, num_users) AS n
)

SELECT
    ROUND(
        PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY searches)::DECIMAL,
        1
    ) AS median
FROM tab1;

-- or other option for making this task

WITH tab1 AS(
  SELECT
    UNNEST(ARRAY_FILL(searches,ARRAY[num_users])) as sample
  FROM
    search_frequency
  ORDER BY sample ASC
  


)
SELECT
  ROUND(PERCENTILE_CONT(0.50)WITHIN GROUP(
  ORDER BY sample)::DECIMAL,1) as median
FROM
  tab1
