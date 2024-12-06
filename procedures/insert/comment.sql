-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_comment(
    IN p_comment TEXT,
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    INSERT INTO comment (comment, person_id, recipe_id)
    VALUES (p_comment, p_person_id, p_recipe_id);
END //

DELIMITER ;
