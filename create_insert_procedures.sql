DROP PROCEDURE IF EXISTS create_person;

DELIMITER $$

CREATE PROCEDURE create_person (
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_password VARBINARY(60),
    IN p_salt VARBINARY(16)
)
BEGIN
    DECLARE email_exists INT;
    
    -- Check if the email already exists
    SELECT COUNT(*) INTO email_exists
    FROM person
    WHERE email = p_email;
    
    IF email_exists = 0 THEN
        -- Insert the new user if the email does not exist
        INSERT INTO person (name, email, password, salt)
        VALUES (p_name, p_email, p_password, p_salt);
    ELSE
        -- Signal that the email already exists
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email already exists';
    END IF;
END$$

DELIMITER ;
