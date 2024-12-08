-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_recipe_ingredients()
BEGIN
    SELECT * FROM recipe_ingredient;
END //

CREATE OR REPLACE PROCEDURE get_recipe_ingredients(IN p_recipe_id INT)
BEGIN
    SELECT ingredient_id, quantity, unit
    FROM recipe_ingredient
    WHERE recipe_id = p_recipe_id;
END //

DELIMITER ;
