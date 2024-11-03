import pandas as pd
from sqlalchemy import create_engine
import os

# Database connection settings
DB_NAME = "world_cup_db"
USER = "myuser"
PASSWORD = "mypassword"
HOST = "localhost"
PORT = "5432"

# Connect to the database
connection_string = f"postgresql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB_NAME}"
engine = create_engine(connection_string)

# Base directory for dataset files
base_directory = os.path.expanduser("~/Documents/gitlab/kaggle_fifa_world_cup/data/raw")

# List of dataset files (relative to the base directory)
dataset_files = [
    "award_winners.csv",
    "awards.csv",
    "bookings.csv",
    "confederations.csv",
    "goals.csv",
    "group_standings.csv",
    "groups.csv",
    "host_countries.csv",
    "manager_appearances.csv",
    "manager_appointments.csv",
    "managers.csv",
    "matches.csv",
    "penalty_kicks.csv",
    "player_appearances.csv",
    "players.csv",
    "qualified_teams.csv",
    "referee_appearances.csv",
    "referee_appointments.csv",
    "referees.csv",
    "squads.csv",
    "stadiums.csv",
    "substitutions.csv",
    "team_appearances.csv",
    "teams.csv",
    "tournament_stages.csv",
    "tournament_standings.csv",
    "tournaments.csv"
]

# Function to upload datasets to bronze schema
def upload_datasets():
    for filename in dataset_files:
        file_path = os.path.join(base_directory, filename)
        df = pd.read_csv(file_path)  # Load dataset
        table_name = filename.replace('.csv', '')  # Extract table name
        df.to_sql(table_name, engine, schema='bronze', if_exists='replace', index=False)
        print(f"Uploaded {table_name} to bronze schema.")

if __name__ == "__main__":
    upload_datasets()
