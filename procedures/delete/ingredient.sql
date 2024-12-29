-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_ingredient(
    IN p_ingredient_id INT
)
BEGIN
    DELETE FROM ingredient
    WHERE id = p_ingredient_id;
END //

DELIMITER ;
