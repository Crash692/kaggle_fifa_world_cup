CREATE TABLE IF NOT EXISTS silver.team_appearances (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    match_id VARCHAR(255),
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
    team_id VARCHAR(255),
    team_name VARCHAR(255),
    team_code VARCHAR(255),
    opponent_id VARCHAR(255),
    opponent_name VARCHAR(255),
    opponent_code VARCHAR(255),
    home_team INT,
    away_team INT,
    goals_for INT,
    goals_against INT,
    goal_differential INT,
    extra_time INT,
    penalty_shootout INT,
    penalties_for INT,
    penalties_against INT,
    result VARCHAR(255),
    win INT,
    lose INT,
    draw INT
);
