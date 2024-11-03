CREATE TABLE IF NOT EXISTS gold.Dim_Stadiums (
    stadium_id VARCHAR PRIMARY KEY,
    stadium_name TEXT,
    city_name TEXT,
    country_name TEXT,
    stadium_capacity INT
);

INSERT INTO gold.Dim_Stadiums (stadium_id, stadium_name, city_name, country_name, stadium_capacity)
SELECT DISTINCT
    stadium_id,
    INITCAP(stadium_name) AS stadium_name,
    INITCAP(city_name) AS city_name,
    INITCAP(country_name) AS country_name,
    stadium_capacity
FROM silver.stadiums;
