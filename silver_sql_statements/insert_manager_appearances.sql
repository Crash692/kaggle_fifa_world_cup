INSERT INTO silver.manager_appearances (
    key_id,
    tournament_id, 
    tournament_name, 
    match_id, 
    match_name, 
    match_date, 
    stage_name, 
    group_name, 
    team_id, 
    team_name, 
    team_code, 
    home_team, 
    away_team, 
    manager_id, 
    family_name, 
    given_name, 
    country_name
)
SELECT
    key_id,
    tournament_id, 
    INITCAP(tournament_name) AS tournament_name, 
    match_id, 
    INITCAP(match_name) AS match_name, 
    match_date::DATE, 
    INITCAP(stage_name) AS stage_name, 
    INITCAP(group_name) AS group_name, 
    team_id, 
    INITCAP(team_name) AS team_name, 
    team_code, 
    home_team, 
    away_team, 
    manager_id, 
    INITCAP(family_name) AS family_name, 
    INITCAP(given_name) AS given_name, 
    INITCAP(country_name) AS country_name
FROM bronze.manager_appearances;