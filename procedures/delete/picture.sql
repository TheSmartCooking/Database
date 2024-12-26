-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_picture(
    IN p_picture_id INT
)
BEGIN
    DELETE FROM picture
    WHERE picture_id = p_picture_id;
END //

DELIMITER ;
