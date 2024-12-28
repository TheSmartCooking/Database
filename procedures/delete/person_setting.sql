-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_person_setting(
    IN p_person_id INT,
    IN p_setting_key VARCHAR(50)
)
BEGIN
    DELETE FROM person_setting
    WHERE setting_key = p_setting_key AND person_id = p_person_id;
END //

DELIMITER ;
