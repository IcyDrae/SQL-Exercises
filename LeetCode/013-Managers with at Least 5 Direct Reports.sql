/*
Link: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/

Description:

Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee,
their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.

Write a solution to find managers with at least five direct reports.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output: 
+------+
| name |
+------+
| John |
+------+
*/

-- Solution
WITH [Manager] AS (
    SELECT DISTINCT
        [Employee].[id] AS [id],
        [Employee].[name] AS [manager_name],
        [Employee].[department] AS [manager_department],
        [Employee].[managerId] AS [manager_managerId]
    FROM
        [dbo].[Employee] AS [Employee]
    JOIN [dbo].[Employee] AS [Manager] ON
        [Employee].[id] = [Manager].[managerId]
),
[DirectReport] AS (
    SELECT
        [Employee].[id],
        [Employee].[name],
        [Employee].[department],
        [Employee].[managerId]
    FROM
        [dbo].[Employee] AS [Employee]
    JOIN [Manager] AS [Manager] ON
        [Employee].[managerId] = [Manager].[id]
)

SELECT
    [Manager].[manager_name] AS [name]
FROM
    [Manager] AS [Manager]
LEFT JOIN [DirectReport] AS [DirectReport] ON
    [Manager].[id] = [DirectReport].[managerId]
GROUP BY
    [Manager].[id],
    [Manager].[manager_name]
HAVING COUNT([DirectReport].[id]) >= 5;
