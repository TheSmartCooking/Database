-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_person(
    IN p_person_id INT
)
BEGIN
    DELETE FROM person
    WHERE person_id = p_person_id;
END //


DELIMITER ;
