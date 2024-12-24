-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE FUNCTION has_permission(p_person_id INT, p_responsibility_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE result INT;
    SELECT COUNT(*)
    INTO result
    FROM person_responsibility
    WHERE person_id = p_person_id AND responsibility_id = p_responsibility_id;
    RETURN result > 0;
END //

DELIMITER ;
