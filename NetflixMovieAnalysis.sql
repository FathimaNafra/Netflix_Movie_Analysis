-- Netflix Project
CREATE TABLE movies(
 show_id VARCHAR(10),
 type VARCHAR(15),
 title VARCHAR(150),
 director VARCHAR(208),
 casts VARCHAR(1000),
 country VARCHAR (150),
 date_added VARCHAR(50),
 release_year INT,
 rating VARCHAR(10),
 duration VARCHAR(15),
 listed_in VARCHAR(100),
 description VARCHAR(1000)

 );

 SELECT * FROM movies;

 SELECT COUNT(*) as total_content FROM movies;
 
 SELECT 
   DISTINCT type
 FROM movies;

-- -- 15 Business Problems & Solutions

--1. Count the number of Movies vs TV Shows

SELECT type,
COUNT(*)  as total_content FROM movies
GROUP BY type;


--2. Find the most common rating for movies and TV shows

SELECT 
rating,
COUNT(*) AS total
FROM movies
GROUP BY rating
ORDER BY total DESC

SELECT type,rating,COUNT(*) as total
FROM movies
GROUP BY type,rating
ORDER BY type,total DESC






--3. List all movies released in a specific year (e.g., 2020)

SELECT title,release_year 
FROM movies WHERE 
release_year =2020

--4. Find the top 5 countries with the most content on Netflix

SELECT TOP 5 country,COUNT(*) as total
FROM movies
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total DESC






--5. Identify the longest movie
SELECT TOP 1 title,duration
FROM movies
WHERE type = 'Movie'
ORDER BY CAST(LEFT(duration, CHARINDEX(' ', duration)-1) AS INT) DESC;



--6. Find content added in the last 5 years
SELECT title, date_added
FROM movies
WHERE TRY_CONVERT(DATE, date_added) >= '2014-01-01';

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT title  FROM movies
WHERE director = 'Rajiv Chilaka';	
--8. List all TV shows with more than 5 seasons
SELECT title, duration FROM movies
WHERE duration > '5 Seasons' AND type = 'TV Show';


--9. Count the number of content items in each genre
SELECT listed_in, COUNT(*) AS total
FROM movies
GROUP BY listed_in

--10.Find each year and the average numbers of content release in India on netflix. 
SELECT release_year,AVG(CASE WHEN country = 'India' THEN 1 ELSE 0 END) AS avg_content_release
FROM movies
WHERE country='India'
GROUP BY release_year

--11. List all movies that are documentaries
SELECT title,type,listed_in 
FROM movies
WHERE type='Movie' 
   AND listed_in LIKE '%Documentaries%'
ORDER BY title


--12. Find all content without a director

SELECT title FROM movies
WHERE director IS NULL OR director = ''

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT COUNT (*) AS total_movies
FROM movies
WHERE cast LIKE '%Salman Khan%' AND release_year >= 2009;

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT TOP 10 
  TRIM (value) AS actor,
  COUNT(*) AS total_movies
FROM movies
CROSS APPLY STRING_SPLIT(cast, ',')
WHERE country = 'India' AND type = 'Movie'
GROUP BY TRIM (value)
ORDER BY total_movies DESC

--15.
--Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.

SELECT 
  CASE
      WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad' ELSE 'Good'
  END AS content_category,
  COUNT(*) AS total
FROM movies
GROUP BY 
    CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad' 
        ELSE 'Good' 
    END;