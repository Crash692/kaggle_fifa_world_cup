# FIFA World Cup Data Pipeline Project

This project builds an end-to-end data pipeline for analyzing FIFA World Cup data. It includes ETL processes for transforming data across Bronze, Silver, and Gold layers, with final visualizations using Metabase.

## Project Overview

1. **Data Sources**: CSV files containing raw data from various aspects of the FIFA World Cup, including matches, players, teams, goals, and penalties.
Link to the data - [Kaggle World Cup Data](https://www.kaggle.com/datasets/joshfjelstul/world-cup-database)
2. **Data Storage Layers**:
   - **Bronze Layer**: Raw data is loaded into PostgreSQL.
   - **Silver Layer**: Cleaned and transformed data for further processing.
   - **Gold Layer**: Final curated tables optimized for analysis and visualizations.
3. **Visualization Tool**: Metabase, used to create interactive dashboards.

## Database Setup

### PostgreSQL Configuration

The database setup is managed through Docker. PostgreSQL and Metabase containers are configured with the following commands:

```bash
docker network create metabase_network

# Run PostgreSQL container
docker run --name postgres_db --network metabase_network -e POSTGRES_DB=world_cup_db -e POSTGRES_USER=myuser -e POSTGRES_PASSWORD=mypassword -p 5432:5432 -d postgres

# Run Metabase container
docker run -d -p 3000:3000 --name metabase --network metabase_network metabase/metabase

```

## Data Folder

The project uses a data/raw/ folder containing CSV files, which serve as the initial input data for the pipeline. Ensure that these files are in place before running the ETL process

## ETL Pipeline

### Step-by-Step Execution

**Bronze Layer:** Use bronze_upload.py to load raw data into PostgreSQL without modifications.
```bash
python scripts/bronze_upload.py
```
**Silver Layer:** Run silver_upload.py to clean and transform data in the silver schema.
```bash
python scripts/silver_upload.py
```
**Gold Layer:** Execute gold_upload.py to load curated tables optimized for analysis.
```bash
python scripts/gold_upload.py
```

## Metabase Configuration for Data Visualization

**Access Metabase**: Open your browser and navigate to [http://localhost:3000](http://localhost:3000).

### Database Connection Settings:

- **Database Type**: PostgreSQL
- **Host**: `postgres_db`
- **Port**: `5432`
- **Database Name**: `world_cup_db`
- **Username**: `myuser`
- **Password**: `mypassword`

### Dashboard Creation:

- **Tournament Summary**: Matches played, goals scored, and cards issued per tournament.
- **Player Performance**: Individual player statistics including goals, penalties, and substitutions.
- **Team Analysis**: Wins, losses, and standings per team across tournaments.

## Dashboards Overview

### 1. World Cup Statistics Dashboard
- **Purpose**: Provides an overarching view of FIFA World Cup tournaments, including metrics on goals, matches, host countries, and winners.
- **Metrics**:
  - Total Goals: Total goals scored across tournaments.
  - Total Matches: Number of matches per tournament.
  - Host Country and Winner Information.
- **Filters**:
  - Host Country
  - Tournament Name
  - Winner

### 2. Team Performance Dashboard
- **Purpose**: Analyzes each team’s performance, including interactions with other teams and match statistics.
- **Metrics**:
  - Goals scored
  - Bookings (Yellow and Red cards)
  - Substitutions during matches
- **Match Details**:
  - Opponent Teams and Match Results (Win, Loss, Draw)
