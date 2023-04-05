-- Active: 1673438014082@@relational.fit.cvut.cz@3306@imdb_ijs

-- select the actors from the godfather
SELECT
CONCAT(right(mov.name,3), ' ', left(mov.name, 9)) as 'Movie_Name',
CONCAT(act.first_name, ' ', act.last_name) as 'Actor'
FROM actors act
JOIN roles rol on rol.actor_id = act.id
JOIN movies mov on mov.id = rol.movie_id
WHERE mov.name = 'Godfather, The';

-- select top 10 action film from 90s
SELECT 
mov.Name,
CONCAT(dir.first_name, ' ', dir.last_name) as 'Name',
mov.Year,
mov.Rank
FROM movies mov
JOIN movies_directors movdir ON movdir.movie_id = mov.id
JOIN directors dir ON dir.id = movdir.director_id
JOIN movies_genres movgen ON movgen.movie_id = mov.id
WHERE mov.year BETWEEN 1990 AND 1999
AND movgen.genre = 'Action'
ORDER BY mov.rank DESC
LIMIT 10;

-- select the quantity and average rank of arnold schwarzenegger's 
SELECT
COUNT(*) AS 'Count of Movies',
CAST(AVG(rank) AS DECIMAL(5,2)) AS 'Average Rank of movies'
FROM movies
WHERE id IN (
    SELECT movie_id FROM roles
    WHERE actor_id = (
        SELECT id FROM actors 
        WHERE first_name = 'Arnold'
        AND last_name = 'Schwarzenegger'
    )
);

-- select the rate of actors's sex
SELECT
Gender, 
COUNT(gender) as 'Gender quantity',
CONCAT(CAST(COUNT(gender) / (SELECT COUNT(*) FROM actors) * 100 as INT), '%')
FROM actors
GROUP BY gender;

-- select the number of movie genres and maximum rank after 1985
SELECT
Genre,
COUNT(movie_id) as 'Count',
CAST(AVG(rank) as DECIMAL(5,2)) as 'Rank Average'
FROM movies_genres movgen
JOIN movies mov ON mov.id = movgen.movie_id
WHERE year >= 1985
GROUP BY genre

