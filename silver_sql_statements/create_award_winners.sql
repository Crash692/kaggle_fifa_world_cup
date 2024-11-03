CREATE TABLE IF NOT EXISTS silver.award_winners (
    key_id INT PRIMARY KEY,
    tournament_id VARCHAR(10),
    tournament_name VARCHAR(100),
    award_id VARCHAR(10),
    award_name VARCHAR(50),
    shared INT DEFAULT 0,
    player_id VARCHAR(10),
    family_name VARCHAR(100),
    given_name VARCHAR(100),
    team_id VARCHAR(10),
    team_name VARCHAR(100),
    team_code VARCHAR(10)
);
