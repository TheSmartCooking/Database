-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE search_recipes_flexible(
    IN p_filters JSON,
    IN p_limit INT,
    IN p_offset INT,
    IN p_language_iso_code CHAR(2)
)
BEGIN
    DECLARE v_limit INT;
    DECLARE v_offset INT;

    SET v_limit = enforce_row_limit(p_limit);
    SET v_offset = calculate_offset(p_offset, v_limit);

    SET @sql = '
        SELECT DISTINCT r.recipe_id,
            r.author_id,
            p.person_name AS author_name,
            r.picture_id,
            r.cook_time,
            r.difficulty_level,
            r.number_of_reviews,
            rs.status_name AS recipe_status,
            rt.title
        FROM recipe r
        INNER JOIN recipe_translation rt ON r.recipe_id = rt.recipe_id
        INNER JOIN lang l ON rt.language_id = l.language_id
        INNER JOIN person p ON r.author_id = p.person_id
        INNER JOIN recipe_status rs ON r.recipe_status = rs.status_id
        WHERE l.iso_code = ?
    ';

    -- Handle dynamic filters
    IF JSON_CONTAINS_PATH(p_filters, 'one', '$.title') THEN
        SET @sql = CONCAT(@sql, ' AND rt.title LIKE CONCAT("%", JSON_UNQUOTE(JSON_EXTRACT(p_filters, "$.title")), "%")');
    END IF;

    IF JSON_CONTAINS_PATH(p_filters, 'one', '$.author_id') THEN
        SET @sql = CONCAT(@sql, ' AND r.author_id = JSON_EXTRACT(p_filters, "$.author_id")');
    END IF;

    IF JSON_CONTAINS_PATH(p_filters, 'one', '$.difficulty_max') THEN
        SET @sql = CONCAT(@sql, ' AND r.difficulty_level <= JSON_EXTRACT(p_filters, "$.difficulty_max")');
    END IF;

    IF JSON_CONTAINS_PATH(p_filters, 'one', '$.category') THEN
        SET @sql = CONCAT(@sql, '
            AND EXISTS (
                SELECT 1 FROM recipe_category rc
                JOIN category c ON rc.category_id = c.category_id
                WHERE rc.recipe_id = r.recipe_id
                AND c.category_name = JSON_UNQUOTE(JSON_EXTRACT(p_filters, "$.category"))
            )
        ');
    END IF;

    IF JSON_CONTAINS_PATH(p_filters, 'one', '$.tags') THEN
        SET @sql = CONCAT(@sql, '
            AND EXISTS (
                SELECT 1 FROM recipe_tag rtg
                JOIN tag t ON rtg.tag_id = t.tag_id
                WHERE rtg.recipe_id = r.recipe_id
                AND JSON_CONTAINS(p_filters, JSON_QUOTE(t.tag_name), "$.tags")
            )
        ');
    END IF;

    IF JSON_CONTAINS_PATH(p_filters, 'one', '$.ingredient') THEN
        SET @sql = CONCAT(@sql, '
            AND EXISTS (
                SELECT 1 FROM recipe_ingredient ri
                JOIN ingredient i ON ri.ingredient_id = i.ingredient_id
                JOIN ingredient_translation it ON i.ingredient_id = it.ingredient_id
                WHERE ri.recipe_id = r.recipe_id
                AND it.translated_name LIKE CONCAT("%", JSON_UNQUOTE(JSON_EXTRACT(p_filters, "$.ingredient")), "%")
                AND it.language_id = l.language_id
            )
        ');
    END IF;

    SET @sql = CONCAT(@sql, ' LIMIT ? OFFSET ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING p_language_iso_code, v_limit, v_offset;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;
