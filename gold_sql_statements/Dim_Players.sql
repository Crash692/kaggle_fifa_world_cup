CREATE TABLE IF NOT EXISTS gold.Dim_Players (
    player_id VARCHAR PRIMARY KEY,
    family_name TEXT,
    given_name TEXT,
    full_name TEXT,
    birth_date DATE,
    position TEXT,
    player_wikipedia_link TEXT
);

INSERT INTO gold.Dim_Players (player_id, family_name, full_name, given_name, birth_date, position, player_wikipedia_link)
SELECT DISTINCT
    player_id,
    family_name,
    given_name,
    CONCAT(family_name, ' ',given_name) AS full_name,
    birth_date,
    CASE
        WHEN goal_keeper = 1 THEN 'Goalkeeper'
        WHEN defender = 1 THEN 'Defender'
        WHEN midfielder = 1 THEN 'Midfielder'
        WHEN forward = 1 THEN 'Forward'
        ELSE NULL
    END AS position,
    player_wikipedia_link
FROM silver.players;
