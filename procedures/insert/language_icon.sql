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

CREATE OR REPLACE PROCEDURE insert_language_icon_by_iso_code(
    IN p_iso_code CHAR(2),
    IN p_icon_picture_id INT
)
BEGIN
    DECLARE v_language_id INT;

    SELECT language_id INTO v_language_id
    FROM lang
    WHERE iso_code = p_iso_code;

    CALL insert_language_icon(v_language_id, p_icon_picture_id);
END //
DELIMITER ;
