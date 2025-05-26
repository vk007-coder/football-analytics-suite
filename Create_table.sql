Create a table as below

-- 1. Leagues
use football;
CREATE TABLE leagues (
  league_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  country VARCHAR(100),
  tier INT,
  type VARCHAR(50),
  start_date DATE,
  end_date DATE,
  description TEXT
);

-- 2. Seasons
CREATE TABLE seasons (
  season_id INT AUTO_INCREMENT PRIMARY KEY,
  league_id INT,
  year VARCHAR(10),
);

-- 3. Teams
CREATE TABLE teams (
  team_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  short_name VARCHAR(20),
  abbreviation VARCHAR(10),
  league_id INT,
  founded_year INT,
  country VARCHAR(100),
);

-- 4. Players
CREATE TABLE football.players (
  player_id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  nationality VARCHAR(100),
  position VARCHAR(50),
  team_id INT,
  date_of_birth BIGINT, -- epoch in milliseconds
);
-- 5. Coaches
CREATE TABLE coaches (
  coach_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  nationality VARCHAR(100),
  team_id INT,
);

-- 6. Referees
CREATE TABLE referees (
  referee_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  nationality VARCHAR(100)
);

-- 7. Stadiums
CREATE TABLE stadiums (
  stadium_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  location VARCHAR(100),
  capacity INT,
  team_id INT
);

-- 8. Matches
CREATE TABLE matches (
  match_id INT AUTO_INCREMENT PRIMARY KEY,
  home_team_id INT,
  away_team_id INT,
  match_date DATE,
  league_id INT,
  season_id INT,
  referee_id INT,
  status VARCHAR(20)
);

-- 9. Scores
CREATE TABLE scores (
  score_id INT AUTO_INCREMENT PRIMARY KEY,
  match_id INT,
  home_score INT,
  away_score INT,
  halftime_home INT,
  halftime_away INT,
  full_time_status VARCHAR(20)
);

-- 10. Standings
CREATE TABLE standings (
  standing_id INT AUTO_INCREMENT PRIMARY KEY,
  team_id INT,
  league_id INT,
  season_id INT,
  position INT,
  played INT,
  won INT,
  draw INT,
  lost INT,
  goals_for INT,
  goals_against INT,
  goal_diff INT,
  points INT,
  form VARCHAR(20)
);

--USE the below to LOAD the CSV file data directly from CLI--
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/coaches.csv'
INTO TABLE football.coaches
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
