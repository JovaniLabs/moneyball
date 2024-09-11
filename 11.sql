--You need a player that can get hits. Who might be the most underrated?
--In 11.sql, write a SQL query to find the 10 least expensive players per hit in 2001.

--Your query should return a table with three columns, one for the players’ first names, one of their last names, and one called “dollars per hit”.
--You can calculate the “dollars per hit” column by dividing a player’s 2001 salary by the number of hits they made in 2001.
--Recall you can use AS to rename a column.
--Dividing a salary by 0 hits will result in a NULL value. Avoid the issue by filtering out players with 0 hits.
--Sort the table by the “dollars per hit” column, least to most expensive.
--If two players have the same “dollars per hit”, order by first name, followed by last name, in alphabetical order.
--As in 10.sql, ensure that the salary’s year and the performance’s year match.
--You may assume, for simplicity, that a player will only have one salary and one performance in 2001.

SELECT players.first_name, players.last_name, (salaries.salary / performances.H) AS "dollars per hit"
FROM players
JOIN salaries ON players.id = salaries.player_id
JOIN performances ON players.id = performances.player_id
AND salaries.year = performances.year

WHERE salaries.year = 2001
AND performances.year = 2001
AND performances.H > 0

ORDER BY "dollars per hit" ASC,
players.first_name, players.last_name
LIMIT 10
;
