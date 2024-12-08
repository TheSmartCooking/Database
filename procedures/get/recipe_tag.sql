-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_recipe_tag(IN p_recipe_id INT)
BEGIN
    SELECT * FROM recipe_tag
    WHERE recipe_id = p_recipe_id;
END //

CREATE OR REPLACE PROCEDURE get_recipe_tags(IN p_recipe_id INT)
BEGIN
    SELECT rt.tag_id, t.tag_name
    FROM recipe_tag rt
    JOIN tag t ON rt.tag_id = t.tag_id
    WHERE recipe_id = p_recipe_id;
END //

DELIMITER ;
