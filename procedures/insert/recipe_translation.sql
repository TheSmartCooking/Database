-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe_translation(
    IN p_recipe_id INT,
    IN p_language_id INT,
    IN p_title VARCHAR(100),
    IN p_details TEXT
    IN p_preparation TEXT
)
BEGIN
    INSERT INTO recipe_translation (recipe_id, language_id, title, details, preparation)
    VALUES (p_recipe_id, p_language_id, p_title, p_details, p_preparation);
END //

DELIMITER ;
