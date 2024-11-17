import psycopg2
import os
import json

# Load database configuration
config_path = "config.json"
with open(config_path, "r") as file:
    db_config = json.load(file)

# Folder containing SQL files
statements_folder = "silver_sql_statements"

print('Start')

def execute_sql_file(cursor, file_path):
    """Execute SQL commands from a file and print the row count affected."""
    try:
        with open(file_path, 'r') as file:
            cursor.execute(file.read())
            row_count = cursor.rowcount
            print(f"{file_path} executed successfully. Rows affected: {row_count}.")
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

    # Execute each SQL file in the folder
    for filename in sorted(os.listdir(statements_folder)):
        if filename.endswith(".sql"):
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
