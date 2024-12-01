-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE get_all_languages()
BEGIN
    SELECT language_id, iso_code, language_name
    FROM lang;
END //

CREATE OR REPLACE PROCEDURE get_language_by_id(IN p_language_id INT)
BEGIN
    SELECT language_id, iso_code, language_name
    FROM lang
    WHERE language_id = p_language_id;
END //

CREATE OR REPLACE PROCEDURE get_language_by_code(IN p_iso_code VARCHAR(10))
BEGIN
    SELECT language_id, iso_code, language_name
    FROM lang
    WHERE iso_code = p_iso_code;
END //

CREATE OR REPLACE PROCEDURE get_languages_with_users()
BEGIN
    SELECT l.language_id, l.iso_code, l.language_name, COUNT(p.person_id) AS user_count
    FROM lang l
    LEFT JOIN person p ON l.language_id = p.language_id
    GROUP BY l.language_id, l.iso_code, l.language_name;
END //

CREATE OR REPLACE PROCEDURE get_languages_with_translations()
BEGIN
    SELECT l.language_id, l.iso_code, l.language_name, COUNT(it.ingredient_id) AS translated_ingredients_count
    FROM lang l
    LEFT JOIN ingredient_translation it ON l.language_id = it.language_id
    GROUP BY l.language_id, l.iso_code, l.language_name;
END //

CREATE OR REPLACE PROCEDURE get_languages_with_recipe_translations()
BEGIN
    SELECT l.language_id, l.iso_code, l.language_name, COUNT(rt.recipe_id) AS translated_recipes_count
    FROM lang l
    LEFT JOIN recipe_translation rt ON l.language_id = rt.language_id
    GROUP BY l.language_id, l.iso_code, l.language_name;
END //

CREATE OR REPLACE PROCEDURE get_language_usage_statistics()
BEGIN
    SELECT 
        l.language_id, 
        l.iso_code, 
        l.language_name, 
        (SELECT COUNT(p.person_id) FROM person p WHERE p.language_id = l.language_id) AS user_count,
        (SELECT COUNT(it.ingredient_id) FROM ingredient_translation it WHERE it.language_id = l.language_id) AS ingredient_translation_count,
        (SELECT COUNT(rt.recipe_id) FROM recipe_translation rt WHERE rt.language_id = l.language_id) AS recipe_translation_count
    FROM lang l;
END //

DELIMITER ;
