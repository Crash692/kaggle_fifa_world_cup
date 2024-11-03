INSERT INTO silver.matches (
    match_id, 
    tournament_id, 
    tournament_name, 
    match_name, 
    stage_name, 
    group_name, 
    group_stage, 
    knockout_stage, 
    replayed, 
    replay, 
    match_datetime,
    stadium_id, 
    stadium_name, 
    city_name, 
    country_name, 
    home_team_id, 
    home_team_name, 
    home_team_code, 
    away_team_id, 
    away_team_name, 
    away_team_code, 
    score, 
    home_team_score, 
    away_team_score, 
    home_team_score_margin, 
    away_team_score_margin, 
    extra_time, 
    penalty_shootout, 
    score_penalties, 
    home_team_score_penalties, 
    away_team_score_penalties, 
    result, 
    home_team_win, 
    away_team_win, 
    draw
)
SELECT 
    match_id, 
    tournament_id, 
    INITCAP(tournament_name) AS tournament_name, 
    INITCAP(match_name) AS match_name, 
    INITCAP(stage_name) AS stage_name, 
    INITCAP(group_name) AS group_name, 
    group_stage, 
    knockout_stage, 
    replayed, 
    replay, 
    (match_date || ' ' || match_time)::TIMESTAMP AS match_datetime,
    stadium_id, 
    INITCAP(stadium_name) AS stadium_name, 
    INITCAP(city_name) AS city_name, 
    INITCAP(country_name) AS country_name, 
    home_team_id, 
    INITCAP(home_team_name) AS home_team_name, 
    home_team_code, 
    away_team_id, 
    INITCAP(away_team_name) AS away_team_name, 
    away_team_code, 
    score, 
    home_team_score, 
    away_team_score, 
    home_team_score_margin, 
    away_team_score_margin, 
    extra_time, 
    penalty_shootout, 
    score_penalties, 
    home_team_score_penalties, 
    away_team_score_penalties, 
    result, 
    home_team_win, 
    away_team_win, 
    draw
FROM bronze.matches;
