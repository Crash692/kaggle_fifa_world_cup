CREATE TABLE IF NOT EXISTS gold.Dim_Referees (
    referee_id VARCHAR PRIMARY KEY,
    family_name TEXT,
    given_name TEXT,
    country_name TEXT,
    confederation_code VARCHAR(10),
    referee_wikipedia_link TEXT
);

INSERT INTO gold.Dim_Referees (referee_id, family_name, given_name, country_name, confederation_code, referee_wikipedia_link)
SELECT DISTINCT
    referee_id,
    INITCAP(family_name) AS family_name,
    INITCAP(given_name) AS given_name,
    INITCAP(country_name) AS country_name,
    confederation_code,
    referee_wikipedia_link
FROM silver.referees;
