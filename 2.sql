--Your general manager (i.e., the person who makes decisions about player contracts)
--asks you whether the team should trade a current player for Cal Ripken Jr.,
--a star player who’s likely nearing his retirement.

--In 2.sql, write a SQL query to find Cal Ripken Jr.’s salary history.

--Sort by year in descending order.
--Your query should return a table with two columns, one for year and one for salary.

--use 'players.first_name', 'players._last_name' to verify player name 'Cal Ripken'
--use COUNT(*) to verify correct number of rows
SELECT salaries.year, salaries.salary
FROM players
JOIN salaries ON players.id = salaries.player_id
WHERE players.first_name = 'Cal' AND players.last_name = 'Ripken'
ORDER BY salaries.year DESC;
