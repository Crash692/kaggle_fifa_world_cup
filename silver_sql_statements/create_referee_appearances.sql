CREATE TABLE IF NOT EXISTS silver.referee_appearances (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    match_id VARCHAR(255),
    match_name VARCHAR(255),
    match_date DATE,
    stage_name VARCHAR(255),
    group_name VARCHAR(255),
    referee_id VARCHAR(255),
    family_name VARCHAR(255),
    given_name VARCHAR(255),
    country_name VARCHAR(255),
    confederation_id VARCHAR(255),
    confederation_name VARCHAR(255),
    confederation_code VARCHAR(255)
);
