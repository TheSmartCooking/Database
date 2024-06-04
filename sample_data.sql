-- Empty the database
DROP PROCEDURE IF EXISTS truncate_table;

DELIMITER $$

CREATE PROCEDURE truncate_table(IN table_name VARCHAR(64))
BEGIN
    SET @query = CONCAT('TRUNCATE TABLE ', table_name);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

CALL truncate_table('comment_likes');
CALL truncate_table('comments');
CALL truncate_table('favorites');
CALL truncate_table('recipe_ratings');
CALL truncate_table('recipe_tags');
CALL truncate_table('recipes');
CALL truncate_table('tags');
CALL truncate_table('ingredients');
CALL truncate_table('statuses');
CALL truncate_table('responsibilities');
CALL truncate_table('images');
CALL truncate_table('persons');
CALL truncate_table('locales');

DROP PROCEDURE IF EXISTS truncate_table;

-- Create sample persons
CALL create_person('John Doe', 'john.doe@example.com', 'passwordhash1', 'salt1', NULL);
CALL create_person('Jane Smith', 'jane.smith@example.com', 'passwordhash2', 'salt2', NULL);

-- Create sample images
CALL create_image('path/to/avatar1.jpg', 'avatar');
CALL create_image('path/to/recipe1.jpg', 'recipe');
CALL create_image('path/to/locale_icon1.jpg', 'locale_icon');

-- Create sample responsibilities
CALL create_responsibility('Admin');
CALL create_responsibility('User');

-- Create sample statuses
CALL create_status('Draft');
CALL create_status('Published');

-- Create sample ingredients
CALL create_ingredient('Flour');
CALL create_ingredient('Sugar');
CALL create_ingredient('Butter');

-- Create sample tags
CALL create_tag('Dessert');
CALL create_tag('Vegan');

-- Create sample recipes
CALL create_recipe(1, 2, 30, 2, 'Calories: 200', 'Grandma''s Recipe Book', 'http://example.com/video', 2);
CALL create_recipe(1, 1, 45, 3, 'Calories: 150', 'Chef''s Special', 'http://example.com/video', 2);
CALL create_recipe(1, NULL, 45, 3, 'Calories: 150', 'Chef''s Special', 'http://example.com/video', 2);

-- Create sample comments
CALL create_comment(1, 1, 'This recipe is amazing!');
CALL create_comment(2, 2, 'Great recipe, loved it!');

-- Create sample comment likes
CALL create_comment_like(1, 1);
CALL create_comment_like(2, 2);

-- Create sample favorites
CALL create_favorite(1, 1);
CALL create_favorite(2, 2);

-- Create sample recipe tags
CALL create_recipe_tag(1, 1);
CALL create_recipe_tag(2, 2);

-- Create sample recipe ratings
CALL create_recipe_rating(1, 1, 4);
CALL create_recipe_rating(2, 2, 3);

-- Create sample locales
CALL create_locale('fr_FR', 'French (France)', 1);
CALL create_locale('en_US', 'English (United States)', 1);
CALL create_locale('es_ES', 'Spanish (Spain)', 1);
CALL create_locale('de_DE', 'German (Germany)', 1);
CALL create_locale('it_IT', 'Italian (Italy)', 1);
CALL create_locale('pt_PT', 'Portuguese (Portugal)', 1);
CALL create_locale('pt_BR', 'Portuguese (Brazil)', 1);
CALL create_locale('zh_CN', 'Chinese (Simplified)', 1);
CALL create_locale('ja_JP', 'Japanese (Japan)', 1);
CALL create_locale('ko_KR', 'Korean (South Korea)', 1);
CALL create_locale('ru_RU', 'Russian (Russia)', 1);
CALL create_locale('ar_SA', 'Arabic (Saudi Arabia)', 1);
CALL create_locale('hi_IN', 'Hindi (India)', 1);

-- Create sample recipe translations

INSERT INTO recipe_translation(recipe_id, locale_id, title, description, preparation) VALUES
(1, 1, 'Pancakes Classiques', 'Des pancakes moelleux et délicieux', 'Mélanger la farine, le lait, les œufs et la levure chimique. Cuire sur une plaque chauffante.'),
(1, 2, 'Classic Pancakes', 'Fluffy and delicious pancakes', 'Mix flour, milk, eggs, and baking powder. Cook on a hot griddle.'),
(1, 3, 'Panqueques Clásicos', 'Panqueques esponjosos y deliciosos', 'Mezclar harina, leche, huevos y polvo de hornear. Cocinar en una plancha caliente.'),
(2, 1, 'Spaghetti à la Carbonara', 'Un plat de pâtes italien classique', 'Cuire les spaghettis. Faire frire la pancetta. Mélanger les œufs et le fromage. Mélanger tous les ingrédients.'),
(2, 2, 'Spaghetti Carbonara', 'A classic Italian pasta dish', 'Cook spaghetti. Fry pancetta. Mix eggs and cheese. Combine all ingredients.'),
(2, 3, 'Espaguetis Carbonara', 'Un plato clásico de pasta italiana', 'Cocinar espaguetis. Freír panceta. Mezclar huevos y queso. Combinar todos los ingredientes.'),
(3, 1, 'Poulet Tikka Masala', 'Un plat de poulet indien savoureux', 'Faire mariner le poulet dans du yaourt et des épices. Cuire dans une sauce faite de tomates, de crème et d’épices.'),
(3, 2, 'Chicken Tikka Masala', 'A flavorful Indian chicken dish', 'Marinate chicken in yogurt and spices. Cook in a sauce made of tomatoes, cream, and spices.'),
(3, 3, 'Pollo Tikka Masala', 'Un sabroso plato de pollo indio', 'Marinar el pollo en yogur y especias. Cocinar en una salsa hecha de tomates, crema y especias.');
