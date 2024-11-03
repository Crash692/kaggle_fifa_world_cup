import psycopg2
import pandas as pd

db_config = {
    "database": "world_cup_db",
    "user": "myuser",
    "password": "mypassword",
    "host": "localhost",
    "port": "5432"
}

def get_completeness(cursor):
    query = """
    SELECT table_name, column_name,
           (SELECT COUNT(*) FROM bronze."||table_name||") AS total_rows,
           COUNT(column_name) AS non_null_count,
           (COUNT(column_name) / (SELECT COUNT(*) FROM bronze."||table_name||")::float) * 100 AS completeness_percentage
    FROM information_schema.columns
    WHERE table_schema = 'bronze';
    """
    cursor.execute(query)
    return cursor.fetchall()

def main():
    connection = psycopg2.connect(**db_config)
    cursor = connection.cursor()

    completeness_results = []
    results = get_completeness(cursor)
    for row in results:
        completeness_results.append({
            "Table": row[0],
            "Column": row[1],
            "Total Rows": row[2],
            "Non-null Count": row[3],
            "Completeness (%)": row[4]
        })

    df = pd.DataFrame(completeness_results)
    df.to_csv("completeness_results.csv", index=False)

    cursor.close()
    connection.close()

if __name__ == "__main__":
    main()
