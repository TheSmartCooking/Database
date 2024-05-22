DELIMITER $$

CREATE PROCEDURE create_user(
    IN p_username VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    OUT p_user_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_user_id = -1;
    END;

    INSERT INTO user (username, email, password, registration_date)
    VALUES (p_username, p_email, p_password, NOW());

    SET p_user_id = LAST_INSERT_ID();
END$$

CREATE PROCEDURE create_recipe(
    IN p_author_id INT,
    IN p_title VARCHAR(255),
    IN p_description TEXT,
    IN p_ingredients TEXT,
    IN p_preparation TEXT,
    IN p_image VARCHAR(255) NULL,
    IN p_cook_time INT NULL,
    IN p_difficulty_level VARCHAR(255) NULL,
    IN p_nutritional_information TEXT NULL,
    IN p_source VARCHAR(255) NULL,
    IN p_allergen_information TEXT NULL,
    IN p_video_url VARCHAR(255) NULL,
    OUT p_recipe_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_recipe_id = -1;
    END;

    INSERT INTO recipe (
        author_id,
        title,
        description,
        ingredients,
        preparation,
        publication_date,
        image,
        cook_time,
        difficulty_level,
        nutritional_information,
        source,
        allergen_information,
        video_url,
        status
    ) VALUES (
        p_author_id,
        p_title,
        p_description,
        p_ingredients,
        p_preparation,
        NOW(),
        COALESCE(p_image, NULL),
        COALESCE(p_cook_time, NULL),
        COALESCE(p_difficulty_level, NULL),
        COALESCE(p_nutritional_information, NULL),
        COALESCE(p_source, NULL),
        COALESCE(p_allergen_information, NULL),
        COALESCE(p_video_url, NULL),
        NULL
    );

    SET p_recipe_id = LAST_INSERT_ID();
END$$

DELIMITER ;
