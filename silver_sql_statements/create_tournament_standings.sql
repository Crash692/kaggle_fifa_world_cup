CREATE TABLE IF NOT EXISTS silver.tournament_standings (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    position INT,
    team_id VARCHAR(255),
    team_name VARCHAR(255),
    team_code VARCHAR(10)
);
