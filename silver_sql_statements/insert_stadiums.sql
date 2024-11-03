INSERT INTO silver.stadiums (
    key_id, 
    stadium_id, 
    stadium_name, 
    city_name, 
    country_name, 
    stadium_capacity, 
    stadium_wikipedia_link, 
    city_wikipedia_link
)
SELECT 
    key_id, 
    stadium_id, 
    INITCAP(stadium_name) AS stadium_name, 
    INITCAP(city_name) AS city_name, 
    INITCAP(country_name) AS country_name, 
    stadium_capacity, 
    stadium_wikipedia_link, 
    city_wikipedia_link
FROM bronze.stadiums;
