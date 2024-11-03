INSERT INTO silver.qualified_teams (
    key_id, 
    tournament_id, 
    tournament_name, 
    team_id, 
    team_name, 
    team_code, 
    count_matches, 
    performance
)
SELECT 
    key_id, 
    tournament_id, 
    INITCAP(tournament_name) AS tournament_name, 
    team_id, 
    INITCAP(team_name) AS team_name, 
    team_code, 
    count_matches, 
    INITCAP(performance) AS performance
FROM bronze.qualified_teams;
