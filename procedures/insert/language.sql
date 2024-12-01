-- Use the database
USE smartcooking;

DELIMITER //

CREATE PROCEDURE insert_language(
    IN p_iso_code VARCHAR(2),
    IN p_language_name VARCHAR(30),
    IN p_native_name VARCHAR(30)
)
BEGIN
    INSERT INTO lang (iso_code, language_name, native_name)
    VALUES (p_iso_code, p_language_name, p_native_name);
END //

DELIMITER ;
