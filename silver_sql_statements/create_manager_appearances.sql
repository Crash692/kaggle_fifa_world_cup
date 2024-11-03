CREATE TABLE IF NOT EXISTS silver.manager_appearances (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    match_id VARCHAR(255),
    match_name VARCHAR(255),
    match_date DATE,
    stage_name VARCHAR(255),
    group_name VARCHAR(255),
    team_id VARCHAR(255),
    team_name VARCHAR(255),
    team_code VARCHAR(255),
    home_team INT,
    away_team INT,
    manager_id VARCHAR(255),
    family_name VARCHAR(255),
    given_name VARCHAR(255),
    country_name VARCHAR(255)
);
