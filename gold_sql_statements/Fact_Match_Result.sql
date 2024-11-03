CREATE TABLE IF NOT EXISTS gold.Fact_Match_Results (
    match_id VARCHAR PRIMARY KEY,
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    match_datetime TIMESTAMP,
    stadium_id VARCHAR REFERENCES gold.Dim_Stadiums(stadium_id),
    home_team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    away_team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    home_team_score INT,
    away_team_score INT,
    result TEXT,
    stage_name VARCHAR
);


INSERT INTO gold.Fact_Match_Results (match_id, tournament_id, match_datetime, stadium_id, home_team_id, away_team_id, home_team_score, away_team_score, result, stage_name)
SELECT DISTINCT
    match_id,
    tournament_id,
    match_datetime,
    stadium_id,
    home_team_id,
    away_team_id,
    home_team_score,
    away_team_score,
    CASE
        WHEN home_team_score > away_team_score THEN 'Home Win'
        WHEN home_team_score < away_team_score THEN 'Away Win'
        ELSE 'Draw'
    END AS result,
    stage_name AS stage_name
FROM silver.matches;

