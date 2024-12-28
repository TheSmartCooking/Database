-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE FUNCTION has_permission(p_person_id INT, p_responsibility_name VARCHAR(100))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_result INT;

    SELECT COUNT(*)
    INTO v_result
    FROM person_responsibility pr
    INNER JOIN responsibility r ON pr.responsibility_id = r.responsibility_id
    WHERE pr.person_id = p_person_id AND r.responsibility_name = p_responsibility_name;
    RETURN v_result > 0;
END //

DELIMITER ;
