-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe_category(
    IN p_recipe_id INT,
    IN p_category_id INT
)
BEGIN
    INSERT INTO recipe_category (recipe_id, category_id)
    VALUES (p_recipe_id, p_category_id);
END //

DELIMITER ;
