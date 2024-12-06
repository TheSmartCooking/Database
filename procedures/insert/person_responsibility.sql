-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_person_responsibility(
    IN p_person_id INT,
    IN p_responsibility_id INT
)
BEGIN
    INSERT INTO person_responsibility (person_id, responsibility_id)
    VALUES (p_person_id, p_responsibility_id);
END //

DELIMITER ;
