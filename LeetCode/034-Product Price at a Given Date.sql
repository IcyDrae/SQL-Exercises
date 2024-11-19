/*
Link: https://leetcode.com/problems/product-price-at-a-given-date/description/

Description:

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with
unique values) of this table.
Each row of this table indicates that the price of some product was
changed to a new price at some date.

Write a solution to find the prices of all products on 2019-08-16.
Assume the price of all products before any change is 10.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/

-- Solution
WITH [UniqueProducts] AS (
    SELECT DISTINCT
        [product_id]
    FROM [dbo].[Products]
),
[LastChangedDate] AS (
    SELECT
        [product_id],
        MAX([change_date]) AS [change_date]
    FROM [dbo].[Products]
    WHERE [change_date] <= '2019-08-16'
    GROUP BY [product_id]
),
[LastChangedPrice] AS (
    SELECT
        [Products].[product_id],
        [Products].[new_price]
    FROM
        [dbo].[Products] AS [Products]
    INNER JOIN [LastChangedDate] AS [LastChangedDate] ON
        [Products].[product_id] = [LastChangedDate].[product_id] AND
        [Products].[change_date] = [LastChangedDate].[change_date]
)

SELECT
    [UniqueProducts].[product_id],
    CASE
        WHEN [LastChangedPrice].[new_price] IS NULL
            THEN 10
        ELSE [LastChangedPrice].[new_price]
    END AS [price]
FROM
    [UniqueProducts] AS [UniqueProducts]
LEFT JOIN [LastChangedPrice] AS [LastChangedPrice] ON
    [UniqueProducts].[product_id] = [LastChangedPrice].[product_id]
GROUP BY
    [UniqueProducts].[product_id],
    [LastChangedPrice].[new_price];
