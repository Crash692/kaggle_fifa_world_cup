CREATE TABLE IF NOT EXISTS gold.Dim_Tournaments (
    tournament_id VARCHAR PRIMARY KEY,
    tournament_name TEXT,
    year INT,
    host_country TEXT,
    winner TEXT
);

INSERT INTO gold.Dim_Tournaments (tournament_id, tournament_name, year, host_country, winner)
SELECT DISTINCT
    tournament_id,
    INITCAP(tournament_name) AS tournament_name,
    EXTRACT(YEAR FROM start_date) AS year,
    INITCAP(host_country) AS host_country,
    INITCAP(winner) AS winner
FROM silver.tournaments;
