-- 02_tables.sql
-- Contains all physical table definitions, using UUID primary keys and strict constraints.
-- Requires 01_enums.sql to be executed first.

-- Enable UUID extension (if not already enabled)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==========================================
-- 1. PEOPLE (Minimal Directory)
-- ==========================================
CREATE TABLE people (
    person_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50)
);

-- ==========================================
-- 2. DEPARTMENTS (Official Custodians)
-- ==========================================
CREATE TABLE departments (
    department_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) UNIQUE NOT NULL
);

-- ==========================================
-- 3. CATEGORIES (Normalized Taxonomy)
-- ==========================================
CREATE TABLE categories (
    category_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    parent_category_id UUID REFERENCES categories(category_id) ON DELETE RESTRICT,
    UNIQUE (name, parent_category_id)
);

-- ==========================================
-- 4. EQUIPMENT (Master Inventory)
-- ==========================================
CREATE TABLE equipment (
    equipment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    -- Identifiers
    asset_number VARCHAR(50) UNIQUE NOT NULL, -- e.g., EQ-000001
    asset_tag VARCHAR(100) UNIQUE,            -- Physical QR/Barcode label
    serial_number VARCHAR(255),
    
    -- Descriptors
    equipment_name VARCHAR(255) NOT NULL,
    category_id UUID NOT NULL REFERENCES categories(category_id) ON DELETE RESTRICT,
    brand VARCHAR(100),
    model VARCHAR(100),
    
    -- Tracking & Status
    tracking_method tracking_method_enum NOT NULL,
    quantity INT NOT NULL,
    condition condition_enum NOT NULL,
    status status_enum,
    
    -- Ownership & Custody
    ownership ownership_enum NOT NULL,
    owner_person_id UUID REFERENCES people(person_id) ON DELETE SET NULL,
    department_id UUID REFERENCES departments(department_id) ON DELETE RESTRICT,
    custodian_person_id UUID REFERENCES people(person_id) ON DELETE SET NULL,
    
    -- Financials
    unit_cost_tzs NUMERIC(14,2),

    -- Constraints
    CONSTRAINT chk_quantity_positive CHECK (quantity > 0),
    CONSTRAINT chk_individual_quantity CHECK (
        (tracking_method = 'INDIVIDUAL' AND quantity = 1) OR
        (tracking_method = 'QUANTITY' AND quantity >= 1)
    )
);

-- ==========================================
-- 5. EQUIPMENT ASSIGNMENTS (History Log)
-- ==========================================
CREATE TABLE equipment_assignments (
    assignment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    equipment_id UUID NOT NULL REFERENCES equipment(equipment_id) ON DELETE CASCADE,
    department_id UUID NOT NULL REFERENCES departments(department_id) ON DELETE RESTRICT,
    custodian_person_id UUID REFERENCES people(person_id) ON DELETE SET NULL,
    assigned_date DATE NOT NULL DEFAULT CURRENT_DATE,
    released_date DATE
);

-- ==========================================
-- 6. EQUIPMENT MOVEMENTS (Checkout / Event Log)
-- ==========================================
CREATE TABLE equipment_movements (
    movement_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    equipment_id UUID NOT NULL REFERENCES equipment(equipment_id) ON DELETE CASCADE,
    
    destination_name VARCHAR(255) NOT NULL, -- e.g., Dodoma Crusade
    
    moved_by_person_id UUID NOT NULL REFERENCES people(person_id) ON DELETE RESTRICT,
    authorized_by_person_id UUID REFERENCES people(person_id) ON DELETE SET NULL,
    
    checkout_date DATE NOT NULL DEFAULT CURRENT_DATE,
    expected_return_date DATE,
    actual_return_date DATE,

    -- Constraints
    CONSTRAINT chk_return_after_checkout CHECK (actual_return_date IS NULL OR actual_return_date >= checkout_date),
    CONSTRAINT chk_expected_after_checkout CHECK (expected_return_date IS NULL OR expected_return_date >= checkout_date)
);
