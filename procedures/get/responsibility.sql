-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_responsibilities()
BEGIN
    SELECT * FROM responsibility;
END //

CREATE OR REPLACE PROCEDURE get_responsibilities_analitycs()
BEGIN
    SELECT
        r.responsibility_id,
        r.responsibility_name,
        (SELECT COUNT(*) FROM person_responsibility pr WHERE pr.responsibility_id = r.responsibility_id) AS total_persons
    FROM responsibility r;
END //

DELIMITER ;
