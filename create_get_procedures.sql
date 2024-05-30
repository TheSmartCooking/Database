DROP PROCEDURE IF EXISTS get_paginated_recipes;
DROP PROCEDURE IF EXISTS get_person_by_id;
DROP PROCEDURE IF EXISTS get_recipe_by_id;
DROP PROCEDURE IF EXISTS get_ingredient_by_id;
DROP PROCEDURE IF EXISTS get_comments_by_recipe_id;
DROP PROCEDURE IF EXISTS get_tag_by_id;

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

CREATE PROCEDURE get_person_by_id(
    IN p_person_id INT
)
BEGIN
    SELECT 
        p.person_id,
        p.name,
        p.email,
        p.registration_date,
        p.last_login,
        i.image_path AS avatar,
        l.locale_code,
        l.locale_name
    FROM 
        person p
    LEFT JOIN 
        image i ON p.avatar_image_id = i.image_id
    LEFT JOIN 
        locale l ON p.locale_id = l.locale_id
    WHERE 
        p.person_id = p_person_id;
END$$

CREATE PROCEDURE get_recipe_by_id(
    IN p_recipe_id INT
)
BEGIN
    SELECT 
        r.recipe_id,
        r.author_id,
        r.publication_date,
        r.modification_date,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.nutritional_information,
        r.source,
        r.video_url,
        s.status_name,
        i.image_path,
        rt.title,
        rt.description,
        rt.preparation,
        p.person_id AS author_id,
        p.name AS author_name
    FROM 
        recipe r
    LEFT JOIN 
        status s ON r.status_id = s.status_id
    LEFT JOIN 
        image i ON r.image_id = i.image_id
    LEFT JOIN 
        recipe_translation rt ON r.recipe_id = rt.recipe_id
    LEFT JOIN 
        person p ON r.author_id = p.person_id
    WHERE 
        r.recipe_id = p_recipe_id;
END$$

CREATE PROCEDURE get_ingredient_by_id(
    IN p_ingredient_id INT
)
BEGIN
    SELECT 
        i.ingredient_id,
        i.default_name,
        it.translated_name,
        l.locale_code,
        l.locale_name
    FROM 
        ingredient i
    LEFT JOIN 
        ingredient_translation it ON i.ingredient_id = it.ingredient_id
    LEFT JOIN 
        locale l ON it.locale_id = l.locale_id
    WHERE 
        i.ingredient_id = p_ingredient_id;
END$$

CREATE PROCEDURE get_comments_by_recipe_id(
    IN p_recipe_id INT,
    IN p_page INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT;
    SET v_offset = (p_page - 1) * p_page_size;

    SELECT 
        c.comment_id,
        c.comment,
        c.comment_date,
        p.person_id,
        p.name AS person_name,
        r.recipe_id,
        rt.title AS recipe_title
    FROM 
        comment c
    LEFT JOIN 
        person p ON c.person_id = p.person_id
    LEFT JOIN 
        recipe r ON c.recipe_id = r.recipe_id
    LEFT JOIN 
        recipe_translation rt ON r.recipe_id = rt.recipe_id
    WHERE 
        c.recipe_id = p_recipe_id
    LIMIT 
        v_offset, p_page_size;
END$$

CREATE PROCEDURE get_tag_by_id(
    IN p_tag_id INT
)
BEGIN
    SELECT 
        t.tag_id,
        t.tag_name
    FROM 
        tag t
    WHERE 
        t.tag_id = p_tag_id;
END$$

DELIMITER ;
