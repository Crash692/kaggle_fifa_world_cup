CREATE TABLE IF NOT EXISTS silver.stadiums (
    key_id INT PRIMARY KEY,
    stadium_id VARCHAR(255),
    stadium_name VARCHAR(255),
    city_name VARCHAR(255),
    country_name VARCHAR(255),
    stadium_capacity INT,
    stadium_wikipedia_link TEXT,
    city_wikipedia_link TEXT
);
