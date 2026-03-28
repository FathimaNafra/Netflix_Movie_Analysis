
# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/FathimaNafra/Netflix_Movie_Analysis/blob/main/logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:
- **Dataset Link:** [Movies Dataset](https://github.com/FathimaNafra/Netflix_Movie_Analysis/blob/main/netflix_titles_nov_2019.csv)

## Schema

```sql
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
```


## Business Problems & Solutions

### 1. Count the number of Movies vs TV Shows
```sql
SELECT type,
COUNT(*)  as total_content FROM movies
GROUP BY type;
```
**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the most common rating for movies and TV shows
```sql
SELECT 
rating,
COUNT(*) AS total
FROM movies
GROUP BY rating
ORDER BY total DESC
```
```sql
SELECT type,rating,COUNT(*) as total
FROM movies
GROUP BY type,rating
ORDER BY type,total DESC
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List all movies released in a specific year (e.g., 2020)
```sql
SELECT title,release_year 
FROM movies WHERE 
release_year =2020
```
**Objective:** Retrieve all movies released in a specific year.

### 4. Find the top 5 countries with the most content on Netflix

```sql
SELECT TOP 5 country,COUNT(*) as total
FROM movies
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total DESC
```
**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the longest movie
```sql
SELECT TOP 1 title,duration
FROM movies
WHERE type = 'Movie'
ORDER BY CAST(LEFT(duration, CHARINDEX(' ', duration)-1) AS INT) DESC;
```
**Objective:** Find the movie with the longest duration.

### 6. Find content added in the last 5 years
```sql
SELECT title, date_added
FROM movies
WHERE TRY_CONVERT(DATE, date_added) >= '2014-01-01';
```
**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
```sql
SELECT title  FROM movies
WHERE director = 'Rajiv Chilaka';
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List all TV shows with more than 5 seasons
```sql
SELECT title, duration FROM movies
WHERE duration > '5 Seasons' AND type = 'TV Show';
```
**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the number of content items in each genre
```sql
SELECT listed_in, COUNT(*) AS total
FROM movies
GROUP BY listed_in
```
**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
```sql
SELECT release_year,AVG(CASE WHEN country = 'India' THEN 1 ELSE 0 END) AS avg_content_release
FROM movies
WHERE country='India'
GROUP BY release_year
```
**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List all movies that are documentaries
```sql
SELECT title,type,listed_in 
FROM movies
WHERE type='Movie' 
   AND listed_in LIKE '%Documentaries%'
ORDER BY title
```
**Objective:** Retrieve all movies classified as documentaries.

### 12. Find all content without a director
```sql
SELECT title FROM movies
WHERE director IS NULL OR director = ''
```
**Objective:** List content that does not have a director.

### 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
```sql
SELECT COUNT (*) AS total_movies
FROM movies
WHERE cast LIKE '%Salman Khan%' AND release_year >= 2009;
```
**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
```sql
SELECT TOP 10 
  TRIM (value) AS actor,
  COUNT(*) AS total_movies
FROM movies
CROSS APPLY STRING_SPLIT(cast, ',')
WHERE country = 'India' AND type = 'Movie'
GROUP BY TRIM (value)
ORDER BY total_movies DESC
```
**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keyword
```sql
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
```
**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.
## Dashboard Design & Visualization

To better understand the insights from the dataset, an **interactive dashboard** was developed using **Power BI** to visualize the Netflix content library.

### Dashboard Preview
![Netflix Dashboard](https://github.com/FathimaNafra/Netflix_Movie_Analysis/blob/main/netflix_dashboard.png)

### Key Dashboard Features

#### 1. KPI Summary Cards
The dashboard displays key statistics about the Netflix dataset:

- **Total Titles:** 6K  
- **Movies:** 4K  
- **TV Shows:** 2K  
- **Countries Represented:** 172  

These KPIs provide a quick overview of the Netflix content library.

#### 2. Interactive Filters
Users can explore the data dynamically using filters:

- **Type:** Movie or TV Show  
- **Release Year Range:** Filter content by year  
- **Country:** Search and filter by country  
- **Title Search:** Find specific titles  

These filters allow flexible exploration of the dataset.

#### 3. Content Growth by Release Year
A **line chart** shows how the number of Netflix titles has grown over time.  
The visualization highlights the rapid increase in content after **2015**, showing how the platform expanded its library.

#### 4. Genre Distribution
A **bar chart** displays the **Top genres** based on the number of titles.  
It also compares **Movies and TV Shows**, helping identify the most common categories such as:

- Documentaries  
- Stand-Up Comedy  
- Dramas  
- Comedies  
- Kids TV  

#### 5. Content Rating Distribution
A **donut chart** visualizes the distribution of titles by maturity ratings such as:

- TV-MA  
- TV-14  
- TV-PG  
- PG-13  
- R  

This helps understand the target audience of the platform.

#### 6. Global Content Production
A **world map visualization** highlights countries producing Netflix content.  
The darker regions represent countries with a higher number of titles.

#### 7. Content Details Table
The dashboard also includes a **detailed table view** showing:

- Title  
- Director  
- Cast  
- Country  
- Release Year  
- Rating  
- Duration  

This allows users to explore individual content records.

---

### Key Insights

- Netflix has **significantly expanded its content library after 2015**.  
- **Movies dominate the platform**, making up the majority of titles.  
- **Documentaries and dramas** are among the most common genres.  
- **TV-MA and TV-14** ratings appear most frequently.  
- Content is produced across **170+ countries worldwide**.

## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.

