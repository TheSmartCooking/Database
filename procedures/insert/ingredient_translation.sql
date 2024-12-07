-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_ingredient_translation(
    IN p_language_id INT,
    IN p_translated_name VARCHAR(255)
)
BEGIN
    INSERT INTO ingredient_translation (language_id, translated_name)
    VALUES (p_language_id, p_translated_name);
END //

CREATE OR REPLACE PROCEDURE insert_ingredient_translation_by_iso_code(
    IN p_iso_code CHAR(2),
    IN p_translated_name VARCHAR(255)
)
BEGIN
    DECLARE v_language_id INT;

    SELECT id INTO v_language_id
    FROM lang
    WHERE iso_code = p_iso_code;

    CALL insert_ingredient_translation_by_language_id(v_language_id, p_translated_name);
END //

DELIMITER ;
