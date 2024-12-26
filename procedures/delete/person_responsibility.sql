-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_person_responsibility(
    IN p_person_id INT,
    IN p_responsibility_id INT
)
BEGIN
    DELETE FROM person_responsibility
    WHERE person_id = p_person_id AND responsibility_id = p_responsibility_id;
END //

DELIMITER ;
