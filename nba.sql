create database NBA;
use NBA;

SELECT TOP 10 * FROM dbo.nba_games;

----data cleaning
ALTER TABLE dbo.nba_games
DROP COLUMN column1;

DELETE FROM dbo.nba_games
WHERE player_name IS NULL;

---
SELECT player_name, pts,gp, reb, ast,draft_year,net_rating,team_abbreviation
FROM dbo.nba_games
WHERE draft_year = '2021'
ORDER BY 3 DESC;

-----calculating the average points,rebounds and assist
SELECT
    AVG(pts) AS AveragePoints,
    AVG(reb) AS AverageRebounds,
    AVG(ast) AS AverageAssists
FROM dbo.nba_games ;

----finding the players with the highest career points and reounds 
-- For career points
SELECT TOP 1 player_name, pts
FROM dbo.nba_games
ORDER BY pts DESC;

-- For career rebounds
SELECT TOP 1 player_name , reb
FROM dbo.nba_games
ORDER BY reb DESC;
 
 ----analysing the players by Age, Height and weight 
 
 SELECT
    MIN(age) AS MinAge,
    MAX(age) AS MaxAge,
    AVG(age) AS AverageAge,
    COUNT(*) AS TotalPlayers
FROM dbo.nba_games;

 SELECT
    MIN(player_height) AS Min_height,
    MAX(player_height) AS Max_height,
    AVG(player_height) AS av_height,
    COUNT(*) AS TotalPlayers
FROM dbo.nba_games;



 SELECT
    MIN(player_weight) AS Min_weight,
    MAX(player_weight) AS Max_weight,
    AVG(player_weight) AS av_weight,
    COUNT(*) AS TotalPlayers
FROM dbo.nba_games;

------ exploring the draft trends over the years
SELECT
    draft_year,
    COUNT(*) AS PlayersDrafted
FROM dbo.nba_games
WHERE draft_year IS NOT NULL
GROUP BY draft_year
ORDER BY draft_year;

select * from dbo.nba_games

