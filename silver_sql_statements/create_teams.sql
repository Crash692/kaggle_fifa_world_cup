CREATE TABLE IF NOT EXISTS silver.teams (
    key_id INT PRIMARY KEY,
    team_id VARCHAR(255),
    team_name VARCHAR(255),
    team_code VARCHAR(10),
    federation_name VARCHAR(255),
    region_name VARCHAR(255),
    confederation_id VARCHAR(255),
    confederation_name VARCHAR(255),
    confederation_code VARCHAR(10),
    team_wikipedia_link TEXT,
    federation_wikipedia_link TEXT
);
