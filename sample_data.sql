-- Sample data for insertion

-- Create sample persons
CALL create_person('John Doe', 'john.doe@example.com', 'passwordhash1', 'salt1');
CALL create_person('Jane Smith', 'jane.smith@example.com', 'passwordhash2', 'salt2');

-- Create sample images
CALL create_image('path/to/avatar1.jpg', 'avatar');
CALL create_image('path/to/recipe1.jpg', 'recipe');
CALL create_image('path/to/locale_icon1.jpg', 'locale_icon');

-- Create sample locales
CALL create_locale('en_US', 'English (US)', 3);
CALL create_locale('fr_FR', 'French (FR)', NULL);

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
CALL create_recipe(1, 2, 30, 2, 'Calories: 200', 'Grandma\'s Recipe Book', 'http://example.com/video', 2);
CALL create_recipe(2, NULL, 45, 3, 'Calories: 150', 'Chef\'s Special', 'http://example.com/video', 2);

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
