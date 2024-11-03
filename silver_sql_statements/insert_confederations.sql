INSERT INTO silver.confederations (
    confederation_id,
    confederation_name,
    confederation_code,
    confederation_wikipedia_link
)
SELECT 
    confederation_id,
    INITCAP(confederation_name) AS confederation_name,
    confederation_code,
    confederation_wikipedia_link
FROM bronze.confederations;
