/*
Link: https://www.codewars.com/kata/594a50bafd3b7031c1000013

Description:

You have access to a table of monsters as follows:
monsters table schema

    id
    name
    legs
    arms
    characteristics

Your task is to turn the numeric columns (arms, legs) into equivalent hexadecimal values.
output table schema

    legs
    arms
*/

-- Solution

SELECT
  TO_HEX(arms) AS arms,
  TO_HEX(legs) AS legs
FROM
  monsters;
