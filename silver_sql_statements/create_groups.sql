CREATE TABLE IF NOT EXISTS silver.groups (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    stage_number INTEGER,
    stage_name VARCHAR(255),
    group_name VARCHAR(255),
    count_teams INTEGER
);
