-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE PROCEDURE get_all_recipe_ratings()
BEGIN
    SELECT * FROM recipe_rating;
END //

CREATE PROCEDURE get_recipe_rating_by_id(IN rating_id INT)
BEGIN
    SELECT * FROM recipe_rating WHERE rating_id = rating_id;
END //

CREATE PROCEDURE get_recipe_ratings_by_person(IN person_id INT)
BEGIN
    SELECT * FROM recipe_rating WHERE person_id = person_id;
END //

CREATE PROCEDURE get_recipe_ratings_by_recipe(IN recipe_id INT)
BEGIN
    SELECT * FROM recipe_rating WHERE recipe_id = recipe_id;
END //

DELIMITER ;
