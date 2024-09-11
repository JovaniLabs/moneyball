--Hits are great, but so are RBIs!
--In 12.sql, write a SQL query to find the players among the 10 least expensive players per hit
--and among the 10 least expensive players per RBI in 2001.

--Your query should return a table with two columns, one for the players’ first names and one of their last names.
--You can calculate a player’s salary per RBI by dividing their 2001 salary by their number of RBIs in 2001.
--You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
--Order your results by player ID, least to greatest (or alphabetically by last name, as both are the same in this case!).

--calculate cost hit and player rank
--divide salary by hits to get cost per hit
--also rank players

WITH h_calc AS (
    SELECT
        performances.player_id,
        --calculate salary per hit
        salaries.salary / performances.H AS s_per_hit,
        --rank player by salary per hit
        RANK() OVER (ORDER BY salaries.salary / performances.H) AS s_per_hit_rank
    FROM
        salaries
    JOIN
    ----join salaries and performances tables on player_id
        performances ON salaries.player_id = performances.player_id
    AND
    --ensure both tables match by year
        salaries.year = performances.year
    WHERE
    --only consider salaries from the year 2001
        salaries.year = 2001
    AND
    --filtered: only players with greater than 0 hits are considered
        performances.H > 0

),
-- cost per rbi and rank players
--divide salary by RBI to calculate cost per RBI
rbi_calc AS(
    SELECT
        performances.player_id,
        --calculate salary per rbi by dividing salary and RBI
        salaries.salary / performances.RBI AS s_per_rbi,
        --rank players by salary per bri
        RANK () OVER(ORDER BY salaries.salary / performances.RBI) AS s_per_rbi_rank
    FROM
        salaries
    JOIN
    --join salaries and performances tables on player_id
        performances ON salaries.player_id = performances.player_id
        AND
        --ensure salaries and performances tables match by year
        salaries.year = performances.year
    WHERE
    --only consider year from 2001
        salaries.year = 2001
    AND
    --filter only rbi greater than 0
        performances.RBI > 0
),
--top 10 cheapest player per hit and per RBI
--joins h_cost and rbi_cost
cheap_players AS (
    SELECT
    --select player_id from h_cal
        h_calc.player_id
    FROM
        h_calc
    JOIN
    --join tables from h_calc and rbi_calc on player_id
        rbi_calc ON h_calc.player_id = rbi_calc.player_id
    WHERE
    --only the players that ranked in the top 10 for salary per hit
        h_calc.s_per_hit_rank <= 10
    AND
    --only the players that ranked in the top 10 for salary per rbi
        rbi_calc.s_per_rbi_rank <= 10
)
--combine results and order by players last name
SELECT
    players.first_name,
    players.last_name
FROM
    cheap_players
JOIN
    players ON cheap_players.player_id = players.id
ORDER BY
    players.last_name ASC;
