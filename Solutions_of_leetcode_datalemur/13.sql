-- IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees. The objective is to generate data to populate a histogram that shows the number of unique queries run by employees during the third quarter of 2023 (July to September). Additionally, it should count the number of employees who did not run any queries during this period.

-- Display the number of unique queries as histogram categories, along with the count of employees who executed that number of unique queries.
WITH employee_queries as(
SELECT
  e.employee_id,
  COALESCE(COUNT(DISTINCT q.query_id),0) as unique_queries
FROM employees AS e 
LEFT JOIN queries as q 
 ON e.employee_id = q.employee_id
 AND q.query_starttime >= '2023-07-01T00:00:00Z'
      AND q.query_starttime < '2023-10-01T00:00:00Z'
  GROUP BY e.employee_id
)

SELECT
 COUNT(employee_id) as employee_count,
 unique_queries
 
 
 
FROM employee_queries

GROUP BY
  unique_queries
ORDER BY
 unique_queries ASC
