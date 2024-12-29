-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE delete_recipe_engagement(
    IN p_person_id INT,
    IN p_recipe_id INT,
    IN p_engagement_type VARCHAR(25)
)
BEGIN
    DELETE FROM recipe_engagement
    WHERE person_id = p_person_id
    AND recipe_id = p_recipe_id
    AND engagement_type = p_engagement_type;
END //

CREATE OR REPLACE PROCEDURE delete_recipe_like(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    CALL delete_recipe_engagement(p_person_id, p_recipe_id, 'like');
END //

CREATE OR REPLACE PROCEDURE delete_recipe_favorite(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    CALL delete_recipe_engagement(p_person_id, p_recipe_id, 'favorite');
END //

CREATE OR REPLACE PROCEDURE delete_recipe_view(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    CALL delete_recipe_engagement(p_person_id, p_recipe_id, 'view');
END //

DELIMITER ;
