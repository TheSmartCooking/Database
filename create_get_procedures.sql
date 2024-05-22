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
        i.image_path AS image
    FROM recipe r
    LEFT JOIN image i ON r.image_id = i.image_id;
END$$

CREATE PROCEDURE GetRecipeById(IN recipeId INT)
BEGIN
    SELECT 
        r.recipe_id,
        r.title,
        r.description,
        r.ingredients,
        r.preparation,
        r.publication_date,
        r.modification_date,
        r.cook_time,
        r.difficulty_level,
        r.rating,
        r.number_of_reviews,
        r.nutritional_information,
        r.source,
        r.allergen_information,
        r.video_url,
        r.status,
        u.username AS author,
        i.image_path AS image
    FROM recipe r
    LEFT JOIN user u ON r.author_id = u.user_id
    LEFT JOIN image i ON r.image_id = i.image_id
    WHERE r.recipe_id = recipeId;
END$$

CREATE PROCEDURE GetCommentsForRecipe(IN recipeId INT)
BEGIN
    SELECT 
        c.comment_id,
        c.comment,
        c.comment_date,
        u.username AS author
    FROM comment c
    JOIN user u ON c.user_id = u.user_id
    WHERE c.recipe_id = recipeId
    ORDER BY c.comment_date DESC;
END$$

CREATE PROCEDURE GetAllTags()
BEGIN
    SELECT 
        tag_id,
        tag_name
    FROM tag;
END$$

DELIMITER ;
