-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe_tag(1, 1);
CALL insert_recipe_tag(1, 2);
CALL insert_recipe_tag(1, 3);
CALL insert_recipe_tags(2, '[1, 2, 3]');
CALL insert_recipe_tags(3, '[2, 3, 4]');
