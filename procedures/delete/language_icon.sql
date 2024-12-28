-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_language_icon(
    IN p_language_id INT
)
BEGIN
    DELETE FROM language_icon
    WHERE language_id = p_language_id;
END //

DELIMITER ;
