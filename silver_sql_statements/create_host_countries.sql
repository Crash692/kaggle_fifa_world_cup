CREATE TABLE IF NOT EXISTS silver.host_countries (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    team_id VARCHAR(255),
    team_name VARCHAR(255),
    team_code VARCHAR(255)
);
