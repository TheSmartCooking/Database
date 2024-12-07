-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_ingredient_translation(
    IN p_language_id INT,
    IN p_ingredient_id INT,
    IN p_translated_name VARCHAR(255)
)
BEGIN
    INSERT INTO ingredient_translation (language_id, translated_name)
    VALUES (p_language_id, p_translated_name);
END //

CREATE OR REPLACE PROCEDURE insert_ingredient_translation_by_names(
    IN p_language_iso_code CHAR(2),
    IN p_ingredient_default_name VARCHAR(255),
    IN p_translated_name VARCHAR(255)
)
BEGIN
    DECLARE v_language_id INT;
    DECLARE v_ingredient_id INT;

    SELECT language_id INTO v_language_id
    FROM lang
    WHERE iso_code = p_language_iso_code;

    SELECT ingredient_id INTO v_ingredient_id
    FROM ingredient
    WHERE default_name = p_ingredient_default_name;

    CALL insert_ingredient_translation(v_language_id, v_ingredient_id, p_translated_name);
END //

DELIMITER ;
