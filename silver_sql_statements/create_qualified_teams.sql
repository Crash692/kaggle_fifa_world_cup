CREATE TABLE IF NOT EXISTS silver.qualified_teams (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    team_id VARCHAR(255),
    team_name VARCHAR(255),
    team_code VARCHAR(255),
    count_matches INT,
    performance VARCHAR(255)
);
