# Church Equipment & Inventory Management Database

Welcome to the central database repository for the Church Inventory Management system. 

This repository contains the physical data layer (Schema, Views, Triggers) that strictly enforces data integrity, tracks the lifecycle of church assets, and powers our frontend applications.

## 🎯 The Mission

Our goal is to maintain absolute accountability over all institutional assets. This database ensures we have reliable knowledge of:
* What equipment the church owns.
* Who is currently responsible for it.
* What condition it is in, and its operational status.
* A permanent audit trail of its lifecycle (when it broke, who moved it, and its repair history).

## 🏗️ Technology Stack

* **Database Engine:** PostgreSQL 16
* **Database Administration GUI:** pgAdmin4
* **Containerization:** Docker & Docker Compose
* **Architecture:** Strictly Normalized (3NF+) relational model

## 🚀 Getting Started (Local Development)

This project is fully containerized. The database will automatically initialize itself and run all necessary SQL migration scripts upon startup.

### 1. Start the Environment
To spin up the Postgres database and the pgAdmin web interface, simply run:
```bash
make up
```

### 2. Access the Database via pgAdmin
We bundle **pgAdmin4** to allow developers and administrators to visually inspect tables, run queries, and monitor database performance.

* **URL:** [http://localhost:5050](http://localhost:5050)
* **Email:** `admin@church.org` (or check your `.env` file)
* **Password:** `admin` (or check your `.env` file)

*Note: Once logged in, register a new server with the hostname `db`, port `5432`, and the database credentials found in your `.env` file.*

### 3. Resetting the Database
If you are developing schema changes or testing data pipelines and need a completely fresh start, you can wipe the database and re-run all initialization scripts:
```bash
make reset
```
*(Warning: This is a destructive operation that will wipe all local data and recreate the containers from scratch.)*

### 4. Database Shell Access
To drop straight into a `psql` shell:
```bash
make shell
```

## 📂 Repository Structure

All database logic is maintained within the `sql/` directory and executed in alphabetical order during initialization:

```text
sql/
├── 01_schema/    # Physical DDL: Custom Types, Enums, Tables, and Constraints
├── 02_views/     # Application Layer: Complex JOIN abstractions for the frontend
├── 03_logic/     # Automated Actions: PL/pgSQL Functions and Audit Triggers
└── 04_seed/      # Data Pipelines: ETL staging, transformation, and static seeding
```

## 🤝 Contributing

We welcome contributions from other developers! If you are building the frontend or adding new features to the database:

1. **Simplicity First (KISS):** We prefer straightforward schema designs.
2. **Strict Data Integrity:** Rely heavily on PostgreSQL constraints (Foreign Keys, Checks) to protect the data at the lowest level rather than relying on application code.
3. **Audit Trails:** Ensure any critical updates fire the appropriate logging triggers.

## 📝 Documentation

All internal architecture diagrams and database workflows are documented using Mermaid syntax within the repository.
