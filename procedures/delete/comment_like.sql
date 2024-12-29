-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_comment_like(
    IN p_comment_id INT,
    IN p_person_id INT
)
BEGIN
    DELETE FROM comment_like
    WHERE comment_id = p_comment_id AND person_id = p_person_id;
END //

DELIMITER ;
