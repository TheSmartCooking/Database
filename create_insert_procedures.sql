-- Use the database
USE smartcooking;

DELIMITER $$

CREATE OR REPLACE PROCEDURE create_person(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100),
    IN p_salt VARBINARY(16),
    IN p_locale_code VARCHAR(10)
)
BEGIN
    DECLARE v_email_exists INT;
    DECLARE v_new_person_id INT;

    -- Check if the email already exists
    SELECT COUNT(*) INTO v_email_exists
    FROM person
    WHERE email = p_email;
    
    IF v_email_exists = 0 THEN
        INSERT INTO person (name, email, password, salt)
        VALUES (p_name, p_email, p_password, p_salt);
        
        SET v_new_person_id = LAST_INSERT_ID();
        
        IF p_locale_code IS NOT NULL THEN
            CALL update_person_locale(v_new_person_id, p_locale_code);
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email already exists';
    END IF;
END$$

CREATE OR REPLACE PROCEDURE create_image(
    IN p_image_path VARCHAR(255),
    IN p_image_type ENUM('avatar', 'recipe', 'locale_icon')
)
BEGIN
    DECLARE v_path_exists INT;
    
    -- Check if the image path already exists
    SELECT COUNT(*) INTO v_path_exists
    FROM image
    WHERE image_path = p_image_path;
    
    IF v_path_exists = 0 THEN
        INSERT INTO image (image_path, image_type)
        VALUES (p_image_path, p_image_type);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Image path already exists';
    END IF;
END$$

CREATE OR REPLACE PROCEDURE create_locale(
    IN p_locale_code VARCHAR(10),
    IN p_locale_name VARCHAR(50),
    IN p_icon_image_id INT
)
BEGIN
    DECLARE v_code_exists INT;
    
    -- Check if the locale code already exists
    SELECT COUNT(*) INTO v_code_exists
    FROM locale
    WHERE locale_code = p_locale_code;
    
    IF v_code_exists = 0 THEN
        INSERT INTO locale (locale_code, locale_name, icon_image_id)
        VALUES (p_locale_code, p_locale_name, p_icon_image_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Locale code already exists';
    END IF;
END$$

CREATE OR REPLACE PROCEDURE create_responsibility(
    IN p_responsibility_name VARCHAR(100)
)
BEGIN
    DECLARE v_name_exists INT;
    
    -- Check if the responsibility name already exists
    SELECT COUNT(*) INTO v_name_exists
    FROM responsibility
    WHERE responsibility_name = p_responsibility_name;
    
    IF v_name_exists = 0 THEN
        INSERT INTO responsibility (responsibility_name)
        VALUES (p_responsibility_name);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Responsibility name already exists';
    END IF;
END$$

CREATE OR REPLACE PROCEDURE create_status(
    IN p_status_name VARCHAR(50)
)
BEGIN
    DECLARE v_name_exists INT;
    
    -- Check if the status name already exists
    SELECT COUNT(*) INTO v_name_exists
    FROM status
    WHERE status_name = p_status_name;
    
    IF v_name_exists = 0 THEN
        INSERT INTO status (status_name)
        VALUES (p_status_name);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Status name already exists';
    END IF;
END$$

CREATE OR REPLACE PROCEDURE create_ingredient(
    IN p_default_name VARCHAR(255)
)
BEGIN
    DECLARE v_name_exists INT;
    
    -- Check if the ingredient name already exists
    SELECT COUNT(*) INTO v_name_exists
    FROM ingredient
    WHERE default_name = p_default_name;
    
    IF v_name_exists = 0 THEN
        INSERT INTO ingredient (default_name)
        VALUES (p_default_name);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ingredient name already exists';
    END IF;
END$$

CREATE OR REPLACE PROCEDURE create_tag(
    IN p_tag_name VARCHAR(255)
)
BEGIN
    DECLARE v_name_exists INT;
    
    -- Check if the tag name already exists
    SELECT COUNT(*) INTO v_name_exists
    FROM tag
    WHERE tag_name = p_tag_name;
    
    IF v_name_exists = 0 THEN
        INSERT INTO tag (tag_name)
        VALUES (p_tag_name);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tag name already exists';
    END IF;
END$$

CREATE OR REPLACE PROCEDURE create_recipe(
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

CREATE OR REPLACE PROCEDURE create_comment(
    IN p_person_id INT,
    IN p_recipe_id INT,
    IN p_comment TEXT
)
BEGIN
    INSERT INTO comment (person_id, recipe_id, comment)
    VALUES (p_person_id, p_recipe_id, p_comment);
END$$

CREATE OR REPLACE PROCEDURE create_comment_like(
    IN p_person_id INT,
    IN p_comment_id INT
)
BEGIN
    INSERT INTO comment_like(person_id, comment_id)
    VALUES (p_person_id, p_comment_id);
END$$

CREATE OR REPLACE PROCEDURE create_favorite(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    DECLARE v_favorite_exists INT;

    -- Check if the favorite already exists
    SELECT COUNT(*)
    INTO v_favorite_exists
    FROM favorite
    WHERE person_id = p_person_id AND recipe_id = p_recipe_id;

    -- If the favorite does not exist, insert it
    IF v_favorite_exists = 0 THEN
        INSERT INTO favorite(person_id, recipe_id)
        VALUES (p_person_id, p_recipe_id);
    END IF;
END$$

CREATE OR REPLACE PROCEDURE create_recipe_tag(
    IN p_recipe_id INT,
    IN p_tag_id INT
)
BEGIN
    INSERT INTO recipe_tag(recipe_id, tag_id)
    VALUES (p_recipe_id, p_tag_id);
END$$

CREATE OR REPLACE PROCEDURE create_recipe_rating(
    IN p_person_id INT,
    IN p_recipe_id INT,
    IN p_rating TINYINT
)
BEGIN
    INSERT INTO recipe_rating(person_id, recipe_id, rating)
    VALUES (p_person_id, p_recipe_id, p_rating);
END$$

DELIMITER ;
