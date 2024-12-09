-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_tag(
    IN p_tag_name VARCHAR(25)
)
BEGIN
    INSERT INTO tag (tag_name)
    VALUES (p_tag_name);
END //

DELIMITER ;
