SELECT * 
FROM distributors

SELECT *
FROM rating

SELECT * 
From revenue

SELECT *
FROM specs

--Q1.) Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
FROM specs
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
ORDER BY revenue.worldwide_gross ASC
LIMIT 1;

--answer 1.) Film: Semi-Tough, release year: 1977, worldwide gross: 37187139


--Q2.) What year has the highest average imdb rating?
SELECT specs.release_year, AVG(rating.imdb_rating)
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
GROUP BY specs.release_year
ORDER BY AVG(rating.imdb_rating) DESC
LIMIT 1;

--answer 2.) 1991


--Q3.)  What is the highest grossing G-rated movie? Which company distributed it?
SELECT specs.film_title, specs.mpaa_rating, revenue.worldwide_gross, distributors.company_name
FROM specs
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
WHERE specs.mpaa_rating = 'G'
ORDER BY revenue.worldwide_gross DESC;

--answer 3.) Toy Story 4 by Walt Disney


SELECT * 
FROM distributors

SELECT *
FROM rating

SELECT * 
From revenue

SELECT *
FROM specs



--Q4.) Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT distributors.company_name, COUNT(specs.film_title)
FROM distributors
LEFT JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY distributors.company_name


--Q5.) Write a query that returns the five distributors with the highest average movie budget.
SELECT distributors.company_name, AVG(revenue.film_budget) AS avg_movie_budget
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
GROUP BY distributors.company_name
ORDER BY AVG(revenue.film_budget) DESC
LIMIT 5;

--answer 5.) Walt Disney, Sony Pictures, Lionsgate, DreamWorks, Warner Bros.


SELECT * 
FROM distributors

SELECT *
FROM rating

SELECT * 
From revenue

SELECT *
FROM specs


--Q6.)How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT distributors.company_name, COUNT(specs.film_title), rating.imdb_rating
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id 
INNER JOIN rating
ON specs.movie_id = rating.movie_id
WHERE distributors.headquarters NOT ILIKE '%CA'
GROUP BY distributors.company_name, rating.imdb_rating
ORDER BY rating.imdb_rating DESC;

--answer 6.) Vestron Pictures


--Q7.) Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT specs.length_in_min, COUNT(specs.length_in_min),AVG(rating.imdb_rating)
CASE 
	WHEN specs.length_in_min > 120 THEN COUNT(specs.length_in_min)
	WHEN specs.length_in_min < 120 THEN COUNT(specs.length_in_min)
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
GROUP BY specs.length_in_min
ORDER BY AVG(rating.imdb_rating) DESC;
