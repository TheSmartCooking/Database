-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe(1, 1, 30, 3, 'www.source.com', 1);
CALL insert_recipe(2, 2, 45, 2, 'www.source.com', 2);
CALL insert_recipe(3, 3, 60, 1, 'www.source.com', 1);
CALL insert_recipe(4, 4, 75, 3, 'www.source.com', 3);
CALL insert_recipe(4, 5, 90, 2, 'www.source.com', 1);
