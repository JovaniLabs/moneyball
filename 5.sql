--It’s a bit of a slow day in the office.
--Though Satchel no longer plays,
--in 5.sql, write a SQL query to find all teams that Satchel Paige played for.

--Your query should return a table with a single column, one for the name of the teams.

--use 'distinct' to return unique team names
--use performances table because it accurately tracks players and teams more precise
SELECT distinct teams.name AS 'Team Name'
FROM players
JOIN performances ON players.id = performances.player_id
JOIN teams ON performances.team_id = teams.id
WHERE players.first_name = 'Satchel'
AND players.last_name = 'Paige'
;

