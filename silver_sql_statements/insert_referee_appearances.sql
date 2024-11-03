INSERT INTO silver.referee_appearances (
    key_id, 
    tournament_id, 
    tournament_name, 
    match_id, 
    match_name, 
    match_date, 
    stage_name, 
    group_name, 
    referee_id, 
    family_name, 
    given_name, 
    country_name, 
    confederation_id, 
    confederation_name, 
    confederation_code
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
    referee_id, 
    INITCAP(family_name) AS family_name, 
    INITCAP(given_name) AS given_name, 
    INITCAP(country_name) AS country_name, 
    confederation_id, 
    INITCAP(confederation_name) AS confederation_name, 
    confederation_code
FROM bronze.referee_appearances;
