INSERT INTO silver.manager_appointments (
    key_id,
    tournament_id, 
    tournament_name, 
    team_id, 
    team_name, 
    team_code, 
    manager_id, 
    family_name, 
    given_name, 
    country_name
)
SELECT
    key_id,
    tournament_id, 
    INITCAP(tournament_name) AS tournament_name, 
    team_id, 
    INITCAP(team_name) AS team_name, 
    team_code, 
    manager_id, 
    INITCAP(family_name) AS family_name, 
    INITCAP(given_name) AS given_name, 
    INITCAP(country_name) AS country_name
FROM bronze.manager_appointments;
