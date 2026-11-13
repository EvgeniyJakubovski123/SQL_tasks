-- UnitedHealth Group (UHG) has a program called Advocate4Me
--   , which al
--   lows policy holders (or, members) to
--   call an advocate and receive support for their health care needs – whether that's claims and 
--   benefits support, drug coverage, pre- and post-authorisation, medical records, emergency assistance, or member portal services.

-- Write a query to obtain the number of unique callers who made calls within a 7-day interval of thei
--   r previous calls. If a caller made more than two calls within the 7-day period, count them only once.
WITH tab1 AS (
    SELECT
        *,
        LAG(call_date) OVER (
            PARTITION BY policy_holder_id
            ORDER BY call_date ASC
        ) AS previous_call
    FROM callers
)

SELECT
    COUNT(*) AS policy_holder_count
FROM (
    SELECT
        policy_holder_id
    FROM tab1
    GROUP BY policy_holder_id
    HAVING COUNT(*) FILTER (
        WHERE call_date - previous_call <= INTERVAL '7 days'
          AND previous_call IS NOT NULL
    ) > 0
) AS sub_query;
-- task url:https://datalemur.com/questions/patient-call-history
