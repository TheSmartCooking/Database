-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_person_responsibilities()
BEGIN
    SELECT * FROM person_responsibility;
END //

CREATE OR REPLACE PROCEDURE get_person_responsibilities(IN p_person_id INT)
BEGIN
    SELECT r.responsibility_id, r.responsibility_name
    FROM responsibility r
    JOIN person_responsibility pr ON r.responsibility_id = pr.responsibility_id
    WHERE pr.person_id = p_person_id;
END //

DELIMITER ;
