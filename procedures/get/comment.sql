-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_comments()
BEGIN
    SELECT * FROM comment;
END //

CREATE OR REPLACE PROCEDURE get_comment_by_id(
    IN p_comment_id INT
)
BEGIN
    SELECT * FROM comment
    WHERE comment_id = p_comment_id;
END //

CREATE OR REPLACE PROCEDURE get_all_comments_by_person(
    IN p_person_id INT
)
BEGIN
    SELECT comment_id, recipe_id, content, comment_date FROM comment
    WHERE author_id = p_person_id;
END //

CREATE OR REPLACE PROCEDURE get_all_comments_by_recipe(
    IN p_recipe_id INT
)
BEGIN
    SELECT
        c.comment_id, c.author_id, c.content, c.comment_date, IFNULL(l.like_count, 0) AS like_count
    FROM
        comment c
    LEFT JOIN(
        SELECT
            comment_id, COUNT(*) AS like_count
        FROM
            comment_like
        GROUP BY
            comment_id
    ) l ON c.comment_id = l.comment_id
    WHERE
        c.recipe_id = p_recipe_id
    ORDER BY
        c.comment_date ASC;
END //

CREATE OR REPLACE PROCEDURE get_comment_count_by_recipe(
    IN p_recipe_id INT
)
BEGIN
    SELECT COUNT(*) AS comment_count
    FROM comment
    WHERE recipe_id = p_recipe_id;
END //

DELIMITER ;
