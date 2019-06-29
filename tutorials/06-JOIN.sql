-- The JOIN operation

-- #1
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- #2
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- #3
SELECT player, teamid, stadium, mdate
FROM game INNER JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER';

-- #4
SELECT team1, team2, player
FROM game INNER JOIN goal ON game.id = goal.matchid
WHERE player LIKE 'Mario%';

-- #5
SELECT player, teamid, coach, gtime
FROM goal INNER JOIN eteam ON goal.teamid = eteam.id
WHERE gtime <= 10;

-- #6
SELECT mdate, teamname
FROM game INNER JOIN eteam ON game.team1 = eteam.id
WHERE coach = 'Fernando Santos';

-- #7
SELECT player
FROM goal INNER JOIN game ON goal.matchid = game.id
WHERE stadium = 'National Stadium, Warsaw';

-- #8
SELECT DISTINCT player
FROM game INNER JOIN goal ON game.id = goal.matchid
WHERE (team1 = 'GER' OR team2 = 'GER') AND teamid <> 'GER';

-- #9
SELECT teamname, COUNT(teamid)
FROM eteam INNER JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname;

-- #10
SELECT stadium, COUNT(teamid)
FROM game INNER JOIN goal ON game.id = goal.matchid
GROUP BY stadium;

-- #11
SELECT matchid, mdate, COUNT(matchid)
FROM game INNER JOIN goal ON game.id = goal.matchid
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid, mdate;

-- #12
SELECT matchid, mdate, COUNT(matchid)
FROM goal INNER JOIN game ON goal.matchid = game.id
WHERE teamid = 'GER'
GROUP BY matchid, mdate;

-- #13
SELECT
  mdate,
  team1,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT OUTER JOIN goal ON game.id = goal.matchid
GROUP BY mdate, matchid, team1, team2
ORDER BY mdate, matchid, team1, team2;
