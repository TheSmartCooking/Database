-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe_rating(
    IN p_recipe_id INT,
    IN p_person_id INT,
    IN p_rating INT
)
BEGIN
    INSERT INTO recipe_rating (recipe_id, person_id, rating)
    VALUES (p_recipe_id, p_person_id, p_rating);
END //

DELIMITER ;
