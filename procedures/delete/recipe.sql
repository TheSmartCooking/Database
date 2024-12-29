-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_recipe(
    IN p_recipe_id INT
)
BEGIN
    DELETE FROM recipe
    WHERE recipe_id = p_recipe_id;
END //

DELIMITER ;
