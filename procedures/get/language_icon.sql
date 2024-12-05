-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE PROCEDURE get_all_language_icons()
BEGIN
    SELECT * FROM language_icon;
END //

CREATE PROCEDURE get_language_icon(IN p_language_id INT)
BEGIN
    SELECT language_icon_id FROM language_icon
    WHERE language_id = p_language_id;
END //

DELIMITER ;
