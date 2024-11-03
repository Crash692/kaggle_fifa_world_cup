# FIFA World Cup Data Pipeline Project

This project builds an end-to-end data pipeline for analyzing FIFA World Cup data. It includes ETL processes for transforming data across Bronze, Silver, and Gold layers, with final visualizations using Metabase.

## Project Overview

1. **Data Sources**: CSV files containing raw data from various aspects of the FIFA World Cup, including matches, players, teams, goals, and penalties.
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
