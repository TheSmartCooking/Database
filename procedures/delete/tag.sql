-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_tag(
    IN p_tag_id INT
)
BEGIN
    DELETE FROM tag
    WHERE tag_id = p_tag_id;
END //

DELIMITER ;
