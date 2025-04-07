-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_categories()
BEGIN
    SELECT * FROM category;
END //

CREATE OR REPLACE PROCEDURE get_category_by_name(
    IN p_category_name VARCHAR(255)
)
BEGIN
    DECLARE v_safe_category_name VARCHAR(255);
    SET v_safe_category_name = sanitize_string(p_category_name);

    SELECT * FROM category WHERE category_name LIKE v_safe_category_name;
END //

DELIMITER ;
