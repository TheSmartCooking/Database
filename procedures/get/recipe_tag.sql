-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_recipe_tag(IN p_recipe_id INT)
BEGIN
    SELECT * FROM recipe_tag
    WHERE recipe_id = p_recipe_id;
END //

DELIMITER ;
