DROP PROCEDURE IF EXISTS update_last_login;

DELIMITER $$

CREATE PROCEDURE update_last_login(
    IN p_person_id INT
)
BEGIN
    UPDATE person
    SET last_login = CURRENT_TIMESTAMP
    WHERE person_id = p_person_id;
END$$

CREATE PROCEDURE update_person_locale(
    IN p_person_id INT,
    IN p_locale_id INT
)
BEGIN
    DECLARE locale_exists INT;
    
    -- Check if the locale exists
    SELECT COUNT(*) INTO locale_exists
    FROM locale
    WHERE locale_id = p_locale_id;
    
    IF locale_exists = 1 THEN
        -- Update the person's locale_id
        UPDATE person
        SET locale_id = p_locale_id
        WHERE person_id = p_person_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Locale does not exist';
    END IF;
END$$

DELIMITER ;
