-- New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to activate their accounts. Users may receive multiple text messages for account confirmation until they have confirmed their new account.

-- A senior analyst is interested to know the activation rate of specified users in the emails table. Write a query to find the activation rate. Round the percentage to 2 decimal places.

-- Definitions:

-- emails table contain the information of user signup details.
-- texts table contains the users' activation information.
-- Assumptions:

-- The analyst is interested in the activation rate of specific users in the emails table, which may not include all users that could potentially be found in the texts table.
-- For example, user 123 in the emails table may not be in the texts table and vice versa.
-- Effective April 4th 2023, we added an assumption to the question to provide additional clarity.


WITH tab1 as (SELECT

SUM(CASE WHEN signup_action = 'Confirmed' THEN 1 ELSE 0 END ) as sum_signed,
-- sum_signed / COUNT(signup_action) as confirm_rate
SUM(CASE WHEN signup_action in ('Confirmed','Not Confirmed') THEN 1 ELSE 0 END ) as sum_2  
  
FROM
 emails


LEFT JOIN texts
USING(email_id)
)

SELECT
ROUND((sum_signed::DECIMAL/sum_2::DECIMAL),2) as activation_rate
FROM tab1
