-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE get_recipe_status(
    IN p_status_id INT
)
BEGIN
    SELECT status_name
    FROM recipe_status
    WHERE status_id = p_status_id;
END //

CREATE OR REPLACE PROCEDURE get_recipe_status_by_name(
    IN p_status_name VARCHAR(25)
)
BEGIN
    SELECT status_id
    FROM recipe_status
    WHERE status_name = p_status_name;
END //

DELIMITER ;
