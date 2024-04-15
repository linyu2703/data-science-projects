-- This is an exploratory analysis of NETFLIX database, using SQL in postgres.
-- Goal: discovering insights on NETFLIX shows and movies, through series of queries that would peak an user's interest.

-- CREATE TABLE credits (
-- 	person_id INTEGER,
-- 	id VARCHAR(50),
-- 	name VARCHAR(100),
-- 	character VARCHAR(500),
-- 	role VARCHAR(20)
-- );

-- COPY credits(person_id, id, name, character, role) 
-- FROM '/Users/yulin/Downloads/credits.csv'
-- DELIMITER ','
-- CSV HEADER;

-- testing if credits successfully imported
-- SELECT * FROM credits

-- CREATE TABLE titles (
-- 	id VARCHAR(50),
-- 	title TEXT,
-- 	type VARCHAR(100),
-- 	description TEXT,
-- 	release_year INTEGER,
-- 	age_certification VARCHAR(10),
-- 	runtime INTEGER,
-- 	genres TEXT,
-- 	production_countries TEXT,
-- 	seasons FLOAT,
-- 	imdb_id VARCHAR(50),
-- 	imdb_score FLOAT,
-- 	imdb_votes FLOAT,
-- 	tmdb_popularity FLOAT,
-- 	tmdb_score FLOAT
-- );

-- COPY titles(id, title, type, description, release_year, age_certification, runtime, genres, production_countries, seasons, imdb_id, imdb_score, imdb_votes, tmdb_popularity, tmdb_score) 
-- FROM '/Users/yulin/Downloads/titles.csv'
-- DELIMITER ','
-- CSV HEADER;

-- testing if titles successfully imported
-- SELECT * FROM titles;

-- -- top 10 movies on Netflix, based on IMDB scores
-- SELECT title, type, imdb_score
-- FROM titles
-- WHERE type = 'MOVIE'
-- AND imdb_score IS NOT NULL
-- ORDER BY imdb_score DESC
-- LIMIT 10;

-- -- top 10 shows on Netflix, based on IMDB scores
-- SELECT title, type, imdb_score
-- FROM titles
-- WHERE type = 'SHOW'
-- AND imdb_score IS NOT NULL
-- ORDER BY imdb_score DESC 
-- LIMIT 10;

-- -- bottom 10 movies on Netflix, based on IMDB scores
-- SELECT title, type, imdb_score
-- FROM titles
-- WHERE type = 'MOVIE'
-- ORDER BY imdb_score ASC
-- LIMIT 10;

-- --bottom 10 shows on Netflix, based on IMDB scores
-- SELECT title, type, imdb_score
-- FROM titles
-- WHERE type = 'SHOW'
-- ORDER BY imdb_score ASC
-- LIMIT 10;

-- --average IMDB and TMDB scores for Netflix movies and shows
-- SELECT DISTINCT type, AVG(imdb_score) AS avgIMDB, AVG(tmdb_score) AS avgTMDB
-- FROM titles
-- GROUP BY type;

-- -- average IMDB and TMDB scores for Netflix movies and shows based on each country
-- SELECT DISTINCT production_countries, AVG(imdb_score) AS avgIMDB, AVG(tmdb_score) AS avgTMDB
-- FROM titles
-- GROUP BY production_countries;

-- -- average IMDB and TMDB scores for Netflix movies and shows based on age_certification
-- SELECT DISTINCT age_certification, AVG(imdb_score) AS avgIMDB, AVG(tmdb_score) AS avgTMDB
-- FROM titles
-- WHERE age_certification IS NOT NULL
-- GROUP BY age_certification;

-- --top 3 age certification for movies
-- SELECT age_certification, COUNT(*) AS certification_count
-- FROM titles
-- WHERE type = 'MOVIE'
-- AND age_certification IS NOT NULL
-- GROUP BY age_certification
-- ORDER BY certification_count DESC
-- LIMIT 3;

-- -- top 10 actors that appeared in the most movies and shows
-- SELECT name AS actor, COUNT(*) AS appearances
-- FROM credits
-- WHERE role = 'ACTOR'
-- GROUP BY name
-- ORDER BY appearances DESC
-- LIMIT 10;

-- -- top 10 directors that directed the most movies and shows
-- SELECT name AS director, COUNT(*) AS directed
-- FROM credits
-- WHERE role = 'DIRECTOR'
-- GROUP BY name
-- ORDER BY directed DESC
-- LIMIT 10;

-- --average runtime of Netflix movies and shows
-- SELECT 'MOVIE' AS content_type,
-- ROUND(AVG(runtime),2) AS avg_runtime
-- FROM titles
-- WHERE type = 'MOVIE'
-- UNION ALL --combines the result of the two select statements {movie/show}
-- SELECT 'SHOW' AS content_type,
-- ROUND(AVG(runtime),2) AS avg_runtime
-- FROM titles
-- WHERE type = 'SHOW';

-- -- top 10 shows on Netflix with the most seasons
-- SELECT title, SUM(seasons) AS total_seasons
-- FROM titles
-- WHERE type = 'SHOW'
-- GROUP BY title
-- ORDER BY total_seasons DESC
-- LIMIT 10;

-- -- top 5 genres of most movies
-- SELECT genres, COUNT(*) AS total --count() func. counts the number of rows, sum() func. is used to total sum of all values
-- FROM titles
-- WHERE type = 'MOVIE'
-- GROUP BY genres
-- ORDER BY total DESC
-- LIMIT 5;

-- --top 5 genres of most shows
-- SELECT genres, COUNT(*) AS total
-- FROM titles
-- WHERE type = 'SHOW'
-- GROUP BY genres
-- ORDER BY total DESC
-- LIMIT 5;

-- -- top 5 actors that starred in most highly rated movies or shows
-- SELECT c.name AS actor, COUNT(*) AS total
-- FROM credits AS c
-- INNER JOIN titles AS t
-- ON c.id = t.id
-- WHERE c.role = 'ACTOR'
-- AND (t.type = 'MOVIE' or t.type = 'SHOW')
-- AND (t.imdb_score >= 8)
-- AND (t.tmdb_score >= 8)
-- GROUP BY c.name
-- ORDER BY total DESC
-- LIMIT 5;

--future areas of improvement:
-- 1.clean data more e.g. renaming the production_countries column from titles
-- 2.more complex queries with more interesting questions
-- 3.create a new tableau dashboard of findings
