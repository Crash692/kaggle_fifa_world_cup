CREATE TABLE IF NOT EXISTS gold.Dim_Awards (
    award_id VARCHAR PRIMARY KEY,
    award_name VARCHAR NOT NULL,
    award_description TEXT,
    year_introduced INT
);

INSERT INTO gold.Dim_Awards (award_id, award_name, award_description, year_introduced)
SELECT DISTINCT
    award_id,
    INITCAP(award_name) AS award_name,
    INITCAP(award_description) AS award_description,
    year_introduced
FROM silver.awards
WHERE award_id IS NOT NULL;
