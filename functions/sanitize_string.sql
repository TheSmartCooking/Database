-- Use the database
USE smartcooking;

DELIMITER //

CREATE FUNCTION sanitize_string(p_keyword VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
  DECLARE safe_keyword VARCHAR(255);

  -- Escape special SQL wildcard characters '%' and '_'
  SET safe_keyword = REPLACE(p_keyword, '%', '\\%');
  SET safe_keyword = REPLACE(safe_keyword, '_', '\\_');

  -- Return the safe keyword with wildcards added
  RETURN CONCAT('%', safe_keyword, '%');
END //

DELIMITER ;
