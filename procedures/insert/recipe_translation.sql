-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe_translation(
    IN p_recipe_id INT,
    IN p_language_id INT,
    IN p_title VARCHAR(100),
    IN p_details TEXT,
    IN p_preparation TEXT
)
BEGIN
    INSERT INTO recipe_translation (recipe_id, language_id, title, details, preparation)
    VALUES (p_recipe_id, p_language_id, p_title, p_details, p_preparation);
END //

CREATE OR REPLACE PROCEDURE insert_recipe_translation_by_iso_code(
    IN p_recipe_id INT,
    IN p_language_iso_code CHAR(2),
    IN p_title VARCHAR(100),
    IN p_details TEXT,
    IN p_preparation TEXT
)
BEGIN
    DECLARE v_language_id INT;
    SET v_language_id = (SELECT language_id FROM lang WHERE iso_code = p_language_iso_code);

    CALL insert_recipe_translation(p_recipe_id, v_language_id, p_title, p_details, p_preparation);
END //

DELIMITER ;
