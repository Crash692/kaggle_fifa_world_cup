CREATE TABLE IF NOT EXISTS silver.tournament_stages (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    stage_number INT,
    stage_name VARCHAR(255),
    group_stage INT,
    knockout_stage INT,
    unbalanced_groups INT,
    start_date DATE,
    end_date DATE,
    count_matches INT,
    count_teams INT,
    count_scheduled INT,
    count_replays INT,
    count_playoffs INT,
    count_walkovers INT
);
