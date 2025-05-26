/* Players and Their Teams */

SELECT 
    p.name AS player_name,
    t.name AS team_name
FROM 
    football.players p
JOIN 
    football.teams t ON p.team_id = t.team_id;


/* Coach and Team Name */
SELECT 
    c.name AS coach_name,
    t.name AS team_name,
    c.nationality
FROM 
    football.coaches c
JOIN 
    football.teams t ON c.team_id = t.team_id;

/* Sadium capactity per team */
  SELECT 
    t.name AS team_name,
    s.name AS stadium_name,
    s.capacity
FROM 
    football.teams t
JOIN 
    football.stadiums s ON t.stadium_id = s.stadium_id;



/*  Team Performance Analysis */
SELECT 
    t.name AS team_name,
    se.year AS season_year,
    s.points,
    s.goals_for,
    s.goals_against,
    s.won,
    s.lost,
    ROUND(s.won / NULLIF((s.won + s.lost + s.draw), 0), 2) AS win_ratio
FROM football.standings s
JOIN football.teams t ON s.team_id = t.team_id
JOIN football.seasons se ON s.season_id = se.season_id
ORDER BY season_year, team_name;


/* Player Nationality Distribution per Team  */
SELECT 
    t.name AS team_name,
    p.nationality,
    COUNT(*) AS player_count
FROM 
    football.players p
JOIN 
    football.teams t ON p.team_id = t.team_id
GROUP BY 
    t.name, p.nationality
ORDER BY 
    t.name;


/* Team Performance Under Different Coaches */
SELECT 
    c.name AS coach_name,
    t.name AS team_name,
    se.year AS season_year,
    SUM(s.points) AS total_points,
    SUM(s.won) AS total_wins,
    SUM(s.lost) AS total_losses,
    ROUND(SUM(s.won) / NULLIF(SUM(s.won + s.lost + s.draw), 0), 2) AS win_ratio
FROM football.standings s
JOIN football.teams t ON s.team_id = t.team_id
JOIN football.seasons se ON s.season_id = se.season_id
JOIN football.coaches c ON t.coach_id = c.coach_id
GROUP BY c.name, t.name, se.year
ORDER BY total_points DESC;


/ *team_season_performance_summary */
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
