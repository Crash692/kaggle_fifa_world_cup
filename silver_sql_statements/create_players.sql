CREATE TABLE IF NOT EXISTS silver.players (
    key_id INT PRIMARY KEY,
    player_id VARCHAR(255),
    family_name VARCHAR(255),
    given_name VARCHAR(255),
    birth_date DATE,
    goal_keeper INT,
    defender INT,
    midfielder INT,
    forward INT,
    count_tournaments INT,
    list_tournaments VARCHAR(255),
    player_wikipedia_link TEXT
);
