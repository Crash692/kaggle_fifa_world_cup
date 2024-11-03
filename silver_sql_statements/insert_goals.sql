INSERT INTO silver.goals (
    goal_id, 
    tournament_id, 
    tournament_name, 
    match_id, 
    match_name, 
    match_date, 
    stage_name, 
    group_name, 
    team_id, 
    team_name, 
    team_code, 
    home_team, 
    away_team, 
    player_id, 
    family_name, 
    given_name, 
    shirt_number, 
    player_team_id, 
    player_team_name, 
    player_team_code, 
    minute_label, 
    minute_regulation, 
    minute_stoppage, 
    match_period, 
    own_goal, 
    penalty
)
SELECT 
    goal_id, 
    tournament_id, 
    INITCAP(tournament_name) AS tournament_name, 
    match_id, 
    INITCAP(match_name) AS match_name, 
    match_date::DATE, 
    INITCAP(stage_name) AS stage_name, 
    INITCAP(group_name) AS group_name, 
    team_id, 
    INITCAP(team_name) AS team_name, 
    team_code, 
    home_team, 
    away_team, 
    player_id, 
    INITCAP(family_name) AS family_name, 
    INITCAP(given_name) AS given_name, 
    shirt_number, 
    player_team_id, 
    INITCAP(player_team_name) AS player_team_name, 
    player_team_code, 
    minute_label, 
    minute_regulation, 
    minute_stoppage, 
    INITCAP(match_period) AS match_period, 
    own_goal, 
    penalty
FROM bronze.goals;