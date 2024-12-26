-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE FUNCTION mask_email(p_email VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE local_part VARCHAR(100);
    DECLARE domain_part VARCHAR(100);
    DECLARE domain_name VARCHAR(100);
    DECLARE domain_extension VARCHAR(10);
    DECLARE last_dot_pos INT;

    -- Extract local part and full domain
    SET local_part = SUBSTRING_INDEX(p_email, '@', 1);
    SET domain_part = SUBSTRING_INDEX(p_email, '@', -1);

    -- Find the position of the last dot in the domain part
    SET last_dot_pos = LOCATE('.', REVERSE(domain_part));

    -- Extract domain name and extension based on the last dot position
    SET domain_name = LEFT(domain_part, LENGTH(domain_part) - last_dot_pos);
    SET domain_extension = RIGHT(domain_part, last_dot_pos - 1);

    -- Mask the local part
    IF LENGTH(local_part) <= 2 THEN
        SET local_part = local_part; -- No masking for short local parts
    ELSE
        SET local_part = CONCAT(
            LEFT(local_part, 1),
            REPEAT('*', LENGTH(local_part) - 2),
            RIGHT(local_part, 1)
        );
    END IF;

    -- Mask the domain name
    IF LENGTH(domain_name) <= 2 THEN
        SET domain_name = domain_name; -- No masking for short domain names
    ELSE
        SET domain_name = CONCAT(
            LEFT(domain_name, 1),
            REPEAT('*', LENGTH(domain_name) - 2),
            RIGHT(domain_name, 1)
        );
    END IF;

    -- Return the fully masked email
    RETURN CONCAT(
        local_part,
        '@',
        domain_name,
        '.',
        domain_extension
    );
END //

DELIMITER ;
