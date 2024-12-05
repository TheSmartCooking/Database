-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_ingredients()
BEGIN
    SELECT * FROM ingredient;
END //

DELIMITER ;
