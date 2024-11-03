INSERT INTO silver.host_countries (
    key_id,
    tournament_id, 
    team_id, 
    team_name, 
    team_code
)
SELECT
    key_id,
    tournament_id, 
    team_id, 
    INITCAP(team_name) AS team_name, 
    team_code
FROM bronze.host_countries;
