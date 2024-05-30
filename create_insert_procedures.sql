DROP PROCEDURE IF EXISTS create_person;
DROP PROCEDURE IF EXISTS create_image;
DROP PROCEDURE IF EXISTS create_locale;
DROP PROCEDURE IF EXISTS create_responsibility;
DROP PROCEDURE IF EXISTS create_status;
DROP PROCEDURE IF EXISTS create_ingredient;
DROP PROCEDURE IF EXISTS create_tag;

DELIMITER $$

CREATE PROCEDURE create_person (
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_password VARBINARY(60),
    IN p_salt VARBINARY(16)
)
BEGIN
    DECLARE email_exists INT;
    
    -- Check if the email already exists
    SELECT COUNT(*) INTO email_exists
    FROM person
    WHERE email = p_email;
    
    IF email_exists = 0 THEN
        INSERT INTO person (name, email, password, salt)
        VALUES (p_name, p_email, p_password, p_salt);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email already exists';
    END IF;
END$$

DELIMITER ;

CREATE PROCEDURE create_image (
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

CREATE PROCEDURE create_locale (
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

CREATE PROCEDURE create_responsibility (
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

CREATE PROCEDURE create_status (
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

CREATE PROCEDURE create_ingredient (
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

CREATE PROCEDURE create_tag (
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

DELIMITER ;
