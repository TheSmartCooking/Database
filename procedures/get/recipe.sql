-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_recipes()
BEGIN
    SELECT * FROM recipe;
END //

CREATE OR REPLACE PROCEDURE get_recipe_by_id(
    IN p_recipe_id INT
)
BEGIN
    SELECT
        author_id,
        publication_date,
        modification_date,
        picture_id,
        cook_time,
        difficulty_level,
        number_of_reviews,
        nutritional_information,
        source,
        video_url,
        recipe_status
    FROM recipe
    WHERE recipe_id = p_recipe_id;
END //

CREATE OR REPLACE PROCEDURE get_all_recipes_paginated(
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE max_limit INT DEFAULT 30;
    DECLARE v_offset INT DEFAULT (p_offset - 1) * p_limit;
    SET p_limit = LEAST(p_limit, max_limit);

    SELECT r.*, rt.title
    FROM recipe r
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    WHERE l.iso_code = p_language_iso_code
    LIMIT p_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_author_paginated(
    IN p_author_id INT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE max_limit INT DEFAULT 30;
    DECLARE v_offset INT DEFAULT (p_offset - 1) * p_limit;
    SET p_limit = LEAST(p_limit, max_limit);

    SELECT
        r.recipe_id,
        r.publication_date,
        r.modification_date,
        r.picture_id,
        r.cook_time,
        r.difficulty_level,
        r.number_of_reviews,
        r.nutritional_information,
        r.source,
        r.video_url,
        r.recipe_status,
        r.category_id,
        rt.title,
    FROM recipe r
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    WHERE r.author_id = p_author_id
      AND l.iso_code = p_language_iso_code
    LIMIT p_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_top_rated_recipes_paginated(
    IN p_min_rating TINYINT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE max_limit INT DEFAULT 30;
    DECLARE v_offset INT DEFAULT (p_offset - 1) * p_limit;
    SET p_limit = LEAST(p_limit, max_limit);

    SELECT r.*, AVG(rr.rating) AS average_rating, rt.title,
    FROM recipe r
    INNER JOIN recipe_rating rr ON r.recipe_id = rr.recipe_id
    INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    INNER JOIN lang l ON rt.language_id = l.language_id
    WHERE l.iso_code = p_language_iso_code
    GROUP BY r.recipe_id
    HAVING average_rating >= p_min_rating
    ORDER BY average_rating DESC
    LIMIT p_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_liked_by_person_paginated(
    IN p_person_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    DECLARE max_limit INT DEFAULT 30;
    DECLARE v_offset INT DEFAULT (p_offset - 1) * p_limit;
    SET p_limit = LEAST(p_limit, max_limit);

    SELECT r.*
    FROM recipe r
    INNER JOIN recipe_engagement re ON r.recipe_id = re.recipe_id
    WHERE re.person_id = p_person_id AND re.engagement_type = 'like'
    LIMIT p_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_category_paginated(
    IN p_category_id INT,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE max_limit INT DEFAULT 30;
    DECLARE v_offset INT DEFAULT (p_offset - 1) * p_limit;
    SET p_limit = LEAST(p_limit, max_limit);

    SELECT r.*, rt.title
    FROM recipe r
    JOIN recipe_category rc ON r.recipe_id = rc.recipe_id
    JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    JOIN lang l ON rt.language_id = l.language_id
    WHERE rc.category_id = p_category_id
      AND l.iso_code = p_language_iso_code
    LIMIT p_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_tags_paginated(
    IN p_tags JSON,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE max_limit INT DEFAULT 30;
    DECLARE v_offset INT DEFAULT (p_offset - 1) * p_limit;
    SET p_limit = LEAST(p_limit, max_limit);

    SELECT r.*, rt.title
    FROM recipe r
    JOIN recipe_tag rtg ON r.recipe_id = rtg.recipe_id
    JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    JOIN lang l ON rt.language_id = l.language_id
    WHERE JSON_CONTAINS(p_tags, JSON_QUOTE(rtg.tag))
      AND l.iso_code = p_language_iso_code
    LIMIT p_limit OFFSET v_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_name_paginated(
    IN p_name VARCHAR(255),
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE max_limit INT DEFAULT 30;
    DECLARE v_offset INT DEFAULT (p_offset - 1) * p_limit;
    SET p_limit = LEAST(p_limit, max_limit);

    SET @safe_recipe_name = REPLACE(REPLACE(p_name, '%', '\\%'), '_', '\\_');

    SELECT r.*, rt.title
    FROM recipe r
    JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    JOIN lang l ON rt.language_id = l.language_id
    WHERE r.name LIKE CONCAT('%', @safe_recipe_name, '%') ESCAPE '\\'
      AND l.iso_code = p_language_iso_code
    LIMIT p_limit OFFSET v_offset;
END //

DELIMITER ;
