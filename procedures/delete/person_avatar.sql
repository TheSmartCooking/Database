-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_person_avatar(
    IN p_person_id INT
)
BEGIN
    DELETE FROM person_avatar
    WHERE person_id = p_person_id;
END //

DELIMITER ;
