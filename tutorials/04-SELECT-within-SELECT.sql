-- SELECT within SELECT Tutorial

-- #1
SELECT name
FROM world
WHERE population > (
  SELECT population
  FROM world
  WHERE name='Russia'
);

-- #2
SELECT name
FROM world
WHERE
  continent = 'Europe'
  AND gdp / population > (
    SELECT gdp / population
    FROM world
    WHERE name='United Kingdom'
  );

-- #3
SELECT name, continent
FROM world
WHERE continent IN (
  SELECT continent
  FROM world
  WHERE name IN ('Argentina', 'Australia')
)
ORDER BY name;

-- #4
SELECT name, population
FROM world
WHERE
  population > (SELECT population FROM world WHERE name = 'Canada')
  AND
  population < (SELECT population FROM world WHERE name = 'Poland');

-- #5
SELECT
  name,
  CONCAT(
    ROUND(population / (SELECT population FROM world WHERE name = 'Germany') * 100, 0),
    '%'
  )
FROM world
WHERE continent = 'Europe'

-- #6
SELECT name
FROM world
WHERE gdp > (
  SELECT MAX(gdp)
  FROM world
  WHERE continent = 'Europe'
);

-- #7
SELECT continent, name, area
FROM world AS w1
WHERE area >= (
  SELECT MAX(area)
  FROM world AS w2
  WHERE w1.continent = w2.continent
);

-- #8
SELECT continent, MIN(name)
FROM world
GROUP BY continent;

-- #9
SELECT name, continent, population
FROM world AS w1
WHERE 25000000 > ALL (
  SELECT population
  FROM world AS w2
  WHERE w1.continent = w2.continent
);

-- #10
SELECT name, continent
FROM world AS w1
WHERE population > ALL (
  SELECT population * 3
  FROM world AS w2
  WHERE w1.continent = w2.continent
  AND w1.name <> w2.name
);
