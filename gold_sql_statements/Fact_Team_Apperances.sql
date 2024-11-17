CREATE TABLE IF NOT EXISTS gold.Fact_Team_Appearances (
    appearance_id INT PRIMARY KEY,
    match_id VARCHAR REFERENCES gold.Fact_Match_Results(match_id),
    team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    opponent_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    stage_name VARCHAR,
    group_name VARCHAR,
    match_date DATE,
    goals_for INT,
    goals_against INT,
    goal_difference INT,
    result VARCHAR,      
    is_home_team BOOLEAN,
    penalties_for INT,
    penalties_against INT
);

INSERT INTO gold.Fact_Team_Appearances (
    appearance_id,
    match_id,
    team_id,
    opponent_id,
    tournament_id,
    stage_name,
    group_name,
    match_date,
    goals_for,
    goals_against,
    goal_difference,
    result,
    is_home_team,
    penalties_for,
    penalties_against
)
SELECT
    ta.key_id as appearance_id,
    ta.match_id,
    ta.team_id,
    ta.opponent_id,
    ta.tournament_id,
    INITCAP(ta.stage_name) AS stage_name,
    INITCAP(ta.group_name) AS group_name,
    ta.match_datetime,
    ta.goals_for,
    ta.goals_against,
    (ta.goals_for - ta.goals_against) AS goal_difference,
    CASE 
        WHEN ta.win = 1 THEN 'win'
        WHEN ta.lose = 1 THEN 'lose'
        ELSE 'draw'
    END AS result,
    ta.home_team = 1 AS is_home_team,
    ta.penalties_for,
    ta.penalties_against
FROM silver.team_appearances ta;
