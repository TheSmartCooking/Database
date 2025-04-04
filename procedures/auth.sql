-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE register_person(
    IN p_name VARCHAR(100),
    IN p_hashed_email VARCHAR(255),
    IN p_encrypted_email VARCHAR(255),
    IN p_hashed_password VARBINARY(255),
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
    WHERE hashed_email = p_hashed_email;

    IF v_email_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
    END IF;

    -- Retrieve the language ID
    SELECT language_id INTO v_language_id
    FROM lang
    WHERE iso_code = p_language_iso_code;

    -- Insert the new person into the database
    INSERT INTO person (person_name, hashed_email, encrypted_email, hashed_password, language_id)
    VALUES (p_name, p_hashed_email, p_encrypted_email, p_hashed_password, v_language_id);
END //

CREATE OR REPLACE PROCEDURE login_person(
    IN p_person_id INT,
    IN p_hashed_email VARCHAR(255)
)
BEGIN
    DECLARE v_person_id INT;
    DECLARE v_hashed_password VARCHAR(100);

    -- Check if the person exists
    IF NOT person_exists(p_person_id, p_hashed_email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found';
    END IF;

    -- Retrieve the person_id, hashed salted password
    SELECT person_id, hashed_password
    INTO v_person_id, v_hashed_password
    FROM person
    WHERE (person_id = p_person_id OR hashed_email = p_hashed_email);

    -- Return the result set
    SELECT v_person_id AS person_id, v_hashed_password AS hashed_password;
END //

CREATE OR REPLACE PROCEDURE login_person_by_id(
    IN p_person_id INT
)
BEGIN
    CALL login_person(p_person_id, NULL);
END //

CREATE OR REPLACE PROCEDURE login_person_by_email(
    IN p_hashed_email VARCHAR(255)
)
BEGIN
    CALL login_person(NULL, p_hashed_email);
END //

DELIMITER ;
