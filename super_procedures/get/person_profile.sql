-- Use the database
USE smartcooking;

DELIMITER //

CREATE PROCEDURE get_person_profile(IN p_person_id INT)
BEGIN
    -- Retrieve person data
    SELECT * 
    FROM person
    WHERE person_id = p_person_id;

    -- Retrieve associated avatar picture
    SELECT avatar_picture_id 
    FROM person_avatar
    WHERE person_id = p_person_id;
END //

DELIMITER ;
