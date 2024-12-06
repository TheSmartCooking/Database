-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_language_icon(
    IN p_language_id INT,
    IN p_icon_picture_id INT
)
BEGIN
    INSERT INTO lang_icon (language_id, icon_picture_id)
    VALUES (p_language_id, p_icon_picture_id);
END //

DELIMITER ;
