/*
Link: https://leetcode.com/problems/consecutive-numbers/description/

Description:

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at
least three times.
*/

-- Solution
SELECT DISTINCT
    [Logs_1].[num] AS [ConsecutiveNums]
FROM [dbo].[Logs] AS [Logs_1]
INNER JOIN [dbo].[Logs] AS [Logs_2] ON
    [Logs_1].[id] = [Logs_2].[id] - 1 AND
    [Logs_1].[num] = [Logs_2].[num]
INNER JOIN [dbo].[Logs] AS [Logs_3] ON
    [Logs_1].[id] = [Logs_3].[id] - 2 AND
    [Logs_1].[num] = [Logs_3].[num];
