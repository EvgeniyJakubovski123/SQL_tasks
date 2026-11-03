-- You're given two tables containing data on Spotify users' streaming activity: songs_history which has historical streaming data, and songs_weekly which has data from the current week.

-- Write a query that outputs the user ID, song ID, and cumulative count of song plays up to August 4th, 2022, sorted in descending order.

-- Assume that there may be new users or songs in the songs_weekly table that are not present in the songs_history table.

-- Definitions:

-- song_weeklytable only contains data for the week of August 1st to August 7th, 2022.
-- songs_history table contains data up to July 31st, 2022. The query should include historical data from this table.


WITH tab1 as (
SELECT

  user_id,song_id,song_plays
FROM
  songs_history
UNION ALL
SELECT
  user_id,
  song_id,
  COUNT(song_id) as song_plays
FROM songs_weekly
WHERE 
  listen_time <= '08/04/2022 23:59:59'
GROUP BY user_id, song_id




)
SELECT
 user_id,
 song_id,
 SUM(song_plays) AS song_count
FROM tab1
GROUP BY 
  user_id,song_id
ORDER BY song_count DESC
