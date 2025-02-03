-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe(
    IN author_id INT,
    IN picture_id INT,
    IN cook_time INT,
    IN difficulty_level TINYINT,
    IN recipe_source VARCHAR(255),
    IN recipe_status_name VARCHAR(25)
)
BEGIN
    DECLARE status_id TINYINT;

    SELECT status_id INTO status_id
    FROM recipe_status
    WHERE status_name = recipe_status_name;

    -- If the status name is not found, default to 'draft' (status_id = 1)
    IF status_id IS NULL THEN
        SET status_id = 1;
    END IF;

    INSERT INTO recipe (author_id, picture_id, cook_time, difficulty_level, recipe_source, recipe_status)
    VALUES (author_id, picture_id, cook_time, difficulty_level, recipe_source, status_id);
END //

DELIMITER ;
