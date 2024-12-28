-- Use the database
USE smartcooking;

DELIMITER //

CREATE FUNCTION get_recipe_title(p_recipe_id INT, p_language_iso_code CHAR(2))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE v_title VARCHAR(255);
    SELECT rt.title
    INTO v_title
    FROM recipe_translation rt
    INNER JOIN lang l ON rt.language_id = l.language_id
    WHERE rt.recipe_id = p_recipe_id
      AND l.language_iso_code = p_language_iso_code;
    RETURN v_title;
END //

DELIMITER ;
