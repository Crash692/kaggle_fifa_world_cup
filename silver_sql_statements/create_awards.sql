CREATE TABLE IF NOT EXISTS silver.awards (
    key_id INT,
    award_id VARCHAR(10) PRIMARY KEY,
    award_name VARCHAR(50),
    award_description VARCHAR(255),
    year_introduced INT
);
