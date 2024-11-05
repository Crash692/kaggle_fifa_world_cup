import psycopg2
import pandas as pd
import os

# Database connection settings
db_config = {
    "database": "world_cup_db",
    "user": "myuser",
    "password": "mypassword",
    "host": "localhost",
    "port": "5432"
}

results_folder = "data_quality_results"
if not os.path.exists(results_folder):
    os.makedirs(results_folder)

def get_all_tables(cursor):
    cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'bronze';")
    tables = cursor.fetchall()
    return [table[0] for table in tables]

def get_completeness(cursor, table_name):
    cursor.execute(f"""
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_schema = 'bronze' AND table_name = '{table_name}';
    """)
    columns = cursor.fetchall()

    completeness_results = []
    for column in columns:
        column_name = column[0]

        query = f"""
        SELECT 
            '{table_name}' AS table_name,
            '{column_name}' AS column_name,
            COUNT(*) AS total_rows,
            COUNT({column_name}) AS non_null_count,
            (COUNT({column_name})::float / COUNT(*)::float) * 100 AS completeness_percentage
        FROM bronze.{table_name};
        """
        cursor.execute(query)
        result = cursor.fetchone()
        completeness_results.append(result)

    return completeness_results

def main():
    connection = psycopg2.connect(**db_config)
    cursor = connection.cursor()

    tables = get_all_tables(cursor)
    all_completeness_results = []

    for table in tables:
        table_results = get_completeness(cursor, table)
        for row in table_results:
            all_completeness_results.append({
                "Table": row[0],
                "Column": row[1],
                "Total Rows": row[2],
                "Non-null Count": row[3],
                "Completeness (%)": row[4]
            })

    df = pd.DataFrame(all_completeness_results)
    df.to_csv(f"{results_folder}/completeness_results.csv", index=False)
    print("Completeness results saved to 'completeness_results.csv'.")

    cursor.close()
    connection.close()

if __name__ == "__main__":
    main()
