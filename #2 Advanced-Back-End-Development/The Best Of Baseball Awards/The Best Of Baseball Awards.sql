SELECT * FROM people LIMIT 10;
SELECT * FROM batting LIMIT 10;
SELECT * FROM pitching LIMIT 10;
SELECT * FROM teams LIMIT 10;

SELECT teamid, yearid, AVG(weight) AS avg_weight
FROM people
JOIN batting ON people.playerid = batting.playerid
GROUP BY teamid, yearid
ORDER BY avg_weight DESC
LIMIT 1;

SELECT teamid, yearid, AVG(height) AS avg_height
FROM people
JOIN batting ON people.playerid = batting.playerid
GROUP BY teamid, yearid
ORDER BY avg_height ASC
LIMIT 1;

SELECT teamid, yearid, SUM(salary) AS total_salary
FROM salaries
GROUP BY teamid, yearid
ORDER BY total_salary DESC
LIMIT 1;

SELECT teams.teamid, teams.name, ROUND(SUM(salaries.salary) / teams.w, 2) AS cost_per_win
FROM salaries
JOIN teams ON salaries.teamid = teams.teamid AND salaries.yearid = teams.yearid
WHERE teams.yearid = 2010
GROUP BY teams.teamid, teams.name, teams.w
ORDER BY cost_per_win ASC
LIMIT 1;

SELECT people.name, ROUND(SUM(salaries.salary) / SUM(pitching.gs), 2) AS cost_per_game
FROM salaries
JOIN pitching ON salaries.playerid = pitching.playerid AND salaries.teamid = pitching.teamid AND salaries.yearid = pitching.yearid
JOIN people ON salaries.playerid = people.playerid
WHERE pitching.gs >= 10
GROUP BY people.name
ORDER BY cost_per_game DESC
LIMIT 1;

SELECT people.name, SUM(batting.g) AS total_games
FROM batting
JOIN people ON batting.playerid = people.playerid
GROUP BY people.name
ORDER BY total_games DESC
LIMIT 1;



