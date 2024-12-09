-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_picture (
    IN p_picture_path VARCHAR(65),
    IN p_author_id INT,
    IN p_picture_type ENUM('avatar', 'recipe', 'language_icon')
)
BEGIN
    INSERT INTO picture (picture_path, author_id, picture_type)
    VALUES (p_picture_path, p_author_id, p_picture_type);
END //

CREATE OR REPLACE PROCEDURE insert_picture_avatar (
    IN p_picture_path VARCHAR(65),
    IN p_author_id INT
)
BEGIN
    CALL insert_picture(p_picture_path, p_author_id, 'avatar');
END //

CREATE OR REPLACE PROCEDURE insert_picture_language_icon (
    IN p_picture_path VARCHAR(65),
    IN p_author_id INT
)
BEGIN
    CALL insert_picture(p_picture_path, p_author_id, 'language_icon');
END //

CREATE OR REPLACE PROCEDURE insert_picture_recipe_picture (
    IN p_picture_path VARCHAR(65),
    IN p_author_id INT
)
BEGIN
    CALL insert_picture(p_picture_path, p_author_id, 'recipe');
END //

DELIMITER ;
