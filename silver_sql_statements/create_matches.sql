CREATE TABLE IF NOT EXISTS silver.matches (
    match_id VARCHAR(255) PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    match_name VARCHAR(255),
    stage_name VARCHAR(255),
    group_name VARCHAR(255),
    group_stage INT,
    knockout_stage INT,
    replayed INT,
    replay INT,
    match_datetime TIMESTAMP,  -- Replace match_date and match_time with match_datetime
    stadium_id VARCHAR(255),
    stadium_name VARCHAR(255),
    city_name VARCHAR(255),
    country_name VARCHAR(255),
    home_team_id VARCHAR(255),
    home_team_name VARCHAR(255),
    home_team_code VARCHAR(255),
    away_team_id VARCHAR(255),
    away_team_name VARCHAR(255),
    away_team_code VARCHAR(255),
    score VARCHAR(255),
    home_team_score INT,
    away_team_score INT,
    home_team_score_margin INT,
    away_team_score_margin INT,
    extra_time INT,
    penalty_shootout INT,
    score_penalties VARCHAR(255),
    home_team_score_penalties INT,
    away_team_score_penalties INT,
    result VARCHAR(255),
    home_team_win INT,
    away_team_win INT,
    draw INT
);
