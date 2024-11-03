CREATE TABLE IF NOT EXISTS silver.squads (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    team_id VARCHAR(255),
    team_name VARCHAR(255),
    team_code VARCHAR(255),
    player_id VARCHAR(255),
    family_name VARCHAR(255),
    given_name VARCHAR(255),
    shirt_number INT,
    position_name VARCHAR(255),
    position_code VARCHAR(255)
);
