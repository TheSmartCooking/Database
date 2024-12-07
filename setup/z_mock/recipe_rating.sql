-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe_rating(1, 1, 4);
CALL insert_recipe_rating(1, 2, 4);
CALL insert_recipe_rating(1, 3, 3);
CALL insert_recipe_rating(2, 1, 1);
CALL insert_recipe_rating(2, 2, 2);
CALL insert_recipe_rating(2, 3, 3);
CALL insert_recipe_rating(3, 1, 4);
CALL insert_recipe_rating(3, 2, 4);
CALL insert_recipe_rating(3, 3, 3);
