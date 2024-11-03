CREATE TABLE IF NOT EXISTS gold.Dim_Managers (
    manager_id VARCHAR PRIMARY KEY,
    family_name TEXT,
    given_name TEXT,
    country_name TEXT
);

INSERT INTO gold.Dim_Managers (manager_id, family_name, given_name, country_name)
SELECT DISTINCT
    manager_id,
    INITCAP(family_name) AS family_name,
    INITCAP(given_name) AS given_name,
    INITCAP(country_name) AS country_name
FROM silver.managers;
