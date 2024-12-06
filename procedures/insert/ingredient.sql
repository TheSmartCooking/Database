-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_ingredient(
    IN p_default_name VARCHAR(255),
)
BEGIN
    INSERT INTO ingredient (default_name)
    VALUES (p_default_name);
END //

DELIMITER ;
