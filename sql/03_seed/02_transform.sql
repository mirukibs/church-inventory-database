-- 02_transform.sql
-- Performs the ELT transformations to migrate data from staging into the strict production schema.

-- ==========================================
-- 1. DEPARTMENTS
-- ==========================================
-- Create the two official departments
INSERT INTO departments (name) VALUES ('Media'), ('Sound and Music') ON CONFLICT DO NOTHING;

-- ==========================================
-- 2. PEOPLE
-- ==========================================
-- Extract unique names from owner and custodian fields (ignoring nulls and blanks)
INSERT INTO people (name)
SELECT DISTINCT TRIM(owner_person_id)
FROM staging.equipment_raw
WHERE owner_person_id IS NOT NULL AND TRIM(owner_person_id) <> ''
UNION
SELECT DISTINCT TRIM(custodian_person_id)
FROM staging.equipment_raw
WHERE custodian_person_id IS NOT NULL AND TRIM(custodian_person_id) <> '';

-- ==========================================
-- 3. CATEGORIES
-- ==========================================
-- Insert parent categories first
INSERT INTO categories (name, parent_category_id)
SELECT DISTINCT TRIM(category), CAST(NULL AS UUID)
FROM staging.equipment_raw
WHERE category IS NOT NULL AND TRIM(category) <> '';

-- Insert subcategories, linking to their parents
INSERT INTO categories (name, parent_category_id)
SELECT DISTINCT TRIM(r.subcategory), c.category_id
FROM staging.equipment_raw r
JOIN categories c ON c.name = TRIM(r.category) AND c.parent_category_id IS NULL
WHERE r.subcategory IS NOT NULL AND TRIM(r.subcategory) <> ''
ON CONFLICT DO NOTHING;

-- ==========================================
-- 4. EQUIPMENT (The core transformation)
-- ==========================================
-- We must handle the Quantity Anomaly here. 
-- If INDIVIDUAL and quantity > 1, we use generate_series to create duplicate rows.
-- If QUANTITY, we just insert the single row with the full quantity.

INSERT INTO equipment (
    asset_number, asset_tag, equipment_name, category_id, brand, model, serial_number,
    tracking_method, quantity, condition, status, ownership, 
    owner_person_id, department_id, custodian_person_id, unit_cost_tzs
)
SELECT 
    -- Append -idx if we are duplicating an INDIVIDUAL item, otherwise just the asset number
    CASE 
        WHEN r.tracking_method = 'INDIVIDUAL' AND CAST(r.quantity AS INT) > 1 THEN r.equipment_id || '-' || g.idx
        ELSE r.equipment_id 
    END as asset_number,
    
    NULLIF(TRIM(r.asset_tag), '') as asset_tag,
    
    -- Append [Copy #] to the name for duplicates, default to 'Unknown Equipment' if missing
    COALESCE(
        CASE 
            WHEN r.tracking_method = 'INDIVIDUAL' AND CAST(r.quantity AS INT) > 1 THEN TRIM(r.equipment_name) || ' [Copy ' || g.idx || ']'
            ELSE NULLIF(TRIM(r.equipment_name), '') 
        END, 
        'Unknown Equipment'
    ) as equipment_name,
    
    -- Resolve Category UUID (prefer subcategory if exists, otherwise parent)
    COALESCE(
        (SELECT category_id FROM categories WHERE name = TRIM(r.subcategory) LIMIT 1),
        (SELECT category_id FROM categories WHERE name = TRIM(r.category) LIMIT 1)
    ) as category_id,
    
    NULLIF(TRIM(r.brand), '') as brand,
    NULLIF(TRIM(r.model), '') as model,
    NULLIF(TRIM(r.serial_number), '') as serial_number,
    
    COALESCE(CAST(NULLIF(TRIM(r.tracking_method), '') AS tracking_method_enum), 'INDIVIDUAL'::tracking_method_enum),
    
    -- If INDIVIDUAL, force quantity to 1. If QUANTITY, keep original quantity. Default 1.
    COALESCE(
        CASE 
            WHEN r.tracking_method = 'INDIVIDUAL' THEN 1 
            ELSE CAST(NULLIF(TRIM(r.quantity), '') AS INT) 
        END,
        1
    ) as quantity,
    
    COALESCE(CAST(NULLIF(TRIM(r.condition), '') AS condition_enum), 'UNKNOWN'::condition_enum),
    CAST(NULLIF(TRIM(r.status), '') AS status_enum),
    COALESCE(CAST(NULLIF(TRIM(r.ownership), '') AS ownership_enum), 'CHURCH'::ownership_enum),
    
    -- Resolve Foreign Keys
    (SELECT person_id FROM people WHERE name = TRIM(r.owner_person_id) LIMIT 1) as owner_person_id,
    
    (SELECT department_id FROM departments WHERE name = 
        CASE 
            WHEN TRIM(r.department_id) = 'DEP-001' THEN 'Media'
            WHEN TRIM(r.department_id) IN ('DEP-002', 'DEP-003') THEN 'Sound and Music'
        END
    LIMIT 1) as department_id,
    
    (SELECT person_id FROM people WHERE name = TRIM(r.custodian_person_id) LIMIT 1) as custodian_person_id,
    
    CAST(NULLIF(TRIM(r.unit_cost_tzs), '') AS NUMERIC)
    
FROM staging.equipment_raw r
-- The Cross Join dynamically duplicates rows for INDIVIDUAL items with quantity > 1
CROSS JOIN generate_series(1, 
    CASE 
        WHEN r.tracking_method = 'INDIVIDUAL' AND CAST(r.quantity AS INT) > 1 THEN CAST(r.quantity AS INT)
        ELSE 1 
    END
) as g(idx);

-- ==========================================
-- 5. CLEANUP
-- ==========================================
-- Drop the staging schema completely, leaving only pristine data.
DROP SCHEMA staging CASCADE;
