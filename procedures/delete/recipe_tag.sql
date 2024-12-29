-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_recipe_tag(
    IN p_recipe_id INT,
    IN p_tag_id INT
)
BEGIN
    DELETE FROM recipe_tag
    WHERE recipe_id = p_recipe_id
    AND tag_id = p_tag_id;
END //

CREATE OR REPLACE PROCEDURE delete_all_recipe_tags(
    IN p_recipe_id INT
)
BEGIN
    DELETE FROM recipe_tag
    WHERE recipe_id = p_recipe_id;
END //

DELIMITER ;
