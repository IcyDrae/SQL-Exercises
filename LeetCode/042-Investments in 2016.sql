/*
Link: https://leetcode.com/problems/investments-in-2016/description/

Description:

Table: Insurance

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total
investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.

Write a solution to report the sum of all total investment values in 2016 tiv_2016,
for all policyholders who:

    have the same tiv_2015 value as one or more other policyholders, and
    are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute
    pairs must be unique).

Round tiv_2016 to two decimal places.

The result format is in the following example.

Example 1:

Input: 
Insurance table:
+-----+----------+----------+-----+-----+
| pid | tiv_2015 | tiv_2016 | lat | lon |
+-----+----------+----------+-----+-----+
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
+-----+----------+----------+-----+-----+
Output: 
+----------+
| tiv_2016 |
+----------+
| 45.00    |
+----------+
Explanation: 
The first record in the table, like the last record, meets both of the two criteria.
The tiv_2015 value 10 is the same as the third and fourth records, and its location is unique.

The second record does not meet any of the two criteria. Its tiv_2015 is not like any other
policyholders and its location is the same as the third record, which makes the third record
fail, too.
So, the result is the sum of tiv_2016 of the first and last record, which is 45.
*/

-- Solution
-- 1. Get all the policy holders
-- 2. Get all the unique cities
WITH [UniqueCities] AS (
    SELECT
        [lat],
        [lon],
        COUNT([pid]) AS [pid_amount]
    FROM [dbo].[Insurance]
    GROUP BY
        [lat],
        [lon]
    HAVING COUNT([pid]) = 1
),
-- 3. Get all the policy holders located in unique cities
[UniquePolicyHolders] AS (
    SELECT
        [Insurance].[pid]
    FROM [UniqueCities] AS [Cities]
    LEFT JOIN
        [dbo].[Insurance] AS [Insurance] ON
        [Cities].[lat] = [Insurance].[lat] AND
        [Cities].[lon] = [Insurance].[lon]
),
-- 4. Get the policy holders that have the same total investment values in 2015 as one or more other policy holders
[TotalInvestmentValuesEquals] AS (
    SELECT DISTINCT
        [Insurance].[pid],
        [Insurance].[tiv_2015],
        [Insurance].[tiv_2016]
    FROM [dbo].[Insurance] AS [Insurance]
    INNER JOIN
        [UniquePolicyHolders] AS [PolicyHolders] ON
        [Insurance].[pid] = [PolicyHolders].[pid]
    INNER JOIN
        [dbo].[Insurance] AS [NextTable] ON
        [Insurance].[tiv_2015] = [NextTable].[tiv_2015] AND
        [Insurance].[pid] != [NextTable].[pid]
),
-- 5. Get the sum of all total investment values in 2016
[SumTotalInvestmentValues2016] AS (
    SELECT
        SUM([tiv_2016]) AS [tiv_2016]
    FROM [TotalInvestmentValuesEquals]
)

SELECT
    ROUND([tiv_2016], 2) AS [tiv_2016]
FROM [SumTotalInvestmentValues2016];
