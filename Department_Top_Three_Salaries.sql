SELECT
    Department.Name AS Department,
    Employee.Name AS Employee,
    Employee.Salary AS Salary
FROM Employee
JOIN Department ON Employee.DepartmentId = Department.Id
WHERE (
    SELECT COUNT(DISTINCT Salary.Salary)
    FROM Employee AS Salary
    WHERE
        Salary.DepartmentId = Employee.DepartmentId
    AND Salary.Salary > Employee.Salary
) < 3
ORDER BY Employee.DepartmentId, Employee.Salary DESC;
