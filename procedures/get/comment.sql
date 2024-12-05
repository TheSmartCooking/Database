DELIMITER //

-- This procedure is intended for testing purposes only
CREATE PROCEDURE get_all_comments ()
BEGIN
    SELECT * FROM comment
END //

CREATE PROCEDURE get_comment_by_id (
    IN p_comment_id INT
)
BEGIN
    SELECT * FROM comment
    WHERE comment_id = p_comment_id;
END //

CREATE PROCEDURE get_all_comments_by_person (
    IN p_person_id INT
)
BEGIN
    SELECT * FROM comment
    WHERE person_id = p_person_id;
END //

CREATE PROCEDURE get_all_comments_by_recipe (
    IN p_recipe_id INT
)
BEGIN
    SELECT * FROM comment
    WHERE recipe_id = p_recipe_id
    ORDER BY comment_date ASC;
END //

CREATE PROCEDURE get_comment_count_by_recipe (
    IN p_recipe_id INT
)
BEGIN
    SELECT COUNT(*) AS comment_count
    FROM comment
    WHERE recipe_id = p_recipe_id;
END //

DELIMITER ;
