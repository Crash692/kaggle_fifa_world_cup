INSERT INTO silver.groups (
    key_id,
    tournament_id, 
    tournament_name, 
    stage_number, 
    stage_name, 
    group_name, 
    count_teams
)
SELECT 
    key_id,
    tournament_id, 
    INITCAP(tournament_name) AS tournament_name, 
    stage_number, 
    INITCAP(stage_name) AS stage_name, 
    INITCAP(group_name) AS group_name, 
    count_teams
FROM bronze.groups;
