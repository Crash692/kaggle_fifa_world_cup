CREATE TABLE IF NOT EXISTS gold.Fact_Award_Winners (
    award_winner_id INT PRIMARY KEY,
    award_id VARCHAR REFERENCES gold.Dim_Awards(award_id),
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    player_id VARCHAR REFERENCES gold.Dim_Players(player_id),
    team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    shared BOOLEAN DEFAULT FALSE
);

INSERT INTO gold.Fact_Award_Winners (award_winner_id, award_id, tournament_id, player_id, team_id, shared)
SELECT DISTINCT
    key_id as award_winner_id,
    award_id,
    tournament_id,
    player_id,
    team_id,
    CASE 
        WHEN shared = 1 THEN TRUE
        ELSE FALSE
    END AS shared
FROM silver.award_winners
WHERE award_id IS NOT NULL AND tournament_id IS NOT NULL;
