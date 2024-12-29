-- Use the database
USE smartcooking;

DELIMITER //

CREATE FUNCTION calculate_offset(p_offset INT, p_limit INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_offset INT;
    SET v_offset = (p_offset - 1) * LEAST(p_limit, 30);
    RETURN v_offset;
END //

DELIMITER ;
