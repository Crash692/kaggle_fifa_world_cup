CREATE TABLE IF NOT EXISTS gold.Fact_Substitutions (
    substitution_id VARCHAR PRIMARY KEY,
    match_id VARCHAR REFERENCES gold.Fact_Match_Results(match_id),
    player_id VARCHAR REFERENCES gold.Dim_Players(player_id),
    substitution_type VARCHAR CHECK (substitution_type IN ('Going on', 'Going off')),
    minute INT
);

INSERT INTO gold.Fact_Substitutions (substitution_id, match_id, player_id, substitution_type, minute)
SELECT 
    substitution_id,
    match_id,
    player_id,
    CASE 
        WHEN going_off = 1 THEN 'Going on'
        WHEN coming_on = 1 THEN 'Going off'
    END AS substitution_type,
    minute_regulation AS minute
FROM silver.substitutions
WHERE going_off = 1 OR coming_on = 1;
