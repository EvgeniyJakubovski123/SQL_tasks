-- Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

-- It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.


-- WITH tab1 as (
-- SELECT 
--   employee_id,
--   salary,
--   ROW_NUMBER()OVER(
--   -- PARTITION employee_id
--   ORDER BY salary DESC
  
  
  
--   ) as nummer
  
-- FROM
--   employee



-- )

-- SELECT
-- DISTINCT salary as second_highest_salary 
-- -- employee_id as second_highest_salary
-- FROM tab1

-- WHERE
--   nummer = 2

WITH tab1 as(
SELECT  MAX(salary) as max_salary
FROM
  employee
  






)
SELECT
  MAX(salary) as second_highest_salary
FROM
  employee
WHERE
  salary<(SELECT * FROM tab1)
