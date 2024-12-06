-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_comment_like(
    IN p_comment_id INT,
    IN p_person_id INT
)
BEGIN
    INSERT INTO comment_like (comment_id, person_id)
    VALUES (p_comment_id, p_person_id);
END //

DELIMITER ;
