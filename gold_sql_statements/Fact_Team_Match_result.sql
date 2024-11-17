CREATE TABLE IF NOT EXISTS gold.Fact_Team_Match_Results (
    match_id VARCHAR REFERENCES gold.Fact_Match_Results(match_id),
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    opponent_team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    team_score INT,
    opponent_score INT,
    result TEXT,
    stage_name VARCHAR,
    penalty_score TEXT, -- e.g., '5–3'
    PRIMARY KEY (match_id, team_id, opponent_team_id) -- Composite Primary Key
);


INSERT INTO gold.Fact_Team_Match_Results (
    match_id, 
    tournament_id, 
    team_id, 
    opponent_team_id, 
    team_score, 
    opponent_score, 
    result,
    stage_name,
    penalty_score
)
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
        WHEN penalty_shootout = 1 AND home_team_score_penalties > away_team_score_penalties THEN 'Penalty Win'
        WHEN penalty_shootout = 1 AND home_team_score_penalties < away_team_score_penalties THEN 'Penalty Loss'
        WHEN extra_time = 1 AND home_team_score > away_team_score THEN 'Extra Time Win'
        WHEN extra_time = 1 AND home_team_score < away_team_score THEN 'Extra Time Loss'
        ELSE 'Draw'
    END AS result,
    stage_name,
    CASE
        WHEN penalty_shootout = 1 THEN score_penalties
        ELSE NULL
    END AS penalty_score
FROM silver.matches
ON CONFLICT (match_id, team_id, opponent_team_id) DO NOTHING;

INSERT INTO gold.Fact_Team_Match_Results (
    match_id, 
    tournament_id, 
    team_id, 
    opponent_team_id, 
    team_score, 
    opponent_score, 
    result,
    stage_name,
    penalty_score
)
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
        WHEN penalty_shootout = 1 AND away_team_score_penalties > home_team_score_penalties THEN 'Penalty Win'
        WHEN penalty_shootout = 1 AND away_team_score_penalties < home_team_score_penalties THEN 'Penalty Loss'
        WHEN extra_time = 1 AND away_team_score > home_team_score THEN 'Extra Time Win'
        WHEN extra_time = 1 AND away_team_score < home_team_score THEN 'Extra Time Loss'
        ELSE 'Draw'
    END AS result,
    stage_name,
    CASE
        WHEN penalty_shootout = 1 THEN score_penalties
        ELSE NULL
    END AS penalty_score
FROM silver.matches
ON CONFLICT (match_id, team_id, opponent_team_id) DO NOTHING;
