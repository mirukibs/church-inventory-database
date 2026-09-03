#!/bin/bash

# First, close any existing issues to start fresh
gh issue list --json number -q '.[].number' | xargs -r -I {} gh issue close {}

# Array of titles
declare -a titles=(
  "Phase 1: Domain Modeling & Unnormalized Data"
  "Phase 2: Database Design"
  "Phase 3: Core Database Construction"
  "Phase 4: Advanced SQL & Analytics"
  "Phase 5: Operational Integrity"
  "Phase 6: Performance Engineering"
  "Phase 7: Administration & Security"
  "Phase 8: Data Engineering"
)

# Array of bodies
declare -a bodies=(
  "**Dates:** Sept 3 - Sept 4
**Objective:** Understand the data conceptually and construct a purposely bad dataset.
**Academic Topics to Study:**
- Entities, Attributes, and the Real World
- Data Anomalies (Insertion, Update, Deletion anomalies)
- The cost of data duplication
**Implementation Task:** Draft the domain model and create an intentionally bad, unnormalized dataset in \`docs/domain-model.md\`. Remember to use Mermaid/PlantUML for any diagrams."

  "**Dates:** Sept 5 - Sept 6
**Objective:** Translate the bad dataset into a mathematically sound structure.
**Academic Topics to Study:**
- Functional Dependencies (Trivial, Non-trivial, Transitive)
- Normalization Forms (1NF, 2NF, 3NF, BCNF)
- Entity-Relationship (ER) Modeling (Entities, Attributes, Relationships, Cardinality)
- Primary, Foreign, and Composite Keys
**Implementation Task:** Normalize the bad dataset into 3NF and generate a Mermaid ER Diagram in \`docs/relational-model.md\`."

  "**Dates:** Sept 7 - Sept 9
**Objective:** Physically construct the database and insert data.
**Academic Topics to Study:**
- DDL (Data Definition Language) - CREATE, ALTER, DROP
- DML (Data Manipulation Language) - INSERT, UPDATE, DELETE
- Schema Objects and Data Dictionary
- Constraints (UNIQUE, CHECK, NOT NULL, DEFAULT)
- Sequences / Identity Columns
**Implementation Task:** Write the PostgreSQL DDL scripts in \`sql/\` and insert your normalized test dataset."

  "**Dates:** Sept 10 - Sept 11
**Objective:** Query and analyze the database.
**Academic Topics to Study:**
- Advanced SQL (JOIN types: INNER, LEFT, RIGHT, FULL)
- Subqueries (Correlated vs Non-correlated)
- Aggregation (GROUP BY, HAVING)
- Window Functions (ROW_NUMBER, RANK, DENSE_RANK, SUM OVER)
- Date arithmetic
**Implementation Task:** Create a suite of complex queries in \`sql/08_queries.sql\` that answer business questions like 'Which assets cost the most to maintain?'"

  "**Dates:** Sept 12 - Sept 13
**Objective:** Ensure the database handles concurrent usage safely.
**Academic Topics to Study:**
- ACID Properties (Atomicity, Consistency, Isolation, Durability)
- Transaction Boundaries (BEGIN, COMMIT, ROLLBACK)
- Concurrency Control and Locks (Row-level, Table-level, Deadlocks)
- Transaction Isolation Levels (READ COMMITTED, SERIALIZABLE)
- MVCC (Multi-Version Concurrency Control)
**Implementation Task:** Run concurrency experiments (e.g., double checkout problem) in \`transactions/\`."

  "**Dates:** Sept 14 - Sept 15
**Objective:** Optimize the database for scale.
**Academic Topics to Study:**
- Physical Storage (Pages, Blocks)
- Index Structures (B-Trees)
- Index types (Composite, Partial, Covering)
- Query Execution Plans (Sequential Scan vs Index Scan)
- Query Optimizer and Cardinality Estimates
**Implementation Task:** Generate 500,000+ records and benchmark query performance with and without indexes using \`EXPLAIN ANALYZE\`."

  "**Dates:** Sept 16 - Sept 18
**Objective:** Secure and protect the database.
**Academic Topics to Study:**
- DCL (Data Control Language) - GRANT, REVOKE
- Database Security Models and Roles
- Row-Level Security (RLS)
- Auditing mechanisms (Database Triggers, Temporal Tables)
- Backup and Recovery mechanics (WAL, Point-in-time recovery)
**Implementation Task:** Implement triggers for an audit log, setup RLS so branch managers only see their branch's assets, and document a backup strategy."

  "**Dates:** Sept 19 - Sept 21
**Objective:** Prepare the data for business intelligence.
**Academic Topics to Study:**
- OLTP (Online Transaction Processing) vs OLAP (Online Analytical Processing)
- Dimensional Modeling (Star Schema: Facts and Dimensions)
- CQRS and Materialized Views
- Denormalization strategies for reporting
**Implementation Task:** Construct an analytical model (DimAsset, FactAssetMovement) in \`warehouse/\` and benchmark a reporting query against the normalized schema."
)

for i in "${!titles[@]}"; do
  # Create the issue and capture the URL
  ISSUE_URL=$(gh issue create --title "${titles[$i]}" --body "${bodies[$i]}" | tail -n 1)
  
  # Add the issue to the project board
  gh project item-add 14 --owner mirukibs --url "$ISSUE_URL"
  
  # Note: Setting start/target dates programmatically requires GraphQL, 
  # but putting them in the issue body is perfectly sufficient for the PM workflow.
done
