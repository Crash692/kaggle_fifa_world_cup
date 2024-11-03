CREATE TABLE IF NOT EXISTS gold.Fact_Referee_Appearances (
    appearance_id SERIAL PRIMARY KEY,
    referee_id VARCHAR REFERENCES gold.Dim_Referees(referee_id),
    match_id VARCHAR REFERENCES gold.Fact_Match_Results(match_id),
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    stage_name VARCHAR,
    group_name VARCHAR,
    match_date DATE
);


INSERT INTO gold.Fact_Referee_Appearances (
    referee_id, 
    match_id, 
    tournament_id,  
    stage_name, 
    group_name, 
    match_date
)
SELECT DISTINCT 
    referee_id,
    match_id,
    tournament_id,
    INITCAP(stage_name) AS stage_name,
    INITCAP(group_name) AS group_name,
    match_date::DATE
FROM silver.referee_appearances
WHERE referee_id IS NOT NULL
  AND match_id IS NOT NULL
  AND tournament_id IS NOT NULL;
