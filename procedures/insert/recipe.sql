-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe (
    IN p_author_id INT,
    IN p_picture_id INT,
    IN p_preparation_time INT,
    IN p_cook_time INT,
    IN p_servings INT,
    IN p_difficulty_level TINYINT,
    IN p_estimated_cost TINYINT,
    IN p_number_of_reviews INT,
    IN p_recipe_source VARCHAR(255),
    IN p_recipe_status_name VARCHAR(25)
)
BEGIN
    DECLARE v_status_id TINYINT DEFAULT NULL;

    -- Retrieve the status_id corresponding to the status name
    SELECT status_id
    INTO v_status_id
    FROM recipe_status
    WHERE status_name = p_recipe_status_name;

    -- Default to 'draft' (status_id = 1) if the status name is not found
    IF v_status_id IS NULL THEN
        SET v_status_id = 1;
    END IF;

    -- Insert a new recipe
    INSERT INTO recipe (
        author_id,
        picture_id,
        preparation_time,
        cook_time,
        servings,
        difficulty_level,
        estimated_cost,
        number_of_reviews,
        recipe_source,
        recipe_status,
        modification_date
    ) VALUES (
        p_author_id,
        p_picture_id,
        p_preparation_time,
        p_cook_time,
        p_servings,
        p_difficulty_level,
        p_estimated_cost,
        p_number_of_reviews,
        p_recipe_source,
        v_status_id,
        CURRENT_TIMESTAMP
    );
END //

DELIMITER ;
