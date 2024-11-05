INSERT INTO silver.players (
    key_id, 
    player_id, 
    family_name, 
    given_name, 
    birth_date, 
    goal_keeper, 
    defender, 
    midfielder, 
    forward, 
    count_tournaments, 
    list_tournaments, 
    player_wikipedia_link
)
SELECT 
    key_id, 
    player_id, 
    INITCAP(family_name) AS family_name,
    CASE 
        WHEN given_name = 'not available' THEN NULL 
        ELSE INITCAP(given_name) 
    END AS given_name, 
    CASE 
        WHEN birth_date = 'not available' THEN NULL 
        ELSE birth_date::DATE 
    END AS birth_date,
    goal_keeper, 
    defender, 
    midfielder, 
    forward, 
    count_tournaments, 
    list_tournaments, 
    player_wikipedia_link
FROM bronze.players;

