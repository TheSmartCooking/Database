-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE FUNCTION mask_email(p_email VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(
        LEFT(p_email, 1),
        REPEAT('*', LENGTH(SUBSTRING_INDEX(p_email, '@', 1)) - 2),
        RIGHT(SUBSTRING_INDEX(p_email, '@', 1), 1),
        '@',
        SUBSTRING_INDEX(p_email, '@', -1)
    );
END //

DELIMITER ;
