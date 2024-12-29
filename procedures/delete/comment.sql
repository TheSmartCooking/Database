-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_comment(
    IN p_comment_id INT
)
BEGIN
    DELETE FROM comment
    WHERE comment_id = p_comment_id;
END //

DELIMITER ;
