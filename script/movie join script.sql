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
select specs.release_year, avg(rating.imdb_rating) as avg_rating
from specs
inner join rating
using (movie_id)
group by specs.release_year
order by  avg(rating.imdb_rating) DESC
--ANSWER: 1991. highest rating 7.4



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
SELECT distributors.company_name, count(film_title) AS film_count
FROM distributors
left JOIN specs
ON (distributors.distributor_id = specs.domestic_distributor_id)
group by distributors.company_name
order by  film_count



--5. Write a query that returns the five distributors with the highest average movie budget.
SELECT distributors.company_name, avg(revenue.film_budget)
FROM distributors
INNER JOIN specs
on (specs.domestic_distributor_id = distributors.distributor_id)
INNER JOIN revenue
on revenue.movie_id = specs.movie_id
GROUP BY distributors.company_name
ORDER BY avg(film_budget) DESC
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
---------------------OR--------------------
SELECT film_title, company_name, distributor_id, headquarters, avg(imdb_rating) as avg_imdb_rating
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN rating
ON specs.movie_id = rating.movie_id
WHERE headquarters NOT LIKE '%CA%'
GROUP BY film_title, company_name, distributor_id, headquarters
ORDER BY  avg_imdb_rating DESC
--ANSWER: 2 movies. Dirty Dancing has the higher rating of 7.0



--7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT
CASE
	WHEN length_in_min >= 120 THEN '>2 Hours'
	ELSE '<2 Hours'
END AS length_of_movie, ROUND(avg(imdb_rating),2) AS avg_rating
FROM specs
INNER JOIN rating
USING (movie_id)
GROUP BY length_of_movie
ORDER BY avg_rating DESC
--ANSWER: Movies which are over two hours long have a higher average rating.



