/*
Link: https://www.codewars.com/kata/594804a218e96caa8d00051b

Description:

Given a demographics table in the following format:

** demographics table schema **

    id
    name
    birthday
    race

you need to return the same table where all text fields (name & race)
are changed to the ascii code of their first byte.

e.g. Verlie = 86 Warren = 87 Horace = 72 Tracy = 84
*/

-- Solution

SELECT
  demographics.id,
  ASCII(SUBSTR(demographics.name, 1, 1)) AS "name",
  demographics.birthday,
  ASCII(SUBSTR(demographics.race, 1, 1)) AS "race"
FROM
  demographics;
