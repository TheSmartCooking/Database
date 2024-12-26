-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_recipe_translation(
    IN p_recipe_id INT,
    IN p_language_id INT
)
BEGIN
    DELETE FROM recipe_translation
    WHERE recipe_id = p_recipe_id AND language_id = p_language_id;
END //

DELIMITER ;
