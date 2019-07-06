-- Self join

-- #1
SELECT COUNT(*)
FROM stops;

-- #2
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- #3
SELECT DISTINCT id, name
FROM stops INNER JOIN route ON (stops.id = route.stop)
WHERE company = 'LRT' AND num = '4';

-- #4
SELECT company, num, COUNT(*)
FROM route
WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING COUNT(*) = 2;

-- #5
SELECT routea.company, routea.num, routea.stop, routeb.stop
FROM route routea INNER JOIN route routeb ON routea.company = routeb.company AND routea.num = routeb.num
WHERE routea.stop = 53 AND routeb.stop = 149;

-- #6
SELECT routea.company, routea.num, stopa.name, stopb.name
FROM
  route routea INNER JOIN route routeb ON routea.company = routeb.company AND routea.num = routeb.num
  INNER JOIN stops stopa ON (routea.stop = stopa.id)
  INNER JOIN stops stopb ON (routeb.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'London Road';

-- #7
SELECT DISTINCT routea.company, routea.num
FROM route routea INNER JOIN route routeb ON routea.company = routeb.company AND routea.num = routeb.num
WHERE routea.stop = 115 AND routeb.stop = 137;

-- #8
SELECT routea.company, routea.num
FROM
  route routea INNER JOIN route routeb ON routea.company = routeb.company AND routea.num = routeb.num
  INNER JOIN stops stopa ON (routea.stop = stopa.id)
  INNER JOIN stops stopb ON (routeb.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross';

-- #9
SELECT DISTINCT stopa.name, routea.company, routea.num
FROM
  route routea INNER JOIN route routeb ON routea.company = routeb.company AND routea.num = routeb.num
  INNER JOIN stops stopa ON (routea.stop = stopa.id)
  INNER JOIN stops stopb ON (routeb.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' OR  stopa.name = 'Craiglockhart';

-- #10
SELECT DISTINCT routea.num, routea.company, stopb.name, routec.num, routec.company
FROM
  route routea INNER JOIN route routeb ON routea.company = routeb.company AND routea.num = routeb.num
  INNER JOIN (route routec INNER JOIN route routed ON routec.company = routed.company AND routec.num = routed.num)
  INNER JOIN stops stopa ON (routea.stop = stopa.id)
  INNER JOIN stops stopb ON (routeb.stop = stopb.id)
  INNER JOIN stops stopc ON (routec.stop = stopc.id)
  INNER JOIN stops stopd ON (routed.stop = stopd.id)
WHERE stopa.name = 'Craiglockhart' AND stopd.name = 'Lochend' AND stopb.name = stopc.name;
