-- Use the database
USE smartcooking;

DELIMITER //

CREATE PROCEDURE get_person_profile(IN p_person_id INT)
BEGIN
    CALL get_person_by_id(p_person_id);
    CALL get_person_avatar(p_person_id);
END //

DELIMITER ;
