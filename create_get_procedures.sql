DELIMITER $$

CREATE PROCEDURE GetAllRecipes()
BEGIN
    SELECT 
        r.recipe_id,
        r.title,
        r.cook_time,
        r.difficulty_level,
        r.status,
        r.rating,
        i.image_path
    FROM recipe r
    LEFT JOIN image i ON r.image_id = i.image_id;
END$$

DELIMITER ;
