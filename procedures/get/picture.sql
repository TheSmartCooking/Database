-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE get_all_pictures()
BEGIN
    SELECT * FROM picture;
END //

CREATE OR REPLACE PROCEDURE get_picture_by_id(IN p_picture_id INT)
BEGIN
    SELECT * FROM picture
    WHERE picture_id = p_picture_id;
END //

CREATE OR REPLACE PROCEDURE get_pictures_by_author(IN p_author_id INT)
BEGIN
    SELECT * FROM picture
    WHERE author_id = p_author_id;
END //

CREATE OR REPLACE PROCEDURE get_pictures_by_type(IN p_picture_type ENUM('avatar', 'recipe', 'language_icon'))
BEGIN
    SELECT * FROM picture
    WHERE picture_type = p_picture_type;
END //

DELIMITER ;
