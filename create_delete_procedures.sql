DROP PROCEDURE IF EXISTS delete_favorite;
DROP PROCEDURE IF EXISTS delete_comment;
DROP PROCEDURE IF EXISTS delete_comment_like;

DELIMITER $$

CREATE PROCEDURE delete_favorite(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    DELETE FROM favorite
    WHERE person_id = p_person_id AND recipe_id = p_recipe_id;
END$$

CREATE PROCEDURE delete_comment(
    IN p_comment_id INT
)
BEGIN
    DELETE FROM comment
    WHERE comment_id = p_comment_id;
END$$

CREATE PROCEDURE delete_comment_like(
    IN p_person_id INT,
    IN p_comment_id INT
)
BEGIN
    DELETE FROM comment_like
    WHERE person_id = p_person_id AND comment_id = p_comment_id;
END$$

DELIMITER ;
