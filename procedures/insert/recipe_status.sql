-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe_status(
    IN p_status_name VARCHAR(25)
)
BEGIN
    INSERT INTO recipe_status (status_name) VALUES (p_status_name);
END //

DELIMITER ;
