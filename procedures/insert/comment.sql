-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_comment(
    IN p_content TEXT,
    IN p_author_id INT,
    IN p_recipe_id INT
)
BEGIN
    INSERT INTO comment (content, author_id, recipe_id)
    VALUES (p_content, p_author_id, p_recipe_id);
END //

DELIMITER ;
