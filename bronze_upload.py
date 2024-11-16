import pandas as pd
import json
import os
import psycopg2
from psycopg2.extras import execute_values

# Load database configuration
config_path = "config.json"
with open(config_path, "r") as file:
    db_config = json.load(file)

DB_NAME = db_config["database"]
USER = db_config["user"]
PASSWORD = db_config["password"]
HOST = db_config["host"]
PORT = db_config["port"]

# Base directory for dataset files
base_directory = "data/raw"

# Dictionary mapping dataset files to their unique identifier columns
dataset_config = {
    "award_winners.csv": "key_id",
    "awards.csv": "award_id",
    "bookings.csv": "key_id",
    "confederations.csv": "confederation_id",
    "goals.csv": "key_id",
    "group_standings.csv": "key_id",
    "groups.csv": "key_id",
    "host_countries.csv": "key_id",
    "manager_appearances.csv": "key_id",
    "manager_appointments.csv": "key_id",
    "managers.csv": "manager_id",
    "matches.csv": "match_id",
    "penalty_kicks.csv": "key_id",
    "player_appearances.csv": "key_id",
    "players.csv": "player_id",
    "qualified_teams.csv": "key_id",
    "referee_appearances.csv": "key_id",
    "referee_appointments.csv": "key_id",
    "referees.csv": "referee_id",
    "squads.csv": "key_id",
    "stadiums.csv": "stadium_id",
    "substitutions.csv": "substitution_id",
    "team_appearances.csv": "key_id",
    "teams.csv": "team_id",
    "tournament_stages.csv": "key_id",
    "tournament_standings.csv": "key_id",
    "tournaments.csv": "tournament_id",
}

def create_table_if_not_exists(cursor, table_name, df):
    """
    Create a table in the 'bronze' schema if it doesn't exist.
    The schema is inferred from the DataFrame columns and their types.
    """
    # Map pandas dtypes to PostgreSQL types
    dtype_mapping = {
        "object": "TEXT",
        "int64": "BIGINT",
        "float64": "DOUBLE PRECISION",
        "bool": "BOOLEAN",
        "datetime64[ns]": "TIMESTAMP",
    }
    columns = []
    for column_name, dtype in df.dtypes.items():
        pg_dtype = dtype_mapping.get(str(dtype), "TEXT")  # Default to TEXT for unknown types
        columns.append(f'"{column_name}" {pg_dtype}')
    columns_def = ", ".join(columns)

    # Create table if it doesn't exist
    create_table_query = f"""
        CREATE TABLE IF NOT EXISTS bronze.{table_name} (
            {columns_def}
        );
    """
    cursor.execute(create_table_query)
    print(f"Table bronze.{table_name} created or already exists.")

def insert_data(cursor, table_name, df, unique_column):
    """
    Insert data into the table after deduplication, avoiding duplicates using the unique column.
    """
    # Deduplicate the data in-memory
    df = df.drop_duplicates(subset=[unique_column])

    # Prepare data rows for insertion
    rows = [tuple(row) for row in df.to_numpy()]
    columns = ", ".join(df.columns)

    # Insert data into the target table
    insert_query = f"""
        INSERT INTO bronze.{table_name} ({columns})
        VALUES %s
    """
    execute_values(cursor, insert_query, rows)

def upload_datasets():
    """
    Upload all datasets from the configuration into the bronze schema, avoiding duplicates.
    Create tables dynamically if they do not exist.
    """
    conn = None
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME, user=USER, password=PASSWORD, host=HOST, port=PORT
        )
        cursor = conn.cursor()

        for dataset_file, unique_column in dataset_config.items():
            file_path = os.path.join(base_directory, dataset_file)
            if not os.path.exists(file_path):
                print(f"File not found: {file_path}")
                continue

            # Load dataset
            df = pd.read_csv(file_path)
            table_name = dataset_file.replace('.csv', '')  # Extract table name

            # Create table if it doesn't exist
            create_table_if_not_exists(cursor, table_name, df)

            # Insert data into the database
            print(f"Uploading {table_name} to bronze schema...")
            insert_data(cursor, table_name, df, unique_column)
            print(f"Uploaded {table_name} successfully.")

        # Commit changes
        conn.commit()

    except Exception as e:
        print(f"Error during upload: {e}")

    finally:
        if conn:
            cursor.close()
            conn.close()
            print("Database connection closed.")

if __name__ == "__main__":
    upload_datasets()