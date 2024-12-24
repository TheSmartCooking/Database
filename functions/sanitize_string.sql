-- Use the database
USE smartcooking;

DELIMITER //

CREATE FUNCTION sanitize_string(p_keyword VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
  DECLARE safe_keyword VARCHAR(255);

  -- Escape SQL special characters
  SET safe_keyword = REPLACE(p_keyword, '\\', '\\\\'); -- Escape backslash
  SET safe_keyword = REPLACE(safe_keyword, '%', '\\%'); -- Escape percent
  SET safe_keyword = REPLACE(safe_keyword, '_', '\\_'); -- Escape underscore
  SET safe_keyword = REPLACE(safe_keyword, '\'', '\\\''); -- Escape single quote
  SET safe_keyword = REPLACE(safe_keyword, '"', '\\"'); -- Escape double quote
  SET safe_keyword = REPLACE(safe_keyword, ';', '\\;'); -- Escape semicolon

  -- Return the safe keyword with wildcards added
  RETURN CONCAT('%', safe_keyword, '%');
END //

DELIMITER ;
