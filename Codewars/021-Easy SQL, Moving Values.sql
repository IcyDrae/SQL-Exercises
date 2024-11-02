/*
Link: https://www.codewars.com/kata/594a389387a7c6a77a000005

Description:

You have access to a table of monsters as follows:

** monsters table schema **

    id
    name
    legs
    arms
    characteristics

Your task is to make a new table where each column should contain
the length of the string in the column to its right (last column
should contain length of string in the first column).
Remember some column values are not currently strings.
Column order and titles should remain unchanged:

** output table schema **

    id
    name
    legs
    arms
    characteristics
*/

-- Solution
WITH new_monsters AS (
  SELECT
    LENGTH(monsters.name::TEXT) AS "id",
    LENGTH(monsters.legs::TEXT) AS "name",
    LENGTH(monsters.arms::TEXT) AS "legs",
    LENGTH(monsters.characteristics::TEXT) AS "arms",
    LENGTH(monsters.id::TEXT) AS "characteristics"
  FROM
    monsters
)

SELECT
  *
FROM
  new_monsters;
