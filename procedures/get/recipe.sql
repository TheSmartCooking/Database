-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE get_recipe_by_id(
    IN p_recipe_id INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    SELECT
        r.author_id,
        p.person_name AS author_name,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status,
        rt.title,
        rt.details,
        rt.preparation,
        rt.nutritional_information,
        rt.video_url
    FROM recipe r
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    INNER JOIN person p ON r.author_id = p.person_id
    WHERE r.recipe_id = p_recipe_id
      AND l.iso_code = p_language_iso_code;
END //

-- Centralized procedure for fetching paginated recipes with filtering
CREATE OR REPLACE PROCEDURE get_recipes_paginated(
    IN p_filter_condition TEXT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2),
    IN p_group_by TEXT,
    IN p_having_condition TEXT,
    IN p_order_by TEXT
)
BEGIN
    DECLARE v_limit INT;
    DECLARE v_offset INT;
    SET v_limit = enforce_row_limit(p_limit);
    SET v_offset = calculate_offset(p_offset, v_limit);

    SET @query = 'SELECT r.recipe_id, r.author_id, p.person_name AS author_name, '
                 'r.picture_id, r.cook_time, r.difficulty_level, r.number_of_reviews, '
                 'r.recipe_status, rt.title '
                 'FROM recipe r '
                 'INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id '
                 'INNER JOIN lang l ON rt.language_id = l.language_id '
                 'INNER JOIN person p ON r.author_id = p.person_id '
                 'WHERE l.iso_code = ? ';

    IF p_filter_condition IS NOT NULL THEN
        SET @query = CONCAT(@query, p_filter_condition);
    END IF;

    IF p_group_by IS NOT NULL THEN
        SET @query = CONCAT(@query, ' ', p_group_by);
    END IF;

    IF p_having_condition IS NOT NULL THEN
        SET @query = CONCAT(@query, ' ', p_having_condition);
    END IF;

    IF p_order_by IS NOT NULL THEN
        SET @query = CONCAT(@query, ' ', p_order_by);
    END IF;

    SET @query = CONCAT(@query, ' LIMIT ? OFFSET ?');

    PREPARE stmt FROM @query;
    EXECUTE stmt USING p_language_iso_code, v_limit, v_offset;
    DEALLOCATE PREPARE stmt;
END //

-- Procedure for retrieving all recipes with optional pagination
CREATE OR REPLACE PROCEDURE get_all_recipes_paginated(
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    CALL get_recipes_paginated(NULL, p_limit, p_offset, p_language_iso_code, NULL, NULL, NULL);
END //

-- Procedure for retrieving recipes by author with pagination
CREATE OR REPLACE PROCEDURE get_recipes_by_author_paginated(
    IN p_author_id INT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    CALL get_recipes_paginated('AND r.author_id = ?', p_limit, p_offset, p_language_iso_code, NULL, NULL, NULL);
END //

-- Procedure for retrieving top-rated recipes with pagination
CREATE OR REPLACE PROCEDURE get_top_rated_recipes_paginated(
    IN p_min_rating TINYINT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    CALL get_recipes_paginated(
        'INNER JOIN recipe_rating rr ON r.recipe_id = rr.recipe_id',
        p_limit, p_offset, p_language_iso_code, 'GROUP BY r.recipe_id',
        'HAVING AVG(rr.rating) >= ?',
        'ORDER BY AVG(rr.rating) DESC'
    );
END //

-- Procedure for retrieving recipes liked by a person with pagination
CREATE OR REPLACE PROCEDURE get_recipes_liked_by_person_paginated(
    IN p_person_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    DECLARE v_limit INT;
    DECLARE v_offset INT;
    SET v_limit = enforce_row_limit(p_limit);
    SET v_offset = calculate_offset(p_offset, v_limit);

    SELECT
        r.recipe_id,
        r.author_id,
        p.person_name AS author_name,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status
    FROM
        recipe r
        INNER JOIN recipe_engagement re ON r.recipe_id = re.recipe_id
        INNER JOIN person p ON r.author_id = p.person_id
    WHERE re.person_id = p_person_id AND re.engagement_type = 'like'
    LIMIT v_limit OFFSET v_offset;
END //

-- Procedure for retrieving recipes by category with pagination
CREATE OR REPLACE PROCEDURE get_recipes_by_category_paginated(
    IN p_category_id INT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    CALL get_recipes_paginated(
        'INNER JOIN recipe_category rc ON r.recipe_id = rc.recipe_id AND rc.category_id = ?',
        p_limit, p_offset, p_language_iso_code, NULL, NULL, NULL
    );
END //

-- Procedure for retrieving recipes by tags with pagination
CREATE OR REPLACE PROCEDURE get_recipes_by_tags_paginated(
    IN p_tags JSON,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    CALL get_recipes_paginated(
        'INNER JOIN recipe_tag rtg ON r.recipe_id = rtg.recipe_id '
        'AND JSON_CONTAINS(?, JSON_QUOTE(rtg.tag))',
        p_limit, p_offset, p_language_iso_code, NULL, NULL, NULL
    );
END //

-- Procedure for retrieving recipes by name with pagination
CREATE OR REPLACE PROCEDURE get_recipes_by_name_paginated(
    IN p_name VARCHAR(255),
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_safe_recipe_name VARCHAR(255);
    SET v_safe_recipe_name = sanitize_string(p_name);

    CALL get_recipes_paginated(
        'AND rt.title LIKE ?',
        p_limit, p_offset, p_language_iso_code, NULL, NULL, NULL
    );
END //

DELIMITER ;
