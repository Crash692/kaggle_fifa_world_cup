INSERT INTO silver.awards (key_id, award_id, award_name, award_description, year_introduced)
SELECT 
    key_id, 
    award_id, 
    award_name, 
    INITCAP(award_description) AS award_description,
    year_introduced
FROM bronze.awards;
