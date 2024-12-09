-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe_like(1, 1);
CALL insert_recipe_favorite(1, 2);
CALL insert_recipe_view(1, 3);
CALL insert_recipe_like(2, 1);
CALL insert_recipe_favorite(2, 2);
