INSERT INTO silver.award_winners (key_id, tournament_id, tournament_name, award_id, award_name, shared, player_id, family_name, given_name, team_id, team_name, team_code)
SELECT 
    key_id, 
    tournament_id, 
    tournament_name,
    award_id, 
    award_name, 
    CASE WHEN shared IS NULL THEN 0 ELSE shared END AS shared, -- Taking Nulls under control
    player_id, 
    family_name, 
    given_name, 
    team_id, 
    team_name, 
    team_code
FROM bronze.award_winners;
