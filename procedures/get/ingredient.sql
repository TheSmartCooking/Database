-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE get_all_ingredients()
BEGIN
    SELECT ingredient_id, ingredient_name, ingredient_description
    FROM ingredient;
END //

DELIMITER ;
