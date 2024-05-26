DROP PROCEDURE IF EXISTS get_paginated_recipes;

DELIMITER $$

CREATE PROCEDURE get_paginated_recipes(
    IN p_locale_code VARCHAR(10),
    IN p_status_name VARCHAR(50),
    IN p_page INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT;
    SET v_offset = (p_page - 1) * p_page_size;

    SELECT 
        r.recipe_id,
        rt.title,
        r.cook_time,
        r.difficulty_level,
        r.rating,
        i.image_path AS image
    FROM 
        recipe r
    INNER JOIN 
        recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN 
        locale l ON rt.locale_id = l.locale_id
    INNER JOIN 
        status s ON r.status_id = s.status_id
    LEFT JOIN 
        image i ON r.image_id = i.image_id
    WHERE 
        l.locale_code = p_locale_code
        AND s.status_name = p_status_name
    LIMIT 
        v_offset, p_page_size;
END$$
    
DELIMITER ;
