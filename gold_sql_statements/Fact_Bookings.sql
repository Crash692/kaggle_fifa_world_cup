CREATE TABLE IF NOT EXISTS gold.Fact_Bookings (
    booking_id VARCHAR PRIMARY KEY,
    match_id VARCHAR REFERENCES gold.Fact_Match_Results(match_id),
    tournament_id VARCHAR REFERENCES gold.Dim_Tournaments(tournament_id),
    player_id VARCHAR REFERENCES gold.Dim_Players(player_id),
    team_id VARCHAR REFERENCES gold.Dim_Teams(team_id),
    minute INT,
    card_type TEXT
);

INSERT INTO gold.Fact_Bookings (booking_id, match_id, tournament_id, player_id, team_id, minute, card_type)
SELECT
    booking_id,
    match_id,
    tournament_id,
    player_id,
    team_id,
    minute_regulation AS minute,
    CASE 
        WHEN yellow_card = 1 THEN 'Yellow' 
        WHEN red_card = 1 THEN 'Red' 
        ELSE 'Second Yellow' 
    END AS card_type
FROM silver.bookings;

