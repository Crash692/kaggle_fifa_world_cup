CREATE TABLE IF NOT EXISTS silver.tournaments (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(255),
    tournament_name VARCHAR(255),
    year INT,
    start_date DATE,
    end_date DATE,
    host_country VARCHAR(255),
    winner VARCHAR(255),
    host_won INT,
    count_teams INT,
    group_stage INT,
    second_group_stage INT,
    final_round INT,
    round_of_16 INT,
    quarter_finals INT,
    semi_finals INT,
    third_place_match INT,
    final INT
);
