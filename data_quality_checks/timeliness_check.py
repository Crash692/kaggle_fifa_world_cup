import csv
import psycopg2

def check_timeliness_per_row(table, date_column, primary_key_column, cursor):
    # Define World Cup years from 2018 back to 1930 in descending order
    world_cup_years = tuple(range(2018, 1930, -4))

    # Query to check each row for timeliness with respect to World Cup years and summer months
    query = f"""
    SELECT {primary_key_column},
           {date_column},
           CASE 
               WHEN EXTRACT(YEAR FROM {date_column}::DATE) IN {world_cup_years} 
                    AND EXTRACT(MONTH FROM {date_column}::DATE) IN (6, 7, 8)
               THEN 'Pass' ELSE 'Fail' 
           END AS timeliness_result
    FROM bronze.{table};
    """
    cursor.execute(query)
    rows = cursor.fetchall()

    # Save results to a CSV file
    with open(f"data_quality_results/{table}_timeliness.csv", mode="w", newline="") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow([primary_key_column, date_column, "Timeliness_Result"]) 
        for row in rows:
            writer.writerow(row) 

def main():
    # Database configuration
    db_config = {
        "database": "world_cup_db",
        "user": "myuser",
        "password": "mypassword",
        "host": "localhost",
        "port": "5432"
    }

    # Connect to the database
    conn = psycopg2.connect(**db_config)
    cursor = conn.cursor()

    # Define tables and primary keys to check
    tables = {
        "matches": ("match_date", "match_id"),
        "penalty_kicks": ("match_date", "key_id"),
        "player_appearances": ("match_date", "key_id"),
        "goals": ("match_date", "key_id"),
        "bookings": ("match_date", "key_id"),
        "tournaments": ("start_date", "tournament_id"),
    }

    # Perform timeliness check for each table
    for table, (date_column, primary_key_column) in tables.items():
        check_timeliness_per_row(table, date_column, primary_key_column, cursor)

    # Close the database connection
    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()
