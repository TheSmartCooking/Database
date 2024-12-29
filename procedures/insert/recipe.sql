-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe(
    IN author_id INT,
    IN picture_id INT,
    IN cook_time INT,
    IN difficulty_level TINYINT,
    IN recipe_source VARCHAR(255),
    IN recipe_status VARCHAR(20)
)
BEGIN
    IF recipe_status IS NULL THEN
        SET recipe_status = 'pending review';
    END IF;

    INSERT INTO recipe (author_id, picture_id, cook_time, difficulty_level, recipe_source, recipe_status)
    VALUES (author_id, picture_id, cook_time, difficulty_level, recipe_source, recipe_status);
END //

DELIMITER ;
