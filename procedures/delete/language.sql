-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_language(
    IN p_language_id INT
)
BEGIN
    DELETE FROM lang
    WHERE id = p_language_id;
END //

CREATE OR REPLACE PROCEDURE delete_language_by_iso_code(
    IN p_iso_code VARCHAR(2)
)
BEGIN
    DELETE FROM lang
    WHERE iso_code = p_iso_code;
END //

DELIMITER ;
