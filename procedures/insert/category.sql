-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_category(
    IN p_name VARCHAR(255)
)
BEGIN
    INSERT INTO category (category_name)
    VALUES (p_name);
END //

DELIMITER ;
