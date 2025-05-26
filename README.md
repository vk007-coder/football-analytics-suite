# football-analytics-suite

# ⚽ Football Analytics Database Project

This project creates a structured MySQL database for analyzing football match data. It uses CSV files to populate relational tables and includes SQL scripts for team statistics, player performance, coach impact, referee analysis, and more.

---

## 🧰 Features

- League-wise player goal scoring analysis
- Team performance across seasons (points, goals, ratios)
- Referee influence on matches (cards/fouls)
- Home advantage correlation with stadium capacity
- Coach impact on team performance

---

## 📁 Project Structure

football-analytics/
│
├── schema/
│ └── create_tables.sql # SQL script to create all tables
│
├── data/
│ └── *.csv # Raw data files (players.csv, matches.csv, etc.)
│
├── queries/
│ └── analysis_queries.sql # All analytical SQL queries
│
├── README.md # Documentation (you are here)

yaml
Copy
Edit

---

## ⚙️ Prerequisites

- MySQL Server 8.x or above
- MSQL Workbench
- CSV data placed in:
C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/

Ensure MySQL is configured to allow local file loads:

```ini
# my.ini or my.cnf under [mysqld]
secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/"

🏁 Step 1: Create Database and Tables
Create Database
sql
Copy
Edit
CREATE DATABASE IF NOT EXISTS football;
USE football;
Create All Tables
Run the script schema/create_tables.sql which includes:

leagues

seasons

teams

players

coaches

referees

stadiums

matches

scores

standings

📥 Step 2: Load CSV Data into Tables

Ensure CSVs are saved with Windows line endings (\r\n) and column headers match the schema.

Example:

sql
Copy
Edit
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/coaches.csv'
INTO TABLE football.coaches
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
Repeat for:

players.csv

teams.csv

matches.csv

scores.csv

standings.csv

referees.csv

stadiums.csv

seasons.csv

leagues.csv

📊 Step 3: Execute Analytical Queries
Run the queries in queries/analysis_queries.sql. Some highlights:

1. 🎯 Goal Scorers per League
sql
Copy
Edit
SELECT 
    l.name AS league_name,
    t.name AS team_name,
    SUM(s.home_score + s.away_score) AS total_goals
FROM 
    football.matches m
JOIN football.scores s ON m.match_id = s.match_id
JOIN football.teams t ON m.home_team_id = t.team_id
JOIN football.leagues l ON m.league_id = l.league_id
GROUP BY l.name, t.name
ORDER BY total_goals DESC;

2. 📈 Team Performance Analysis
sql
Copy
Edit
SELECT 
    t.name AS team_name,
    s.season_id,
    SUM(s.points) AS total_points,
    SUM(s.goals_for) AS goals_for,
    SUM(s.goals_against) AS goals_against,
    SUM(s.won) / NULLIF(SUM(s.played), 0) AS win_ratio,
    SUM(s.lost) / NULLIF(SUM(s.played), 0) AS loss_ratio
FROM 
    football.standings s
JOIN football.teams t ON s.team_id = t.team_id
GROUP BY t.name, s.season_id
ORDER BY total_points DESC;


🧠 SQL Functions Used in Queries
This section documents the purpose and usage of built-in SQL functions applied in your analytics queries:

✅ COUNT(*)
Purpose: Counts the number of rows in a group.

Used in: Goal scorers per league to count goals scored by each player.

Example:

SELECT player_name, COUNT(*) AS goals_scored
✅ SUM(column)
Purpose: Returns the total sum of a numeric column.

Used in:

Team performance metrics (e.g., points, goals)

Calculating home win stats by stadium

Example:

SUM(points) AS total_points
✅ AVG(column)
Purpose: Returns the average value of a numeric column.

Used in: Can be added to calculate average goals or fouls per match (not yet in current queries, but useful).


AVG(goals_for)
✅ GROUP BY
Purpose: Groups result rows based on one or more columns.

Used in: All aggregation queries like grouping by league_name, team_name, etc.

Example:

GROUP BY league_name, player_name
✅ ORDER BY
Purpose: Sorts the result set in ascending or descending order.

Used in: Ranking teams, players, referees, etc.

Example:

ORDER BY total_goals DESC
✅ JOIN
Purpose: Combines rows from two or more tables based on related columns.

Used in: All queries to combine related data across matches, scores, players, teams, etc.

Types Used:

INNER JOIN (default): Returns only matching rows.

Example:

JOIN football.teams t ON m.home_team_id = t.team_id
✅ NULLIF(a, b)
Purpose: Returns NULL if a = b, otherwise returns a.

Used in: To prevent division-by-zero errors and clean empty string fields.

Example:

SUM(won) / NULLIF(SUM(played), 0) AS win_ratio
✅ FROM_UNIXTIME(epoch)
Purpose: Converts a Unix timestamp to human-readable DATETIME.

Used in: Converting date_of_birth from epoch milliseconds to date format.

FROM_UNIXTIME(date_of_birth / 1000)
✅ LIMIT
Purpose: Restricts the number of rows returned.

Used in: Previewing top records like goal scorers or top teams.

Error: The MySQL server is running with the --secure-file-priv option
➤ Make sure your file is placed in the path set for secure-file-priv in MySQL config.

Incorrect date or epoch fields
➤ Use FROM_UNIXTIME(date_of_birth / 1000) if dates are stored as Unix timestamps.

