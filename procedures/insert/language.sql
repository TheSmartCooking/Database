-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_language(
    IN p_iso_code CHAR(2),
    IN p_english_name VARCHAR(30),
    IN p_native_name VARCHAR(30)
)
BEGIN
    INSERT INTO lang (iso_code, english_name, native_name)
    VALUES (p_iso_code, p_english_name, p_native_name);
END //

DELIMITER ;
