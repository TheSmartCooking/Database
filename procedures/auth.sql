-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE register_person(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_hashed_password VARBINARY(255),
    IN p_salt BINARY(16),
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_name_exists INT;
    DECLARE v_email_exists INT;
    DECLARE v_language_id INT;

    -- Check if the person name already exists
    SELECT COUNT(*) INTO v_name_exists
    FROM person
    WHERE person_name = p_name;

    IF v_name_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User name already exists';
    END IF;

    -- Check if the email already exists
    SELECT COUNT(*) INTO v_email_exists
    FROM person
    WHERE email = p_email;

    IF v_email_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
    END IF;

    -- Retrieve the language ID
    SELECT language_id INTO v_language_id
    FROM lang
    WHERE iso_code = p_language_iso_code;

    -- Insert the new person into the database
    INSERT INTO person (person_name, email, hashed_password, salt, language_id)
    VALUES (p_name, p_email, p_hashed_password, p_salt, v_language_id);
END //

CREATE OR REPLACE PROCEDURE login_person(
    IN p_email VARCHAR(100)
)
BEGIN
    -- Check if the person exists
    IF NOT EXISTS (
        SELECT 1
        FROM person
        WHERE email = p_email
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found';
    END IF;

    -- Retrieve the hashed password and salt as a result set
    SELECT person_id, hashed_password, salt
    FROM person
    WHERE email = p_email;
END //

DELIMITER ;
