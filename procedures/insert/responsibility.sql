-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_responsibility(
    IN p_responsibility_name VARCHAR(100)
)
BEGIN
    INSERT INTO responsibility (responsibility_name)
    VALUES (p_responsibility_name);
END //

DELIMITER ;
