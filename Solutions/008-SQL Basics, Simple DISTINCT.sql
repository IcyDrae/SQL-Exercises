/*
Link: https://www.codewars.com/kata/58111670e10b53be31000108

Description:

For this challenge you need to create a simple DISTINCT statement,
you want to find all the unique ages.

people table schema

    id
    name
    age

select table schema

    age (distinct)
*/

-- Solution

SELECT
  DISTINCT people.age AS age
FROM
  people;
