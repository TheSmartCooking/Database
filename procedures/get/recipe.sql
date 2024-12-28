-- Use the database
USE smartcooking;

DELIMITER //

-- Testing procedure (unchanged as it does not benefit from the functions)
CREATE OR REPLACE PROCEDURE get_all_recipes()
BEGIN
    SELECT * FROM recipe;
END //

-- Procedure to fetch recipe details by ID, using the `get_recipe_title` function
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
        get_recipe_title(p_recipe_id, p_language_iso_code) AS title,
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

-- Generic template for pagination with limit and offset
CREATE OR REPLACE PROCEDURE get_all_recipes_paginated(
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_offset INT;
    DECLARE v_limit INT;

    SET v_offset = calculate_offset(p_offset, p_limit);
    SET v_limit = enforce_row_limit(p_limit);

    SELECT
        r.recipe_id,
        r.author_id,
        p.person_name AS author_name,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status,
        get_recipe_title(r.recipe_id, p_language_iso_code) AS title
    FROM recipe r
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    INNER JOIN person p ON r.author_id = p.person_id
    WHERE l.iso_code = p_language_iso_code
    LIMIT v_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_author_paginated(
    IN p_author_id INT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_offset INT;
    DECLARE v_limit INT;

    SET v_offset = calculate_offset(p_offset, p_limit);
    SET v_limit = enforce_row_limit(p_limit);

    SELECT
        r.recipe_id,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status,
        get_recipe_title(r.recipe_id, p_language_iso_code) AS title
    FROM recipe r
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    WHERE r.author_id = p_author_id
      AND l.iso_code = p_language_iso_code
    LIMIT v_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_top_rated_recipes_paginated(
    IN p_min_rating TINYINT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_offset INT;
    DECLARE v_limit INT;

    SET v_offset = calculate_offset(p_offset, p_limit);
    SET v_limit = enforce_row_limit(p_limit);

    SELECT
        r.recipe_id,
        r.author_id,
        p.person_name AS author_name,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status,
        AVG(rr.rating) AS average_rating,
        get_recipe_title(r.recipe_id, p_language_iso_code) AS title
    FROM recipe r
    INNER JOIN recipe_rating rr ON r.recipe_id = rr.recipe_id
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    INNER JOIN person p ON r.author_id = p.person_id
    WHERE l.iso_code = p_language_iso_code
    GROUP BY r.recipe_id
    HAVING average_rating >= p_min_rating
    ORDER BY average_rating DESC
    LIMIT v_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_liked_by_person_paginated(
    IN p_person_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    DECLARE v_offset INT;
    DECLARE v_limit INT;

    SET v_offset = calculate_offset(p_offset, p_limit);
    SET v_limit = enforce_row_limit(p_limit);

    SELECT
        r.recipe_id,
        r.author_id,
        p.person_name AS author_name,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status
    FROM recipe r
    INNER JOIN recipe_engagement re ON r.recipe_id = re.recipe_id
    INNER JOIN person p ON r.author_id = p.person_id
    WHERE re.person_id = p_person_id
      AND re.engagement_type = 'like'
    LIMIT v_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_category_paginated(
    IN p_category_id INT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_offset INT;
    DECLARE v_limit INT;

    SET v_offset = calculate_offset(p_offset, p_limit);
    SET v_limit = enforce_row_limit(p_limit);

    SELECT
        r.recipe_id,
        r.author_id,
        p.person_name AS author_name,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status,
        get_recipe_title(r.recipe_id, p_language_iso_code) AS title
    FROM recipe r
    INNER JOIN recipe_category rc ON r.recipe_id = rc.recipe_id
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    INNER JOIN person p ON r.author_id = p.person_id
    WHERE rc.category_id = p_category_id
      AND l.iso_code = p_language_iso_code
    LIMIT v_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_tags_paginated(
    IN p_tags JSON,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_offset INT;
    DECLARE v_limit INT;

    SET v_offset = calculate_offset(p_offset, p_limit);
    SET v_limit = enforce_row_limit(p_limit);

    SELECT
        r.recipe_id,
        r.author_id,
        p.person_name AS author_name,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status,
        get_recipe_title(r.recipe_id, p_language_iso_code) AS title
    FROM recipe r
    INNER JOIN recipe_tag rtg ON r.recipe_id = rtg.recipe_id
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    INNER JOIN person p ON r.author_id = p.person_id
    WHERE JSON_CONTAINS(p_tags, JSON_QUOTE(rtg.tag))
      AND l.iso_code = p_language_iso_code
    LIMIT v_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_name_paginated(
    IN p_name VARCHAR(255),
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_offset INT;
    DECLARE v_limit INT;
    DECLARE v_safe_recipe_name VARCHAR(255);

    SET v_offset = calculate_offset(p_offset, p_limit);
    SET v_limit = enforce_row_limit(p_limit);
    SET v_safe_recipe_name = sanitize_string(p_name);

    SELECT
        r.recipe_id,
        r.author_id,
        p.person_name AS author_name,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.recipe_status,
        get_recipe_title(r.recipe_id, p_language_iso_code) AS title
    FROM recipe r
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    INNER JOIN person p ON r.author_id = p.person_id
    WHERE rt.title LIKE v_safe_recipe_name ESCAPE '\\'
      AND l.iso_code = p_language_iso_code
    LIMIT v_limit OFFSET v_offset;
END //

DELIMITER ;
