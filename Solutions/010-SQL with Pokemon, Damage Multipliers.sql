/*
Link: https://www.codewars.com/kata/5ab828bcedbcfc65ea000099

Description:

You have arrived at the Celadon Gym to battle Erika for the Rainbow Badge.
She will be using Grass-type Pokemon. Any fire pokemon you have
will be strong against grass, but your water types will be weakened.
The multipliers table within your Pokedex will take care of that.

Using the following tables,
return the pokemon_name, modifiedStrength and element of the Pokemon
whose strength, after taking these changes into account, is greater
than or equal to 40, ordered from strongest to weakest.

pokemon schema

    id
    pokemon_name
    element_id
    str

multipliers schema

    id
    element
    multiplier
*/

-- Solution

SELECT
  modified.pokemon_name,
  modified.modifiedStrength,
  modified.element
FROM (
  SELECT
    pokemon.pokemon_name,
    (pokemon.str * multipliers.multiplier) AS modifiedStrength,
    multipliers.element
  FROM pokemon AS pokemon
  LEFT JOIN multipliers AS multipliers
  ON pokemon.element_id = multipliers.id) AS modified
WHERE
  (modified.modifiedStrength >= 40)
ORDER BY modified.modifiedStrength DESC;
