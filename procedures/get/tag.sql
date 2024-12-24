-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_tags()
BEGIN
    SELECT * FROM tag;
END //

CREATE OR REPLACE PROCEDURE get_tag_by_id(IN p_tag_id INT)
BEGIN
    SELECT * FROM tag
    WHERE tag_id = p_tag_id;
END //

CREATE OR REPLACE PROCEDURE get_tags_by_recipe(IN p_recipe_id INT)
BEGIN
    SELECT * FROM tag
    WHERE recipe_id = p_recipe_id;
END //

CREATE OR REPLACE PROCEDURE get_tags_by_name(IN p_tag_name VARCHAR(25))
BEGIN
    DECLARE safe_tag_name VARCHAR(255);
    SET safe_tag_name = sanitize_string(p_tag_name);

    SELECT *
    FROM tag
    WHERE tag_name LIKE safe_tag_name ESCAPE '\\';
END //

DELIMITER ;
