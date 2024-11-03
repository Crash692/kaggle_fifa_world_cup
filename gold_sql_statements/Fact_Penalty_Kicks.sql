CREATE TABLE IF NOT EXISTS gold.Fact_Penalty_Kicks (
    penalty_kick_id VARCHAR PRIMARY KEY,
    match_id VARCHAR REFERENCES gold.Fact_Match_Results(match_id),
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    player_id VARCHAR REFERENCES gold.Dim_Players(player_id),
    team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    converted TEXT
);

INSERT INTO gold.Fact_Penalty_Kicks (penalty_kick_id, match_id, tournament_id, player_id, team_id, converted)
SELECT
    penalty_kick_id,
    match_id,
    tournament_id,
    player_id,
    team_id,
    CASE
        WHEN converted = 1 THEN 'GOOOOOAL'
        ELSE 'No Goal'
    END AS converted
FROM silver.penalty_kicks;

