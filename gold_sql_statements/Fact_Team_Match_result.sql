-- Create the table with a composite primary key
CREATE TABLE IF NOT EXISTS gold.Fact_Team_Match_Results (
    match_id VARCHAR REFERENCES gold.Fact_Match_Results(match_id),
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    opponent_team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    team_score INT,
    opponent_score INT,
    result TEXT,
    stage_name VARCHAR,
    PRIMARY KEY (match_id, team_id, opponent_team_id) -- Composite Primary Key
);

-- Insert data for the home team perspective
INSERT INTO gold.Fact_Team_Match_Results (match_id, tournament_id, team_id, opponent_team_id, team_score, opponent_score, result, stage_name)
SELECT DISTINCT
    match_id,
    tournament_id,
    home_team_id AS team_id,
    away_team_id AS opponent_team_id,
    home_team_score AS team_score,
    away_team_score AS opponent_score,
    CASE
        WHEN home_team_score > away_team_score THEN 'Win'
        WHEN home_team_score < away_team_score THEN 'Loss'
        ELSE 'Draw'
    END AS result,
    stage_name
FROM silver.matches
ON CONFLICT (match_id, team_id, opponent_team_id) DO NOTHING; -- Avoid duplicates

-- Insert data for the away team perspective
INSERT INTO gold.Fact_Team_Match_Results (match_id, tournament_id, team_id, opponent_team_id, team_score, opponent_score, result, stage_name)
SELECT DISTINCT
    match_id,
    tournament_id,
    away_team_id AS team_id,
    home_team_id AS opponent_team_id,
    away_team_score AS team_score,
    home_team_score AS opponent_score,
    CASE
        WHEN away_team_score > home_team_score THEN 'Win'
        WHEN away_team_score < home_team_score THEN 'Loss'
        ELSE 'Draw'
    END AS result,
    stage_name
FROM silver.matches
ON CONFLICT (match_id, team_id, opponent_team_id) DO NOTHING; -- Avoid duplicates
