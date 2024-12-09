-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe_ingredient(
    IN p_recipe_id INT,
    IN p_ingredient_id INT,
    IN p_quantity DECIMAL(10, 2),
    IN p_unit VARCHAR(25)
)
BEGIN
    INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit)
    VALUES (p_recipe_id, p_ingredient_id, p_quantity, p_unit);
END //

CREATE OR REPLACE PROCEDURE insert_recipe_ingredient_by_name(
    IN p_recipe_id INT,
    IN p_ingredient_name VARCHAR(225),
    IN p_quantity DECIMAL(10, 2),
    IN p_unit VARCHAR(10)
)
BEGIN
    DECLARE v_ingredient_id INT;

    SELECT ingredient_id INTO v_ingredient_id
    FROM ingredient
    WHERE default_name = p_ingredient_name;

    CALL insert_recipe_ingredient(p_recipe_id, v_ingredient_id, p_quantity, p_unit);
END //

CREATE OR REPLACE PROCEDURE insert_recipe_ingredients(
    IN p_recipe_id INT,
    IN p_ingredients JSON
)
BEGIN
    DECLARE v_ingredient_id INT;
    DECLARE v_quantity DECIMAL(10, 2);
    DECLARE v_unit VARCHAR(10);

    WHILE JSON_LENGTH(p_ingredients) > 0 DO
        SET v_ingredient_id = JSON_EXTRACT(p_ingredients, '$[0].ingredient_id');
        SET v_quantity = JSON_EXTRACT(p_ingredients, '$[0].quantity');
        SET v_unit = JSON_UNQUOTE(JSON_EXTRACT(p_ingredients, '$[0].unit'));

        CALL insert_recipe_ingredient(p_recipe_id, v_ingredient_id, v_quantity, v_unit);

        SET p_ingredients = JSON_REMOVE(p_ingredients, '$[0]');
    END WHILE;
END //

CREATE OR REPLACE PROCEDURE insert_recipe_ingredients_by_name(
    IN p_recipe_id INT,
    IN p_ingredients JSON
)
BEGIN
    DECLARE v_quantity DECIMAL(10, 2);
    DECLARE v_unit VARCHAR(10);
    DECLARE v_ingredient_name VARCHAR(225);

    WHILE JSON_LENGTH(p_ingredients) > 0 DO
        SET v_ingredient_name = JSON_UNQUOTE(JSON_EXTRACT(p_ingredients, '$[0].ingredient_name'));
        SET v_quantity = JSON_EXTRACT(p_ingredients, '$[0].quantity');
        SET v_unit = JSON_UNQUOTE(JSON_EXTRACT(p_ingredients, '$[0].unit'));

        CALL insert_recipe_ingredient_by_name(p_recipe_id, v_ingredient_name, v_quantity, v_unit);

        SET p_ingredients = JSON_REMOVE(p_ingredients, '$[0]');
    END WHILE;
END //

DELIMITER ;
