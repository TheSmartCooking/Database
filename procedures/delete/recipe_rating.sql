-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_recipe_rating(
    IN p_recipe_id INT,
    IN p_user_id INT
)
BEGIN
    DELETE FROM recipe_rating
    WHERE recipe_id = p_recipe_id AND person_id = p_user_id;
END //

DELIMITER ;
