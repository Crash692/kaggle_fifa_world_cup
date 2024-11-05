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

def check_accuracy_per_row(cursor):
    # Query to evaluate each row's accuracy based on score columns
    query = """
    SELECT match_id, home_team_score, away_team_score,
           CASE 
               WHEN home_team_score <= 5 AND away_team_score <= 5 THEN 'Accurate' 
               ELSE 'Inaccurate' 
           END AS accuracy_status
    FROM bronze.matches;
    """
    cursor.execute(query)
    rows = cursor.fetchall()
    return rows

def main():
    # Connect to the database
    connection = psycopg2.connect(**db_config)
    cursor = connection.cursor()

    # Perform row-level accuracy check
    result = check_accuracy_per_row(cursor)

    # Convert result to DataFrame
    accuracy_results = pd.DataFrame(result, columns=["Match_ID", "Home_Team_Score", "Away_Team_Score", "Accuracy_Status"])

    # Save to CSV
    accuracy_results.to_csv("data_quality_results/matches_accuracy_results.csv", index=False)

    # Close the connection
    cursor.close()
    connection.close()

if __name__ == "__main__":
    main()
