-- Use the database
USE smartcooking;

DELIMITER //

CREATE FUNCTION sanitize_string(p_string VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
  DECLARE safe_string VARCHAR(255);

  -- Escape SQL special characters
  SET safe_string = REPLACE(p_string, '\\', '\\\\'); -- Escape backslash
  SET safe_string = REPLACE(safe_string, '%', '\\%'); -- Escape percent
  SET safe_string = REPLACE(safe_string, '_', '\\_'); -- Escape underscore
  SET safe_string = REPLACE(safe_string, '\'', '\\\''); -- Escape single quote
  SET safe_string = REPLACE(safe_string, '"', '\\"'); -- Escape double quote
  SET safe_string = REPLACE(safe_string, ';', '\\;'); -- Escape semicolon

  -- Return the safe string with wildcards added
  RETURN CONCAT('%', safe_string, '%');
END //

DELIMITER ;
