-- Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. 
-- Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.
-- In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.
WITH result as (SELECT
  EXTRACT(YEAR from tweet_date) as year ,
  user_id,
  COUNT(*) as tweet_counts

FROM
 tweets
 
WHERE
  EXTRACT(YEAR FROM tweet_date) = 2022
 
GROUP BY
  year,
  user_id
  
ORDER BY
 tweet_counts DESC
)
SELECT
  tweet_counts,
  COUNT(*)
FROM result
GROUP BY
  tweet_counts
ORDER BY
  tweet_counts ASC
