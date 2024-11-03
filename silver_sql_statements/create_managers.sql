CREATE TABLE IF NOT EXISTS silver.managers (
    manager_id VARCHAR(255) PRIMARY KEY,
    family_name VARCHAR(255),
    given_name VARCHAR(255),
    country_name VARCHAR(255),
    manager_wikipedia_link VARCHAR(255)
);
