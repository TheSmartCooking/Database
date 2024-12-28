-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_responsibility(
    IN p_responsibility_name VARCHAR(100),
    IN p_responsibility_description TEXT
)
BEGIN
    INSERT INTO responsibility (responsibility_name, responsibility_description)
    VALUES (p_responsibility_name, p_responsibility_description);
END //

DELIMITER ;
