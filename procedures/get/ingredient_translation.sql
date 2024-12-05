-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_ingredients_translations()
BEGIN
    SELECT * FROM ingredient_translation;
END //

CREATE OR REPLACE PROCEDURE get_ingredient_translation(
    IN ingredient_id INT,
    IN language_iso_code CHAR(2)
)
BEGIN
    SELECT * FROM ingredient_translation
    WHERE ingredient_id = ingredient_id
    AND language_iso_code = language_iso_code;
END //

CREATE OR REPLACE PROCEDURE get_ingredients_translation(
    IN ingredient_ids JSON,
    IN language_iso_code CHAR(2)
)
BEGIN
    DECLARE lang_id INT;

    SELECT language_id INTO lang_id
    FROM lang
    WHERE language_iso_code = language_iso_code;

    SELECT
        it.ingredient_id,
        COALESCE(it.translated_name, i.default_name) AS translated_name
    FROM JSON_TABLE(
        ingredient_ids,
        '$[*]' COLUMNS(ingredient_id INT PATH '$')
    ) AS ids
    LEFT JOIN ingredient i ON ids.ingredient_id = i.ingredient_id
    LEFT JOIN ingredient_translation it ON i.ingredient_id = it.ingredient_id AND it.language_id = lang_id;
END //

DELIMITER ;
