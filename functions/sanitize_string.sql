-- Use the database
USE smartcooking;

DELIMITER //

CREATE FUNCTION sanitize_string(p_string VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
  DECLARE v_safe_string VARCHAR(255);

  -- Escape SQL special characters
  SET v_safe_string = REPLACE(p_string, '\\', '\\\\'); -- Escape backslash
  SET v_safe_string = REPLACE(v_safe_string, '%', '\\%'); -- Escape percent
  SET v_safe_string = REPLACE(v_safe_string, '_', '\\_'); -- Escape underscore
  SET v_safe_string = REPLACE(v_safe_string, '\'', '\\\''); -- Escape single quote
  SET v_safe_string = REPLACE(v_safe_string, '"', '\\"'); -- Escape double quote
  SET v_safe_string = REPLACE(v_safe_string, ';', '\\;'); -- Escape semicolon

  -- Return the safe string with wildcards added
  RETURN CONCAT('%', v_safe_string, '%');
END //

DELIMITER ;
