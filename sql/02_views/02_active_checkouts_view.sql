-- 02_active_checkouts_view.sql
-- A view returning all equipment currently signed out of the church building.

CREATE OR REPLACE VIEW v_active_checkouts AS
SELECT 
    m.movement_id,
    e.asset_number,
    e.equipment_name,
    m.destination_name,
    p_moved.name AS moved_by,
    p_auth.name AS authorized_by,
    m.checkout_date,
    m.expected_return_date
FROM equipment_movements m
JOIN equipment e ON m.equipment_id = e.equipment_id
JOIN people p_moved ON m.moved_by_person_id = p_moved.person_id
LEFT JOIN people p_auth ON m.authorized_by_person_id = p_auth.person_id
WHERE m.actual_return_date IS NULL;
