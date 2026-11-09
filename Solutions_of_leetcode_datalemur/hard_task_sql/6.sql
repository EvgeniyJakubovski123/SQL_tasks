-- As a Data Analyst on Snowflake's Marketing Analytics team, your objective is to analyze customer relationship management (CRM) data and identify contacts that satisfy two conditions:

-- Contacts who had a marketing touch for three or more consecutive weeks.
-- Contacts who had at least one marketing touch of the type 'trial_request'.
-- Marketing touches, also known as touch points, represent the interactions or points of contact between a brand and its customers.

-- Your goal is to generate a list of email addresses for these contacts.


WITH tab1 AS(
SELECT
  *,
  DATE_TRUNC('week',event_date) as current_week,
  LAG(DATE_TRUNC('week',event_date)) OVER(
  PARTITION BY contact_id
  ORDER BY DATE_TRUNC('week',event_date)
  ) as lag_week,
  LEAD(DATE_TRUNC('week',event_date)) OVER(
  PARTITION BY contact_id
  ORDER BY DATE_TRUNC('week',event_date)
  )as lead_week
FROM marketing_touches

  
)
SELECT
  email
FROM tab1
INNER JOIN crm_contacts
ON tab1.contact_id = crm_contacts.contact_id
WHERE tab1.current_week = tab1.lag_week + INTERVAL '7 days' AND
tab1.current_week = tab1.lead_week - INTERVAL '7 days'
and tab1.contact_id IN (
SELECT contact_id
FROM marketing_touches
WHERE event_type = 'trial_request'



)
