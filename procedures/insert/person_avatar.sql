-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_person_avatar(
    IN p_person_id INT,
    IN p_avatar_picture_id INT
)
BEGIN
    INSERT INTO person_avatar (person_id, avatar_picture_id)
    VALUES (p_person_id, p_avatar_picture_id);
END //

DELIMITER ;
