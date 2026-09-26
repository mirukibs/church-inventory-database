-- 01_equipment_master_view.sql
-- A flattened, spreadsheet-like view of the core equipment table resolving all UUIDs into human-readable strings.

CREATE OR REPLACE VIEW v_equipment_master AS
SELECT 
    e.equipment_id,
    e.asset_number,
    e.asset_tag,
    e.equipment_name,
    c.name AS category_name,
    pc.name AS parent_category_name,
    e.brand,
    e.model,
    e.serial_number,
    e.tracking_method,
    e.quantity,
    e.condition,
    e.status,
    e.ownership,
    o.name AS owner_name,
    d.name AS department_name,
    cust.name AS custodian_name,
    e.purchase_price_tzs,
    e.purchase_date
FROM equipment e
LEFT JOIN categories c ON e.category_id = c.category_id
LEFT JOIN categories pc ON c.parent_category_id = pc.category_id
LEFT JOIN people o ON e.owner_person_id = o.person_id
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN people cust ON e.custodian_person_id = cust.person_id;
