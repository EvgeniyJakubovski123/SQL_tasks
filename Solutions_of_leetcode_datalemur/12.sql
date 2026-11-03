-- Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.

-- Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

-- Definition:

-- action_date refers to the date when users activated their accounts and confirmed their sign-up through text messages.
WITH tab1 AS(SELECT 
  *
  
FROM 
 emails
INNER JOIN texts
 ON emails.email_id = texts.email_id
)

SELECT
  user_id
FROM
  tab1
WHERE
 EXTRACT(DAY FROM action_date::DATE)-EXTRACT(DAY FROM signup_date::DATE) = 1 AND
 signup_action = 'Confirmed'
