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

CREATE PROCEDURE GetTagsForRecipe(IN recipeId INT)
BEGIN
    SELECT 
        t.tag_name
    FROM tag t
    JOIN recipe_tag rt ON t.tag_id = rt.tag_id
    WHERE rt.recipe_id = recipeId;
END$$

CREATE PROCEDURE GetRecipesByTags(IN tagList TEXT)
BEGIN
    SET @tagList = tagList;

    SELECT 
        r.recipe_id,
        r.title,
        r.cook_time,
        r.difficulty_level,
        r.status,
        r.rating,
        i.image_path
    FROM recipe r
    JOIN recipe_tag rt ON r.recipe_id = rt.recipe_id
    JOIN tag t ON rt.tag_id = t.tag_id
    JOIN image i ON r.image_id = i.image_id
    WHERE FIND_IN_SET(t.tag_id, @tagList) > 0
    GROUP BY r.recipe_id
    HAVING COUNT(DISTINCT t.tag_id) = (SELECT COUNT(*) FROM tag WHERE FIND_IN_SET(tag_id, @tagList) > 0);
END$$
    
DELIMITER ;
