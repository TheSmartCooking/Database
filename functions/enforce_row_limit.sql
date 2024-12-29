-- Use the database
USE smartcooking;

DELIMITER //

CREATE FUNCTION enforce_row_limit(p_limit INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_max_limit INT DEFAULT 30;
    RETURN LEAST(p_limit, v_max_limit);
END //

DELIMITER ;
