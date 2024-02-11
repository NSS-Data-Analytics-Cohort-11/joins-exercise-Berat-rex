select *
from distributors

select *
from rating

SELECT *
FROM revenue

select *
from specs

--1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
FROM specs
JOIN revenue
--USING (movie_id)
ON (specs.movie_id = revenue.movie_id)
ORDER BY worldwide_gross ASC;
--ANSWER: Semi-Tough, 1977, 37187139



--2. What year has the highest average imdb rating?
SELECT rating.imdb_rating, specs.release_year
FROM rating
join specs
on (rating.movie_id = specs.movie_id)
ORDER BY rating.imdb_rating DESC;
--ANSWER: 2008. highest rating 9.0



--3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT specs.film_title, revenue.worldwide_gross, specs.mpaa_rating, distributors.company_name
FROM specs
JOIN revenue
ON (specs.movie_id = revenue.movie_id)
JOIN distributors
ON (specs.domestic_distributor_id = distributors.distributor_id)
WHERE specs.mpaa_rating = 'G'
ORDER BY revenue.worldwide_gross DESC
--ANSWER: Toy Story 4. Walt Disney



--4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT distinct distributor_id, company_name, film_title
FROM distributors
FULL JOIN specs
ON (distributors.distributor_id = specs.domestic_distributor_id)
ORDER by distributor_id asc



--5. Write a query that returns the five distributors with the highest average movie budget.
SELECT distinct domestic_distributor_id, film_title, film_budget
FROM specs
JOIN revenue
on (specs.movie_id = revenue.movie_id)
ORDER BY film_budget DESC
limit 5



--6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT film_title, headquarters, imdb_rating
FROM specs
INNER JOIN distributors
ON (specs.domestic_distributor_id = distributors.distributor_id)
INNER JOIN rating
ON (specs.movie_id = rating.movie_id)
WHERE headquarters NOT LIKE '%CA%'
ORDER BY imdb_rating DESC
--ANSWER: 2 movies. Dirty Dancing has rating of 7.0



--7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT avg(imdb_rating), length_in_min
FROM rating
JOIN specs
ON (rating.movie_id = specs.movie_id)
WHERE length_in_min > 120
GROUP BY length_in_min
ORDER BY length_in_min DESC


SELECT avg(imdb_rating), length_in_min
FROM rating
JOIN specs
ON (rating.movie_id = specs.movie_id)
WHERE length_in_min > 120
GROUP BY length_in_min
ORDER BY length_in_min DESC

--ANSWER: Movies which are over two hours long have a higher average rating.



