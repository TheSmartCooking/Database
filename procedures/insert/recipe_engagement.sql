-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe_engagement(
    IN p_person_id INT,
    IN p_recipe_id INT,
    IN p_engagement_type INT
)
BEGIN
    INSERT INTO recipe_engagement (person_id, recipe_id, engagement_type)
    VALUES (p_person_id, p_recipe_id, p_engagement_type);
END //

CREATE OR REPLACE PROCEDURE insert_recipe_like(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    CALL insert_recipe_engagement(p_person_id, p_recipe_id, 'like');
END //

CREATE OR REPLACE PROCEDURE insert_recipe_favorite(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    CALL insert_recipe_engagement(p_person_id, p_recipe_id, 'favorite');
END //

CREATE OR REPLACE PROCEDURE insert_recipe_view(
    IN p_person_id INT,
    IN p_recipe_id INT
)
BEGIN
    CALL insert_recipe_engagement(p_person_id, p_recipe_id, 'view');
END //

DELIMITER ;
