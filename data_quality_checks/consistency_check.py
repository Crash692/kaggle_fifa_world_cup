import psycopg2
import pandas as pd

# Database connection settings
db_config = {
    "database": "world_cup_db",
    "user": "myuser",
    "password": "mypassword",
    "host": "localhost",
    "port": "5432"
}

schema = "bronze"

# FK - PK dependencies
dependencies = {
    "award_winners": {
        "award_id": {"primary_table": "awards", "pk_column": "award_id"},
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "player_id": {"primary_table": "players", "pk_column": "player_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "group_standings": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "player_appearances": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"},
        "match_id": {"primary_table": "matches", "pk_column": "match_id"},
        "player_id": {"primary_table": "players", "pk_column": "player_id"}
    },
    "manager_appearances": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "manager_id": {"primary_table": "managers", "pk_column": "manager_id"},
        "match_id": {"primary_table": "matches", "pk_column": "match_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "team_appearances": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "opponent_id": {"primary_table": "teams", "pk_column": "team_id"},
        "match_id": {"primary_table": "matches", "pk_column": "match_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"},
        "stadium_id": {"primary_table": "stadiums", "pk_column": "stadium_id"}
    },
    "penalty_kicks": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "player_id": {"primary_table": "players", "pk_column": "player_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"},
        "match_id": {"primary_table": "matches", "pk_column": "match_id"}
    },
    "goals": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "player_id": {"primary_table": "players", "pk_column": "player_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"},
        "match_id": {"primary_table": "matches", "pk_column": "match_id"}
    },
    "qualified_teams": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "substitutions": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "player_id": {"primary_table": "players", "pk_column": "player_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"},
        "match_id": {"primary_table": "matches", "pk_column": "match_id"}
    },
    "tournament_standings": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "bookings": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "player_id": {"primary_table": "players", "pk_column": "player_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"},
        "match_id": {"primary_table": "matches", "pk_column": "match_id"}
    },
    "manager_appointments": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "manager_id": {"primary_table": "managers", "pk_column": "manager_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "squads": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "player_id": {"primary_table": "players", "pk_column": "player_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "host_countries": {
        "team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "matches": {
        "away_team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "home_team_id": {"primary_table": "teams", "pk_column": "team_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"},
        "stadium_id": {"primary_table": "stadiums", "pk_column": "stadium_id"}
    },
    "referees": {
        "confederation_id": {"primary_table": "confederations", "pk_column": "confederation_id"}
    },
    "referee_appearances": {
        "referee_id": {"primary_table": "referees", "pk_column": "referee_id"},
        "confederation_id": {"primary_table": "confederations", "pk_column": "confederation_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"},
        "match_id": {"primary_table": "matches", "pk_column": "match_id"}
    },
    "referee_appointments": {
        "referee_id": {"primary_table": "referees", "pk_column": "referee_id"},
        "confederation_id": {"primary_table": "confederations", "pk_column": "confederation_id"},
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "teams": {
        "confederation_id": {"primary_table": "confederations", "pk_column": "confederation_id"}
    },
    "groups": {
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    },
    "tournament_stages": {
        "tournament_id": {"primary_table": "tournaments", "pk_column": "tournament_id"}
    }
}

# Connect to the database
try:
    conn = psycopg2.connect(**db_config)
    cursor = conn.cursor()
    print("Connected to the database.")
except Exception as e:
    print(f"Error connecting to database: {e}")
    exit()

# List to store inconsistency details
inconsistencies = []

# Function to check dependencies for each table
def check_dependency(dependent_table, primary_table, fk_column, pk_column):
    # SQL to find total count of records in dependent_table
    total_query = f"SELECT COUNT(*) FROM {schema}.{dependent_table};"
    
    # SQL to find records in dependent_table where foreign key has no matching primary key in primary_table
    missing_query = f"""
        SELECT COUNT(*)
        FROM {schema}.{dependent_table} d
        LEFT JOIN {schema}.{primary_table} p ON d.{fk_column} = p.{pk_column}
        WHERE p.{pk_column} IS NULL;
    """
    
    try:
        cursor.execute(total_query)
        total_count = cursor.fetchone()[0]
        
        cursor.execute(missing_query)
        missing_count = cursor.fetchone()[0]

        # Record the results
        inconsistencies.append({
            "Dependent Table": dependent_table,
            "Primary Table": primary_table,
            "Foreign Key": fk_column,
            "Primary Key Column": pk_column,
            "Total Rows Checked": total_count,
            "Missing References": missing_count
        })

    except Exception as e:
        print(f"Error executing queries for {dependent_table}: {e}")

# Loop through dependencies and check consistency for each relationship
for dep_table, foreign_keys in dependencies.items():
    for fk_column, details in foreign_keys.items():
        primary_table = details["primary_table"]
        pk_column = details["pk_column"]
        check_dependency(dep_table, primary_table, fk_column, pk_column)

# Close database connection
cursor.close()
conn.close()
print("Database connection closed.")

# Save inconsistencies to CSV if any
if inconsistencies:
    df_inconsistencies = pd.DataFrame(inconsistencies)
    df_inconsistencies.to_csv('data_quality_results/consistency.csv', index=False)
    print("Inconsistencies saved to 'consistency.csv'.")
else:
    print("No provided connections.")
