import psycopg2
import pandas as pd

db_config = {
    "database": "world_cup_db",
    "user": "myuser",
    "password": "mypassword",
    "host": "localhost",
    "port": "5432"
}

primary_keys = {
    "award_winners": "key_id",
    "awards": "award_id",
    "bookings": "key_id",
    "confederations": "confederation_id",
    "goals": "key_id",
    "group_standings": "key_id",
    "groups": "key_id",
    "host_countries": "key_id",
    "manager_appearances": "key_id",
    "manager_appointments": "key_id",
    "managers": "manager_id",
    "matches": "match_id",
    "penalty_kicks": "key_id",
    "player_appearances": "key_id",
    "players": "player_id",
    "qualified_teams": "key_id",
    "referee_appearances": "key_id",
    "referee_appointments": "key_id",
    "referees": "referee_id",
    "squads": "key_id",
    "stadiums": "stadium_id",
    "substitutions": "substitution_id",
    "team_appearances": "key_id",
    "teams": "team_id",
    "tournament_stages": "key_id",
    "tournament_standings": "key_id",
    "tournaments": "tournament_id"
}

def check_uniqueness(table, pk_column, cursor):
    query = f"""
    SELECT COUNT(*) AS total_rows,
           COUNT(DISTINCT {pk_column}) AS unique_rows,
           (COUNT(DISTINCT {pk_column}) / COUNT(*)::float) * 100 AS uniqueness_percentage
    FROM bronze.{table};
    """
    cursor.execute(query)
    return cursor.fetchone()

def main():
    connection = psycopg2.connect(**db_config)
    cursor = connection.cursor()

    uniqueness_results = []
    for table, pk_column in primary_keys.items():
        result = check_uniqueness(table, pk_column, cursor)
        uniqueness_results.append({
            "Table": table,
            "Primary Key": pk_column,
            "Total Rows": result[0],
            "Unique Rows": result[1],
            "Uniqueness (%)": result[2]
        })

    df = pd.DataFrame(uniqueness_results)
    df.to_csv("uniqueness_results.csv", index=False)

    cursor.close()
    connection.close()

if __name__ == "__main__":
    main()
