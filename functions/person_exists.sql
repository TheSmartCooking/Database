-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE FUNCTION person_exists(
    IN p_person_id INT,
    IN p_email_hash VARCHAR(100)
) RETURNS BOOLEAN
BEGIN
    DECLARE v_exists BOOLEAN;

    SELECT EXISTS (
        SELECT 1
        FROM person
        WHERE (person_id = p_person_id OR hashed_email = p_email_hash)
    ) INTO v_exists;

    RETURN v_exists;
END //

DELIMITER ;
