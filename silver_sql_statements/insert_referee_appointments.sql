INSERT INTO silver.referee_appointments (
    key_id, 
    tournament_id, 
    tournament_name, 
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
    referee_id, 
    INITCAP(family_name) AS family_name, 
    INITCAP(given_name) AS given_name, 
    INITCAP(country_name) AS country_name, 
    confederation_id, 
    INITCAP(confederation_name) AS confederation_name, 
    confederation_code
FROM bronze.referee_appointments;
