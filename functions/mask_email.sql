-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE FUNCTION mask_email(p_email VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE local_part VARCHAR(100);
    DECLARE domain_part VARCHAR(100);

    SET local_part = SUBSTRING_INDEX(p_email, '@', 1);
    SET domain_part = SUBSTRING_INDEX(p_email, '@', -1);

    IF LENGTH(local_part) <= 2 THEN
        RETURN CONCAT(local_part, '@', domain_part);
    ELSE
        RETURN CONCAT(
            LEFT(local_part, 1),
            REPEAT('*', LENGTH(local_part) - 2),
            RIGHT(local_part, 1),
            '@',
            domain_part
        );
    END IF;
END //

DELIMITER ;
