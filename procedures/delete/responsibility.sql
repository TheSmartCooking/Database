-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_responsibility(
    IN p_responsibility_id INT
)
BEGIN
    DELETE FROM responsibility
    WHERE responsibility_id = p_responsibility_id;
END //

DELIMITER ;
