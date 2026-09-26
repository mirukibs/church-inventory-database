# Phase 2: Entity-Relationship (ER) Model

This ER diagram maps the physical schema for the Church Equipment Database based on the normalized V1 Data Dictionary.

## Database Schema Diagram

```mermaid
erDiagram
    people {
        uuid person_id PK
        varchar name
        varchar phone_number
    }

    departments {
        uuid department_id PK
        varchar name
    }

    categories {
        uuid category_id PK
        varchar name
        uuid parent_category_id FK "Nullable"
    }

    equipment {
        uuid equipment_id PK
        varchar asset_number "EQ-000001 (UNIQUE)"
        varchar asset_tag "Physical Tag"
        varchar equipment_name
        uuid category_id FK
        varchar brand
        varchar model
        varchar serial_number
        tracking_method_enum tracking_method
        int quantity "CHECK: If tracking=INDIVIDUAL, qty=1"
        condition_enum condition
        status_enum status
        ownership_enum ownership
        uuid owner_person_id FK
        uuid department_id FK
        uuid custodian_person_id FK
        numeric purchase_price_tzs
        date purchase_date
    }

    equipment_assignments {
        uuid assignment_id PK
        uuid equipment_id FK
        uuid department_id FK
        uuid custodian_person_id FK
        date assigned_date
        date released_date "CHECK: >= assigned_date"
    }

    equipment_movements {
        uuid movement_id PK
        uuid equipment_id FK
        varchar destination_name "e.g. Dodoma Youth Camp"
        uuid moved_by_person_id FK
        uuid authorized_by_person_id FK
        date checkout_date
        date expected_return_date
        date actual_return_date "NULL if still out"
    }

    %% Relationships
    people ||--o{ equipment : "owns / custody"
    departments ||--o{ equipment : "assigned"
    categories ||--o{ categories : "parent of"
    categories ||--o{ equipment : "categorizes"
    equipment ||--o{ equipment_assignments : "has"
    equipment ||--o{ equipment_movements : "checked out"
```

## Notes and Constraints
* **Primary Keys:** We are using surrogate IDs (e.g., `EQ-000001`, `DEP-001`) as defined in the consolidation phase.
* **Asset Tags:** `asset_tag` is distinctly separate from `equipment_id` and remains blank until physical verification.
