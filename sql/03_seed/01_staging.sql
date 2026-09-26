-- 01_staging.sql
-- Creates the staging schema and loads raw CSV data into permissive VARCHAR tables.

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.equipment_raw (
    equipment_id VARCHAR(255),
    asset_tag VARCHAR(255),
    equipment_name VARCHAR(255),
    category VARCHAR(255),
    subcategory VARCHAR(255),
    brand VARCHAR(255),
    model VARCHAR(255),
    serial_number VARCHAR(255),
    tracking_method VARCHAR(255),
    quantity VARCHAR(255),
    specifications TEXT,
    condition VARCHAR(255),
    status VARCHAR(255),
    ownership VARCHAR(255),
    owner_person_id VARCHAR(255),
    department_id VARCHAR(255),
    custodian_person_id VARCHAR(255),
    location_id VARCHAR(255),
    purchase_date VARCHAR(255),
    unit_cost_tzs VARCHAR(255),
    notes TEXT
);

-- Copy data from the mounted CSV file
-- Docker mounts ./sql to /app/sql
COPY staging.equipment_raw 
FROM '/app/sql/03_seed/data/Equipment.csv' 
WITH (FORMAT csv, HEADER true);
