INSERT INTO silver.teams (
    key_id, 
    team_id, 
    team_name, 
    team_code, 
    federation_name, 
    region_name, 
    confederation_id, 
    confederation_name, 
    confederation_code, 
    team_wikipedia_link, 
    federation_wikipedia_link
)
SELECT 
    key_id, 
    team_id, 
    INITCAP(team_name) AS team_name, 
    team_code, 
    INITCAP(federation_name) AS federation_name, 
    INITCAP(region_name) AS region_name, 
    confederation_id, 
    INITCAP(confederation_name) AS confederation_name, 
    confederation_code, 
    team_wikipedia_link, 
    federation_wikipedia_link
FROM bronze.teams;
