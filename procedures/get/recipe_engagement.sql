DELIMITER //

-- This procedure is intended for testing purposes only
CREATE PROCEDURE get_all_recipe_engagements ()
BEGIN
    SELECT engagement_id, person_id, recipe_id, engagement_type, engagement_date
    FROM recipe_engagement;
END //

CREATE PROCEDURE get_engagement_counts_by_recipe (
    IN p_recipe_id INT
)
BEGIN
    SELECT engagement_type, COUNT(*) AS engagement_count
    FROM recipe_engagement
    WHERE recipe_id = p_recipe_id
    GROUP BY engagement_type;
END //

CREATE PROCEDURE get_all_engagements_by_person (
    IN p_person_id INT
)
BEGIN
    SELECT engagement_id, person_id, recipe_id, engagement_type, engagement_date
    FROM recipe_engagement
    WHERE person_id = p_person_id;
END //

CREATE PROCEDURE get_all_engagements_by_type (
    IN p_engagement_type ENUM('like', 'favorite', 'view')
)
BEGIN
    SELECT engagement_id, person_id, recipe_id, engagement_type, engagement_date
    FROM recipe_engagement
    WHERE engagement_type = p_engagement_type;
END //

DELIMITER ;
