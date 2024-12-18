import psycopg2
import os
import json

# Load database configuration
config_path = "config.json"
with open(config_path, "r") as file:
    db_config = json.load(file)


# Folder containing SQL files
statements_folder = "gold_sql_statements"

# Execution order
execution_order = [
    # Dimension tables
    "Dim_Managers.sql",
    "Dim_Players.sql",
    "Dim_Referees.sql",
    "Dim_Stadiums.sql",
    "Dim_Teams.sql",
    "Dim_Tournaments.sql",
    "Dim_Awards.sql",
    
    # Fact tables
    "Fact_Match_Result.sql",
    "Fact_Bookings.sql",
    "Fact_Goals.sql",
    "Fact_Manager_Appointments.sql",
    "Fact_Penalty_Kicks.sql",
    "Fact_Referee_Apperances.sql",
    "Fact_Substitutions.sql",
    "Fact_Team_Apperances.sql",
    "Fact_Awards_Winners.sql",
    "Fact_Team_Match_result.sql"
]

def execute_sql_file(cursor, file_path):
    """Execute SQL commands from a file."""
    try:
        with open(file_path, 'r') as file:
            sql_content = file.read()
            if sql_content.strip():  # Only execute if the file has content
                cursor.execute(sql_content)
                print(f"Executed {file_path} successfully.")
    except Exception as e:
        print(f"Error executing {file_path}: {e}")

def main():
    # Connect to the database
    try:
        connection = psycopg2.connect(**db_config)
        cursor = connection.cursor()
        print("Database connection established.")
    except Exception as e:
        print(f"Failed to connect to database: {e}")
        return

    # Execute each SQL file in the specified order
    for filename in execution_order:
        file_path = os.path.join(statements_folder, filename)
        print(f"Executing {filename}...")
        execute_sql_file(cursor, file_path)
        connection.commit()

    # Close connection
    cursor.close()
    connection.close()
    print("Database connection closed.")

if __name__ == "__main__":
    main()
