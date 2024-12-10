-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_ingredients()
BEGIN
    SELECT * FROM ingredient;
END //

CREATE OR REPLACE PROCEDURE get_ingredient_by_id(IN p_ingredient_id INT)
BEGIN
    SELECT default_name FROM ingredient
    WHERE ingredient_id = p_ingredient_id;
END //

DELIMITER ;
