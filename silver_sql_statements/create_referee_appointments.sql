CREATE TABLE IF NOT EXISTS silver.referee_appointments (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    referee_id VARCHAR(255),
    family_name VARCHAR(255),
    given_name VARCHAR(255),
    country_name VARCHAR(255),
    confederation_id VARCHAR(255),
    confederation_name VARCHAR(255),
    confederation_code VARCHAR(255)
);
