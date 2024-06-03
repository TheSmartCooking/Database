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

DELIMITER ;
