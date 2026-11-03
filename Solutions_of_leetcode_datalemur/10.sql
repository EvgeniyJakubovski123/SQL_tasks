-- Companies often perform salary analyses to ensure fair compensation practices. One useful analysis is to check if there are any employees earning more than their direct managers.

-- As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. The result should include the employee's ID and name.
WITH tab1 as(SELECT 
 mgr.employee_id AS manager_id,
 mgr.name AS manager_name,
 mgr.salary AS manager_salary,
 emp.employee_id AS employee_id,
 emp.name AS emplyee_name,
 emp.salary AS emplyee_salary


FROM employee AS mgr
INNER JOIN employee AS emp
 ON mgr.employee_id = emp.manager_id

)

SELECT 
 employee_id,
 emplyee_name
FROM 
 tab1
WHERE 
 emplyee_salary > manager_salary

