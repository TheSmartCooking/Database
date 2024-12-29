-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_ingredient_translation(
    IN p_ingredient_id INT,
    IN p_language_id INT
)
BEGIN
    DELETE FROM ingredient_translation
    WHERE ingredient_id = p_ingredient_id AND language_id = p_language_id;
END //

DELIMITER ;
