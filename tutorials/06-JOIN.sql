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
FROM game INNER JOIN goal ON (game.id = goal.matchid)
WHERE teamid = 'GER';

-- #4
SELECT team1, team2, player
FROM game INNER JOIN goal ON (game.id = goal.matchid)
WHERE player LIKE 'Mario%';

-- #5
SELECT player, teamid, coach, gtime
FROM goal INNER JOIN eteam ON (goal.teamid = eteam.id)
WHERE gtime <= 10;

-- #6
SELECT mdate, teamname
FROM game INNER JOIN eteam ON (game.team1 = eteam.id)
WHERE coach = 'Fernando Santos';

-- #7
SELECT player
FROM goal INNER JOIN game ON (goal.matchid = game.id)
WHERE stadium = 'National Stadium, Warsaw';
