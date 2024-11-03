CREATE TABLE IF NOT EXISTS silver.manager_appointments (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    team_id VARCHAR(255),
    team_name VARCHAR(255),
    team_code VARCHAR(255),
    manager_id VARCHAR(255),
    family_name VARCHAR(255),
    given_name VARCHAR(255),
    country_name VARCHAR(255)
);
