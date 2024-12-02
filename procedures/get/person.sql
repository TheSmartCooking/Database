-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE get_all_persons()
BEGIN
    SELECT person_id, person_name, locale_id
    FROM person;
END //

CREATE OR REPLACE PROCEDURE get_person_by_id(IN p_person_id INT)
BEGIN
    SELECT person_id, person_name, locale_id
    FROM person
    WHERE person_id = p_person_id;
END //

CREATE OR REPLACE PROCEDURE get_person_by_email(IN p_email VARCHAR(100))
BEGIN
    SELECT person_id, person_name, locale_id
    FROM person
    WHERE email = p_email;
END //

CREATE OR REPLACE PROCEDURE get_person_activity_summary(IN p_person_id INT)
BEGIN
    SELECT 
        p.person_id,
        p.name,
        p.email,
        (SELECT COUNT(*) FROM comment c WHERE c.person_id = p.person_id) AS total_comments,
        (SELECT COUNT(*) 
         FROM comment_like cl 
         JOIN comment c ON cl.comment_id = c.comment_id 
         WHERE c.person_id = p.person_id) AS total_comment_likes_received
    FROM person p
    WHERE p.person_id = p_person_id;
END //

CREATE OR REPLACE PROCEDURE get_recent_persons(IN p_start_date TIMESTAMP, IN p_end_date TIMESTAMP)
BEGIN
    SELECT person_id, person_name, registration_date
    FROM person
    WHERE registration_date BETWEEN p_start_date AND p_end_date;
END //

CREATE OR REPLACE PROCEDURE get_persons_by_locale(IN p_locale_id INT)
BEGIN
    SELECT person_id, person_name
    FROM person
    WHERE locale_id = p_locale_id;
END //

CREATE OR REPLACE PROCEDURE get_person_recipe_engagement(IN p_person_id INT)
BEGIN
    SELECT re.recipe_id, re.engagement_type, re.engagement_date
    FROM recipe_engagement re
    WHERE re.person_id = p_person_id;
END //

DELIMITER ;
