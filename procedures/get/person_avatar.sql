-- Use the database
USE smartcooking;

DELIMITER //

CREATE PROCEDURE get_all_person_avatars()
BEGIN
    SELECT * FROM person_avatar;
END //

CREATE PROCEDURE get_person_avatar(IN p_person_id INT)
BEGIN
    SELECT avatar_picture_id FROM person_avatar
    WHERE person_id = p_person_id;
END //

CREATE OR REPLACE PROCEDURE get_avatar_usage_statistics()
BEGIN
    SELECT
        pa.avatar_picture_id,
        (SELECT COUNT(p.person_id) FROM person p WHERE p.person_id = pa.person_id) AS user_count
    FROM person_avatar pa;
END //

DELIMITER ;
