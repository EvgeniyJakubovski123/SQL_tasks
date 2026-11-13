-- -- UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive 
-- support for their health care needs – whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, 
--   emergency assistance, or member portal services.

-- -- To analyze the performance of the program, write a query to determine the month-over-month growth rate specifically for long-calls. 
-- A long-call is defined as any call lasting more than 5 minutes (300 seconds).

-- -- Output the year and month in numerical format and chronological order, along with the growth percentage rounded to 1 decimal place.
-- -- URL of task:https://datalemur.com/questions/long-calls-growth
WITH tab1 AS (
    SELECT
        COUNT(*) AS count_of_calls_in_month,
        DATE_TRUNC('month', call_date) AS month_date
    FROM callers
    WHERE call_duration_secs > 300
    GROUP BY DATE_TRUNC('month', call_date)
)

SELECT
    EXTRACT(YEAR FROM month_date) AS yr,
    EXTRACT(MONTH FROM month_date) AS mth,
    ROUND(
        100.0 * (count_of_calls_in_month - previous_month)
        / NULLIF(previous_month, 0),
        1
    ) AS long_calls_growth_pct
FROM (
    SELECT
        *,
        LAG(count_of_calls_in_month) OVER (
            ORDER BY month_date
        ) AS previous_month
    FROM tab1
) AS sub_query
ORDER BY month_date ASC;
