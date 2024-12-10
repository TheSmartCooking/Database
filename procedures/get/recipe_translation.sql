-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_recipe_translations()
BEGIN
    SELECT recipe_id, language_id, title, details, preparation
    FROM recipe_translation;
END //

CREATE OR REPLACE PROCEDURE get_recipe_translation_by_id(
    IN p_recipe_id INT,
    IN p_language_id INT
)
BEGIN
    SELECT title, details, preparation
    FROM recipe_translation
    WHERE recipe_id = p_recipe_id AND language_id = p_language_id;
END //

CREATE OR REPLACE PROCEDURE get_recipe_translation_by_iso_code(
    IN p_recipe_id INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    SELECT title, details, preparation
    FROM recipe_translation
    WHERE recipe_id = p_recipe_id AND language_id = (SELECT language_id FROM lang WHERE iso_code = p_language_iso_code);
END //

DELIMITER ;
