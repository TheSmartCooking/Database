-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe_tag(
    IN p_recipe_id INT,
    IN p_tag_id INT
)
BEGIN
    INSERT INTO recipe_tag (recipe_id, tag_id)
    VALUES (p_recipe_id, p_tag_id);
END //

CREATE OR REPLACE PROCEDURE insert_recipe_tags(
    IN p_recipe_id INT,
    IN p_tag_ids JSON
)
BEGIN
    INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT p_recipe_id, tag_id
    FROM JSON_TABLE(
        p_tag_ids,
        '$[*]' COLUMNS(tag_id INT PATH '$')
    ) AS tags;
END //

DELIMITER ;
