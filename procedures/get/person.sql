-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_persons()
BEGIN
    SELECT
        person_id,
        person_name,
        language_id,
        encrypted_email
    FROM person;
END //

CREATE OR REPLACE PROCEDURE get_person_by_id(IN p_person_id INT)
BEGIN
    SELECT
        person_id,
        person_name,
        language_id,
        encrypted_email
    FROM person
    WHERE person_id = p_person_id;
END //

CREATE OR REPLACE PROCEDURE get_person_by_email(IN p_hashed_email VARCHAR(100))
BEGIN
    SELECT person_id, person_name, language_id
    FROM person
    WHERE hashed_email = p_hashed_email;
END //

CREATE OR REPLACE PROCEDURE get_person_activity_summary(IN p_person_id INT)
BEGIN
    SELECT
        p.person_id,
        p.name,
        p.encrypted_email,
        (SELECT COUNT(*) FROM comment c WHERE c.person_id = p.person_id) AS total_comments,
        (SELECT COUNT(*)
         FROM comment_like cl
         INNER JOIN comment c ON cl.comment_id = c.comment_id
         WHERE c.person_id = p.person_id) AS total_comment_likes_received
    FROM person p
    WHERE p.person_id = p_person_id;
END //

DELIMITER ;
