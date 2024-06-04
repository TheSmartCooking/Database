DROP PROCEDURE IF EXISTS create_person;
DROP PROCEDURE IF EXISTS create_image;
DROP PROCEDURE IF EXISTS create_locale;
DROP PROCEDURE IF EXISTS create_responsibility;
DROP PROCEDURE IF EXISTS create_status;
DROP PROCEDURE IF EXISTS create_ingredient;
DROP PROCEDURE IF EXISTS create_tag;
DROP PROCEDURE IF EXISTS create_recipe;
DROP PROCEDURE IF EXISTS create_comment;
DROP PROCEDURE IF EXISTS create_comment_like;
DROP PROCEDURE IF EXISTS create_favorite;
DROP PROCEDURE IF EXISTS create_recipe_tag;
DROP PROCEDURE IF EXISTS create_recipe_rating;

DELIMITER $$

CREATE PROCEDURE create_person(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100),
    IN p_salt VARBINARY(16),
    IN p_locale_code VARCHAR(10) NULL
)
BEGIN
    DECLARE email_exists INT;
    DECLARE new_person_id INT;
    DECLARE locale_id INT;

    -- Check if the email already exists
    SELECT COUNT(*) INTO email_exists
    FROM person
    WHERE email = p_email;
    
    IF email_exists = 0 THEN
        INSERT INTO person (name, email, password, salt)
        VALUES (p_name, p_email, p_password, p_salt);
        
        SET new_person_id = LAST_INSERT_ID();
        
        IF p_locale_code IS NOT NULL THEN
            -- Get the locale_id for the provided locale_code
            CALL get_locale(p_locale_code, @locale_id);
            SET locale_id = @locale_id;
            -- Link the person to the locale
            CALL link_person_to_locale(new_person_id, locale_id);
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email already exists';
    END IF;
END$$

CREATE PROCEDURE create_image(
    IN p_image_path VARCHAR(255),
    IN p_image_type ENUM('avatar', 'recipe', 'locale_icon')
)
BEGIN
    DECLARE path_exists INT;
    
    -- Check if the image path already exists
    SELECT COUNT(*) INTO path_exists
    FROM image
    WHERE image_path = p_image_path;
    
    IF path_exists = 0 THEN
        INSERT INTO image (image_path, image_type)
        VALUES (p_image_path, p_image_type);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Image path already exists';
    END IF;
END$$

CREATE PROCEDURE create_locale(
    IN p_locale_code VARCHAR(10),
    IN p_locale_name VARCHAR(50),
    IN p_icon_image_id INT
)
BEGIN
    DECLARE code_exists INT;
    
    -- Check if the locale code already exists
    SELECT COUNT(*) INTO code_exists
    FROM locale
    WHERE locale_code = p_locale_code;
    
    IF code_exists = 0 THEN
        INSERT INTO locale (locale_code, locale_name, icon_image_id)
        VALUES (p_locale_code, p_locale_name, p_icon_image_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Locale code already exists';
    END IF;
END$$

CREATE PROCEDURE create_responsibility(
    IN p_responsibility_name VARCHAR(100)
)
BEGIN
    DECLARE name_exists INT;
    
    -- Check if the responsibility name already exists
    SELECT COUNT(*) INTO name_exists
    FROM responsibility
    WHERE responsibility_name = p_responsibility_name;
    
    IF name_exists = 0 THEN
        INSERT INTO responsibility (responsibility_name)
        VALUES (p_responsibility_name);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Responsibility name already exists';
    END IF;
END$$

CREATE PROCEDURE create_status(
    IN p_status_name VARCHAR(50)
)
BEGIN
    DECLARE name_exists INT;
    
    -- Check if the status name already exists
    SELECT COUNT(*) INTO name_exists
    FROM status
    WHERE status_name = p_status_name;
    
    IF name_exists = 0 THEN
        INSERT INTO status (status_name)
        VALUES (p_status_name);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Status name already exists';
    END IF;
END$$

CREATE PROCEDURE create_ingredient(
    IN p_default_name VARCHAR(255)
)
BEGIN
    DECLARE name_exists INT;
    
    -- Check if the ingredient name already exists
    SELECT COUNT(*) INTO name_exists
    FROM ingredient
    WHERE default_name = p_default_name;
    
    IF name_exists = 0 THEN
        INSERT INTO ingredient (default_name)
        VALUES (p_default_name);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ingredient name already exists';
    END IF;
END$$

CREATE PROCEDURE create_tag(
    IN p_tag_name VARCHAR(255)
)
BEGIN
    DECLARE name_exists INT;
    
    -- Check if the tag name already exists
    SELECT COUNT(*) INTO name_exists
    FROM tag
    WHERE tag_name = p_tag_name;
    
    IF name_exists = 0 THEN
        INSERT INTO tag (tag_name)
        VALUES (p_tag_name);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tag name already exists';
    END IF;
END$$

CREATE PROCEDURE create_recipe(
    IN p_author_id INT,
    IN p_image_id INT,
    IN p_cook_time INT UNSIGNED,
    IN p_difficulty_level TINYINT,
    IN p_nutritional_information TEXT,
    IN p_source VARCHAR(255),
    IN p_video_url VARCHAR(255),
    IN p_status_id INT
)
BEGIN
    INSERT INTO recipe (author_id, image_id, cook_time, difficulty_level, nutritional_information, source, video_url, status_id)
    VALUES (p_author_id, p_image_id, p_cook_time, p_difficulty_level, p_nutritional_information, p_source, p_video_url, p_status_id);
END$$

CREATE PROCEDURE create_comment(
    IN p_person_id INT,
    IN p_recipe_id INT,
    IN p_comment TEXT
)
BEGIN
    INSERT INTO comment (person_id, recipe_id, comment)
    VALUES (p_person_id, p_recipe_id, p_comment);
END$$

CREATE PROCEDURE create_comment_like(
    IN p_person_id INT,
    IN p_comment_id INT
)
BEGIN
    INSERT INTO comment_like(person_id, comment_id)
    VALUES (p_person_id, p_comment_id);
END$$

CREATE PROCEDURE create_favorite(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    INSERT INTO favorite(person_id, recipe_id)
    VALUES (p_person_id, p_recipe_id);
END$$

CREATE PROCEDURE create_recipe_tag(
    IN p_recipe_id INT,
    IN p_tag_id INT
)
BEGIN
    INSERT INTO recipe_tag(recipe_id, tag_id)
    VALUES (p_recipe_id, p_tag_id);
END$$

CREATE PROCEDURE create_recipe_rating(
    IN p_person_id INT,
    IN p_recipe_id INT,
    IN p_rating TINYINT
)
BEGIN
    INSERT INTO recipe_rating(person_id, recipe_id, rating)
    VALUES (p_person_id, p_recipe_id, p_rating);
END$$

DELIMITER ;
