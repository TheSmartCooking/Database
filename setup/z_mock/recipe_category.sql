-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe_category(1, 1);
CALL insert_recipe_category(4, 1);
CALL insert_recipe_category(2, 2);
CALL insert_recipe_category(3, 3);
