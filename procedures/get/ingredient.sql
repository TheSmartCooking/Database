-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE get_all_ingredients()
BEGIN
    SELECT * FROM ingredient;
END //

DELIMITER ;
