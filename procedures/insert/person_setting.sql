-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_person_setting(
    IN p_person_id INT,
    IN p_setting_key VARCHAR(100),
    IN p_setting_value VARCHAR(255)
)
BEGIN
    INSERT INTO person_setting (person_id, setting_key, setting_value)
    VALUES (p_person_id, p_setting_key, p_setting_value);
END //

DELIMITER ;
