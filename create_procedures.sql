DELIMITER $$

CREATE PROCEDURE create_user(
    IN p_username VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    OUT p_user_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_user_id = -1;
    END;

    INSERT INTO user (username, email, password, registration_date)
    VALUES (p_username, p_email, p_password, NOW());

    SET p_user_id = LAST_INSERT_ID();
END$$

DELIMITER ;
