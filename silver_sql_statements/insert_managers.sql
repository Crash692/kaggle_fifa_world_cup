INSERT INTO silver.managers (
    manager_id, 
    family_name, 
    given_name, 
    country_name, 
    manager_wikipedia_link
)
SELECT 
    manager_id, 
    INITCAP(family_name) AS family_name, 
    INITCAP(given_name) AS given_name, 
    INITCAP(country_name) AS country_name, 
    manager_wikipedia_link
FROM bronze.managers;
