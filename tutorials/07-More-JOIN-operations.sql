-- More JOIN operations

-- #1
SELECT id, title
FROM movie
WHERE yr = 1962;

-- #2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- #3
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- #4
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- #5
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- #6
SELECT name
FROM actor INNER JOIN casting ON actor.id = casting.actorid
WHERE movieid = (
  SELECT id
  FROM movie
  WHERE title = 'Casablanca'
);

-- #7
SELECT name
FROM
  casting
  INNER JOIN actor ON casting.actorid = actor.id
  INNER JOIN movie ON casting.movieid = movie.id
WHERE title = 'Alien';

-- #8
SELECT title
FROM
  casting
  INNER JOIN actor ON casting.actorid = actor.id
  INNER JOIN movie ON casting.movieid = movie.id
WHERE name = 'Harrison Ford';

-- #9
SELECT title
FROM
  casting
  INNER JOIN actor ON casting.actorid = actor.id
  INNER JOIN movie ON casting.movieid = movie.id
WHERE name = 'Harrison Ford' AND ord <> 1;

-- #10
SELECT title, name
FROM
  casting
  INNER JOIN actor ON casting.actorid = actor.id
  INNER JOIN movie ON casting.movieid = movie.id
WHERE yr = 1962 AND ord = 1;

-- #11
SELECT yr, COUNT(title)
FROM
  casting
  INNER JOIN actor ON casting.actorid = actor.id
  INNER JOIN movie ON casting.movieid = movie.id
where name = 'John Travolta'
GROUP BY yr
HAVING COUNT(title) = (
  SELECT MAX(cnt) FROM (
    SELECT yr, COUNT(title) AS cnt
    FROM
      casting
      INNER JOIN actor ON casting.actorid = actor.id
      INNER JOIN movie ON casting.movieid = movie.id
    WHERE name = 'John Travolta'
    GROUP BY yr
  ) AS t -- To avoid "Every derived table must have its own alias"
);

-- #12
SELECT title, name
FROM
  casting
  INNER JOIN actor ON casting.actorid = actor.id
  INNER JOIN movie ON casting.movieid = movie.id
WHERE ord = 1 AND movieid IN (
  SELECT movieid
  FROM
    casting
    INNER JOIN actor ON casting.actorid = actor.id
    WHERE name = 'Julie Andrews'
);

-- #13
SELECT name
FROM casting INNER JOIN actor ON casting.actorid = actor.id
WHERE ord = 1
GROUP BY name
HAVING COUNT(movieid) >= 30
ORDER BY name;

-- #14
SELECT title, COUNT(actorid) AS actor_count
FROM casting INNER JOIN movie ON casting.movieid = movie.id
WHERE yr = 1978
GROUP BY title
ORDER BY actor_count DESC, title ASC;

-- #15
SELECT DISTINCT name
FROM casting INNER JOIN actor ON casting.actorid = actor.id
WHERE name <> 'Art Garfunkel' AND movieid IN (
  SELECT movieid
  FROM casting INNER JOIN actor ON casting.actorid = actor.id
  WHERE name = 'Art Garfunkel'
);
