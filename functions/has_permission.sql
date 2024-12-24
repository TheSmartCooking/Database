-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE FUNCTION has_permission(p_user_id INT, p_permission_name VARCHAR(50))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE result INT;
    SELECT COUNT(*)
    INTO result
    FROM person_responsibility
    WHERE user_id = p_user_id AND responsibility_name = p_permission_name;
    RETURN result > 0;
END;

DELIMITER ;
