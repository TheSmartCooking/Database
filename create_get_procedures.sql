DROP PROCEDURE IF EXISTS get_paginated_recipes;
DROP PROCEDURE IF EXISTS get_person_by_id;
DROP PROCEDURE IF EXISTS get_recipe_by_id;
DROP PROCEDURE IF EXISTS get_comments_by_recipe_id;
DROP PROCEDURE IF EXISTS get_paginated_tags;
DROP PROCEDURE IF EXISTS get_tags_by_recipe_id;
DROP PROCEDURE IF EXISTS get_recipes_by_author;
DROP PROCEDURE IF EXISTS get_comments_by_person;
DROP PROCEDURE IF EXISTS get_recipes_by_tags;
DROP PROCEDURE IF EXISTS get_recipe_ingredients_by_recipe_id;
DROP PROCEDURE IF EXISTS get_recipe_translations_by_recipe_id;
DROP PROCEDURE IF EXISTS get_all_locales;
DROP PROCEDURE IF EXISTS get_all_statuses;
DROP PROCEDURE IF EXISTS get_favorites_by_person_id;
DROP PROCEDURE IF EXISTS get_ratings_by_recipe_id;
DROP PROCEDURE IF EXISTS get_recipe_ids_by_ingredient;
DROP PROCEDURE IF EXISTS get_recipes_by_newness;
DROP PROCEDURE IF EXISTS get_recipes_by_popularity;
DROP PROCEDURE IF EXISTS get_recipe_count_by_tag;
DROP PROCEDURE IF EXISTS get_recipe_count_by_author;
DROP PROCEDURE IF EXISTS get_recipes_by_status;
DROP PROCEDURE IF EXISTS get_person_responsibilities_by_person_id;
DROP PROCEDURE IF EXISTS get_ingredient_translations_by_ingredient_id;
DROP PROCEDURE IF EXISTS get_person_settings_by_person_id;
DROP PROCEDURE IF EXISTS get_images_by_type;
DROP PROCEDURE IF EXISTS get_responsibilities;

DELIMITER $$

CREATE PROCEDURE get_paginated_recipes(
    IN p_locale_code VARCHAR(10),
    IN p_status_name VARCHAR(50),
    IN p_page INT,
    IN p_page_size INT,
    IN p_sort_by VARCHAR(20),
    IN p_tag_ids VARCHAR(255)
)
BEGIN
    DECLARE v_offset INT DEFAULT (p_page - 1) * p_page_size;

    -- Conditional logic to call appropriate procedure based on sorting criteria
    IF p_sort_by = 'most_recent' THEN
        CALL get_recipes_by_newness(p_locale_code, p_status_name, v_offset, p_page_size);
    ELSEIF p_sort_by = 'most_popular' THEN
        CALL get_recipes_by_popularity(p_locale_code, p_status_name, v_offset, p_page_size);
    ELSEIF p_sort_by = 'by_tags' THEN
        CALL get_recipes_by_tags(p_tag_ids, p_locale_code, p_status_name, v_offset, p_page_size);
    ELSE
        SELECT 
            r.recipe_id,
            rt.title,
            r.cook_time,
            r.difficulty_level,
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
    END IF;
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
        l.locale_name,
        GROUP_CONCAT(r.responsibility_name) AS responsibilities
    FROM 
        person p
    LEFT JOIN 
        image i ON p.avatar_image_id = i.image_id
    LEFT JOIN 
        locale l ON p.locale_id = l.locale_id
    LEFT JOIN 
        person_responsibility pr ON p.person_id = pr.person_id
    LEFT JOIN 
        responsibility r ON pr.responsibility_id = r.responsibility_id
    WHERE 
        p.person_id = p_person_id
    GROUP BY 
        p.person_id;
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

CREATE PROCEDURE get_comments_by_recipe_id(
    IN p_recipe_id INT,
    IN p_page INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT DEFAULT (p_page - 1) * p_page_size;

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

CREATE PROCEDURE get_paginated_tags(
    IN p_page INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT DEFAULT (p_page - 1) * p_page_size;

    SELECT 
        t.tag_id,
        t.tag_name
    FROM 
        tag t
    LIMIT 
        v_offset, p_page_size;
END$$

CREATE PROCEDURE get_tags_by_recipe_id(
    IN p_recipe_id INT
)
BEGIN
    SELECT 
        t.tag_id,
        t.tag_name
    FROM 
        tag t
    INNER JOIN 
        recipe_tag rt ON t.tag_id = rt.tag_id
    WHERE 
        rt.recipe_id = p_recipe_id;
END$$

CREATE PROCEDURE get_recipes_by_author(
    IN p_author_id INT,
    IN p_page INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT DEFAULT (p_page - 1) * p_page_size;

    SELECT 
        r.recipe_id,
        rt.title,
        r.cook_time,
        r.difficulty_level,
        i.image_path AS image
    FROM 
        recipe r
    LEFT JOIN 
        recipe_translation rt ON r.recipe_id = rt.recipe_id
    LEFT JOIN 
        image i ON r.image_id = i.image_id
    WHERE 
        r.author_id = p_author_id
    LIMIT 
        v_offset, p_page_size;
END$$

CREATE PROCEDURE get_comments_by_person(
    IN p_person_id INT,
    IN p_page INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT DEFAULT (p_page - 1) * p_page_size;

    SELECT 
        c.comment_id,
        c.comment,
        c.comment_date,
        r.recipe_id,
        rt.title AS recipe_title
    FROM 
        comment c
    LEFT JOIN 
        recipe r ON c.recipe_id = r.recipe_id
    LEFT JOIN 
        recipe_translation rt ON r.recipe_id = rt.recipe_id
    WHERE 
        c.person_id = p_person_id
    LIMIT 
        v_offset, p_page_size;
END$$

CREATE PROCEDURE get_recipes_by_tags(
    IN p_tag_ids VARCHAR(255),
    IN p_locale_code VARCHAR(10),
    IN p_status_name VARCHAR(50),
    IN p_offset INT,
    IN p_page_size INT
)
BEGIN
    SET @query = CONCAT(
        'SELECT r.recipe_id, rt.title, r.cook_time, r.difficulty_level, i.image_path AS image ',
        'FROM recipe r ',
        'INNER JOIN recipe_tag rtg ON r.recipe_id = rtg.recipe_id ',
        'INNER JOIN tag t ON t.tag_id = rtg.tag_id ',
        'LEFT JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id ',
        'LEFT JOIN image i ON r.image_id = i.image_id ',
        'INNER JOIN locale l ON rt.locale_id = l.locale_id ',
        'INNER JOIN status s ON r.status_id = s.status_id ',
        'WHERE t.tag_id IN (', p_tag_ids, ') ',
        'AND l.locale_code = \'', p_locale_code, '\' ',
        'AND s.status_name = \'', p_status_name, '\' ',
        'LIMIT ', p_offset, ', ', p_page_size
    );
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE PROCEDURE get_recipes_by_newness(
    IN p_locale_code VARCHAR(10),
    IN p_status_name VARCHAR(50),
    IN p_offset INT,
    IN p_page_size INT
)
BEGIN
    SELECT 
        r.recipe_id,
        rt.title,
        r.cook_time,
        r.difficulty_level,
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
    ORDER BY 
        r.publication_date DESC
    LIMIT 
        p_offset, p_page_size;
END$$

CREATE PROCEDURE get_recipes_by_popularity(
    IN p_locale_code VARCHAR(10),
    IN p_status_name VARCHAR(50),
    IN p_offset INT,
    IN p_page_size INT
)
BEGIN
    SELECT 
        r.recipe_id,
        rt.title,
        r.cook_time,
        r.difficulty_level,
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
    ORDER BY 
        r.number_of_reviews DESC
    LIMIT 
        p_offset, p_page_size;
END$$

CREATE PROCEDURE get_recipe_ingredients_by_recipe_id(
    IN p_recipe_id INT
)
BEGIN
    SELECT 
        ri.ingredient_id,
        i.default_name,
        ri.quantity,
        ri.unit
    FROM 
        recipe_ingredient ri
    INNER JOIN 
        ingredient i ON ri.ingredient_id = i.ingredient_id
    WHERE 
        ri.recipe_id = p_recipe_id;
END$$

CREATE PROCEDURE get_recipe_translations_by_recipe_id(
    IN p_recipe_id INT
)
BEGIN
    SELECT 
        rt.locale_id,
        l.locale_code,
        l.locale_name,
        rt.title,
        rt.description,
        rt.preparation
    FROM 
        recipe_translation rt
    INNER JOIN 
        locale l ON rt.locale_id = l.locale_id
    WHERE 
        rt.recipe_id = p_recipe_id;
END$$

CREATE PROCEDURE get_all_locales()
BEGIN
    SELECT 
        l.locale_id,
        l.locale_code,
        l.locale_name,
        i.image_path AS icon
    FROM 
        locale l
    LEFT JOIN 
        image i ON l.icon_image_id = i.image_id;
END$$

CREATE PROCEDURE get_all_statuses()
BEGIN
    SELECT 
        status_id,
        status_name
    FROM 
        status;
END$$

CREATE PROCEDURE get_favorites_by_person_id(
    IN p_person_id INT
)
BEGIN
    SELECT 
        f.favorite_id,
        r.recipe_id,
        rt.title,
        r.cook_time,
        r.difficulty_level,
        i.image_path AS image,
        f.favorited_date
    FROM 
        favorite f
    INNER JOIN 
        recipe r ON f.recipe_id = r.recipe_id
    LEFT JOIN 
        recipe_translation rt ON r.recipe_id = rt.recipe_id
    LEFT JOIN 
        image i ON r.image_id = i.image_id
    WHERE 
        f.person_id = p_person_id;
END$$

CREATE PROCEDURE get_ratings_by_recipe_id(
    IN p_recipe_id INT
)
BEGIN
    SELECT 
        rr.rating_id,
        rr.person_id,
        rr.rating,
        p.name AS person_name
    FROM 
        recipe_rating rr
    INNER JOIN 
        person p ON rr.person_id = p.person_id
    WHERE 
        rr.recipe_id = p_recipe_id;
END$$

CREATE PROCEDURE get_recipe_ids_by_ingredient(
    IN p_ingredient_ids VARCHAR(255)
)
BEGIN
    SET @query = CONCAT(
        'SELECT DISTINCT ri.recipe_id ',
        'FROM recipe_ingredient ri ',
        'WHERE ri.ingredient_id IN (', p_ingredient_ids, ')'
    );
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;
