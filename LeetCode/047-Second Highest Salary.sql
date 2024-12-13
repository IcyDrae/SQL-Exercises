/*
Link: https://leetcode.com/problems/second-highest-salary/description/

Description:

Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.

Write a solution to find the second highest distinct salary from the
Employee table. If there is no second highest salary, return null
(return None in Pandas).

The result format is in the following example.

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
*/

-- Solution
WITH [DistinctSalaries] AS (
    SELECT DISTINCT
        [salary]
    FROM [dbo].[Employee]
),
-- 1. Find the second highest distinct salary
[SecondHighestSalary] AS (
    SELECT
        [salary],
        ROW_NUMBER() OVER (
            ORDER BY salary DESC
        ) AS [ranking]
    FROM [DistinctSalaries]
)

SELECT
-- 2. If there is no second highest, return null
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM [SecondHighestSalary]
            WHERE [ranking] = 2
        ) THEN (
            SELECT [salary]
            FROM [SecondHighestSalary]
            WHERE [ranking] = 2
        )
        ELSE NULL
    END AS [SecondHighestSalary];
