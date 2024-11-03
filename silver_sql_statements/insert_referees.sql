INSERT INTO silver.referees (
    key_id, 
    referee_id, 
    family_name, 
    given_name, 
    country_name, 
    confederation_id, 
    confederation_name, 
    confederation_code, 
    referee_wikipedia_link
)
SELECT 
    key_id, 
    referee_id, 
    INITCAP(family_name) AS family_name, 
    INITCAP(given_name) AS given_name, 
    INITCAP(country_name) AS country_name, 
    confederation_id, 
    INITCAP(confederation_name) AS confederation_name, 
    confederation_code, 
    referee_wikipedia_link
FROM bronze.referees;
