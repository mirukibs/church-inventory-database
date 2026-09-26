-- 02_status_triggers.sql
-- PL/pgSQL automated triggers for auditing.

CREATE OR REPLACE FUNCTION trg_log_equipment_changes()
RETURNS TRIGGER AS $$
BEGIN
    -- Log condition changes
    IF OLD.condition IS DISTINCT FROM NEW.condition THEN
        INSERT INTO equipment_audit_log (equipment_id, changed_field, old_value, new_value)
        VALUES (NEW.equipment_id, 'condition', OLD.condition::text, NEW.condition::text);
    END IF;

    -- Log status changes
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        INSERT INTO equipment_audit_log (equipment_id, changed_field, old_value, new_value)
        VALUES (NEW.equipment_id, 'status', OLD.status::text, NEW.status::text);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_equipment_audit
AFTER UPDATE ON equipment
FOR EACH ROW
EXECUTE FUNCTION trg_log_equipment_changes();
