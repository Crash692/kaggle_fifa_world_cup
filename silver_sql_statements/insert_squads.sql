INSERT INTO silver.squads (
    key_id, 
    tournament_id, 
    tournament_name, 
    team_id, 
    team_name, 
    team_code, 
    player_id, 
    family_name, 
    given_name, 
    shirt_number, 
    position_name, 
    position_code
)
SELECT 
    key_id, 
    tournament_id, 
    INITCAP(tournament_name) AS tournament_name, 
    team_id, 
    INITCAP(team_name) AS team_name, 
    team_code, 
    player_id, 
    INITCAP(family_name) AS family_name, 
    INITCAP(given_name) AS given_name, 
    shirt_number, 
    INITCAP(position_name) AS position_name, 
    position_code
FROM bronze.squads;
