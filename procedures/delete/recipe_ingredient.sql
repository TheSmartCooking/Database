-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_recipe_ingredient(
    IN p_recipe_id INT,
    IN p_ingredient_id INT
)
BEGIN
    DELETE FROM recipe_ingredient
    WHERE recipe_id = p_recipe_id
    AND ingredient_id = p_ingredient_id;
END //

DELIMITER ;
