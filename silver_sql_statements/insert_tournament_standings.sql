INSERT INTO silver.tournament_standings (
    key_id, 
    tournament_id, 
    tournament_name, 
    position, 
    team_id, 
    team_name, 
    team_code
)
SELECT 
    key_id, 
    tournament_id, 
    INITCAP(tournament_name) AS tournament_name, 
    position, 
    team_id, 
    INITCAP(team_name) AS team_name, 
    team_code
FROM bronze.tournament_standings;
