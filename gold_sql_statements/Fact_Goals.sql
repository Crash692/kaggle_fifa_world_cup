CREATE TABLE IF NOT EXISTS gold.Fact_Goals (
    goal_id VARCHAR PRIMARY KEY,
    match_id VARCHAR REFERENCES gold.Fact_Match_Results(match_id),
    player_id VARCHAR REFERENCES gold.Dim_Players(player_id),
    team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    minute INT,
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    goal_type TEXT
);

INSERT INTO gold.Fact_Goals (goal_id, match_id, player_id, team_id, minute, tournament_id, goal_type)
SELECT
    goal_id,
    match_id,
    player_id,
    team_id,
    minute_regulation AS minute,
    tournament_id,
    CASE WHEN own_goal = 1 THEN 'Own Goal' WHEN penalty = 1 THEN 'Penalty' ELSE 'Regular' END AS goal_type
FROM silver.goals;
