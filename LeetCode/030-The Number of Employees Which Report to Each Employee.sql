/*
Link: https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/

Description:

Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the
manager they report to. Some employees do not report to anyone
(reports_to is null). 

For this problem, we will consider a manager an employee who has at least
1 other employee reporting to them.

Write a solution to report the ids and the names of all managers,
the number of employees who report directly to them, and the
average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.

The result format is in the following example.

Example 1:

Input: 
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+
Output: 
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
Explanation: Hercy has 2 people report directly to him, Alice and Bob.
Their average age is (41+36)/2 = 38.5, which is 39 after
rounding it to the nearest integer.

Example 2:

Input: 
Employees table:
+-------------+---------+------------+-----+ 
| employee_id | name    | reports_to | age |
|-------------|---------|------------|-----|
| 1           | Michael | null       | 45  |
| 2           | Alice   | 1          | 38  |
| 3           | Bob     | 1          | 42  |
| 4           | Charlie | 2          | 34  |
| 5           | David   | 2          | 40  |
| 6           | Eve     | 3          | 37  |
| 7           | Frank   | null       | 50  |
| 8           | Grace   | null       | 48  |
+-------------+---------+------------+-----+ 
Output: 
+-------------+---------+---------------+-------------+
| employee_id | name    | reports_count | average_age |
| ----------- | ------- | ------------- | ----------- |
| 1           | Michael | 2             | 40          |
| 2           | Alice   | 2             | 37          |
| 3           | Bob     | 1             | 37          |
+-------------+---------+---------------+-------------+
*/

-- Solution
WITH [Managers] AS (
    SELECT
        [Employees].[employee_id] AS [manager_id],
        [Employees].[name] AS [manager_name]
    FROM
        [dbo].[Employees] AS [Employees]
    INNER JOIN [dbo].[Employees] AS [Employees2] ON
        [Employees].[employee_id] = [Employees2].[reports_to]
    GROUP BY
        [Employees].[employee_id],
        [Employees].[name]
),
[ManagerReports] AS (
    SELECT
        [Managers].[manager_id],
        [Employees].[employee_id] AS [report_id],
        [Managers].[manager_name] AS [name],
        [Employees].[age] AS [report_age]
    FROM
        [dbo].[Employees] AS [Employees]
    INNER JOIN [Managers] AS [Managers] ON
        [Employees].[reports_to] = [Managers].[manager_id] AND
        [Employees].[reports_to] IS NOT NULL
)

SELECT
    [manager_id] AS [employee_id],
    [name],
    COUNT([report_id]) AS [reports_count],
    ROUND(
        CAST(SUM([report_age]) AS DECIMAL) /
        CAST(COUNT([report_id]) AS DECIMAL)
    , 0) AS [average_age]
FROM
    [ManagerReports]
GROUP BY
    [manager_id],
    [name]
ORDER BY [manager_id];
