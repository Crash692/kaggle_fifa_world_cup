import pandas as pd
from sqlalchemy import create_engine, text

# Database connection settings
DB_NAME = "world_cup_db"
USER = "myuser"
PASSWORD = "mypassword"
HOST = "localhost"
PORT = "5432"

# Create an SQLAlchemy engine
engine = create_engine(f'postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB_NAME}')

for file in dataset_files:
    df = pd.read_csv(file)  # Load your dataset
    table_name = file.split('/')[-1].replace('.csv', '')  # Extract table name
    full_table_name = f'bronze.{table_name}'  # Use bronze schema
    df.to_sql(full_table_name, connection, schema='bronze', if_exists='replace', index=False)
    print(f"Uploaded {table_name} to bronze schema.")