CREATE TABLE IF NOT EXISTS gold.Dim_Teams (
    team_id VARCHAR PRIMARY KEY,
    team_name TEXT,
    team_code VARCHAR(3),
    federation_name TEXT,
    confederation_code VARCHAR(10)
);

INSERT INTO gold.Dim_Teams (team_id, team_name, team_code, federation_name, confederation_code)
SELECT DISTINCT
    team_id,
    INITCAP(team_name) AS team_name,
    team_code,
    INITCAP(federation_name) AS federation_name,
    confederation_code
FROM silver.teams;
