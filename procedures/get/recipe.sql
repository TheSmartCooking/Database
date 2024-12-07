-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_recipes()
BEGIN
    SELECT * FROM recipe;
END //

CREATE OR REPLACE PROCEDURE get_all_recipes_paginated(
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT *
    FROM recipe
    LIMIT p_limit OFFSET p_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_author_paginated(
    IN p_author_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT *
    FROM recipe
    WHERE author_id = p_author_id
    LIMIT p_limit OFFSET p_offset;
END //

CREATE OR REPLACE PROCEDURE get_top_rated_recipes_paginated(
    IN p_min_rating TINYINT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT r.recipe_id, r.author_id, r.publication_date, AVG(rr.rating) AS average_rating
    FROM recipe r
    JOIN recipe_rating rr ON r.recipe_id = rr.recipe_id
    GROUP BY r.recipe_id
    HAVING average_rating >= p_min_rating
    ORDER BY average_rating DESC
    LIMIT p_limit OFFSET p_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_liked_by_person_paginated(
    IN p_person_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT r.*
    FROM recipe r
    JOIN recipe_engagement re ON r.recipe_id = re.recipe_id
    WHERE re.person_id = p_person_id AND re.engagement_type = 'like'
    LIMIT p_limit OFFSET p_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_language_paginated(
    IN p_language_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT r.*
    FROM recipe r
    JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
    WHERE rt.language_id = p_language_id
    LIMIT p_limit OFFSET p_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_category_paginated(
    IN p_category_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT r.*
    FROM recipe r
    JOIN recipe_category rc ON r.recipe_id = rc.recipe_id
    WHERE rc.category_id = p_category_id
    LIMIT p_limit OFFSET p_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_tags_paginated(
    IN p_tags JSON,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT r.*
    FROM recipe r
    JOIN recipe_tag rt ON r.recipe_id = rt.recipe_id
    WHERE JSON_CONTAINS(p_tags, JSON_QUOTE(rt.tag))
    LIMIT p_limit OFFSET p_offset;
END //

CREATE OR REPLACE PROCEDURE get_recipes_by_name_paginated(
    IN p_name VARCHAR(255),
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SET @safe_recipe_name = REPLACE(REPLACE(p_name, '%', '\\%'), '_', '\\_');

    SELECT *
    FROM recipe
    WHERE name LIKE CONCAT('%', @safe_recipe_name, '%') ESCAPE '\\'
    LIMIT p_limit OFFSET p_offset;
END //

DELIMITER ;
