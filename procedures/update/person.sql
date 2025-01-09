-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE update_last_login(
    IN p_person_id INT
)
BEGIN
    UPDATE person
    SET last_login = NOW()
    WHERE person_id = p_person_id;
END //

CREATE OR REPLACE PROCEDURE update_person(
    IN p_person_id INT,
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_hashed_password VARBINARY(255),
    IN p_salt BINARY(16),
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE name_exists INT;
    DECLARE email_exists INT;
    DECLARE v_language_id INT;

    -- Check if the person name or email already exists
    SELECT
        SUM(person_name = p_name AND person_id != p_person_id),
        SUM(email = p_email AND person_id != p_person_id)
    INTO name_exists, email_exists
    FROM person;

    IF name_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User name already exists';
    END IF;

    IF email_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
    END IF;

    -- Retrieve the language ID if provided
    IF p_language_iso_code IS NOT NULL THEN
        SELECT language_id INTO v_language_id
        FROM lang
        WHERE iso_code = p_language_iso_code;

        IF v_language_id IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid language code';
        END IF;
    ELSE
        SET v_language_id = NULL;
    END IF;

    -- Update the person record
    UPDATE person
    SET
        person_name = COALESCE(p_name, person_name),
        email = COALESCE(p_email, email),
        hashed_password = COALESCE(p_hashed_password, hashed_password),
        salt = COALESCE(p_salt, salt),
        language_id = COALESCE(v_language_id, language_id)
    WHERE person_id = p_person_id;
END //

DELIMITER ;
