-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe(1, 1, 30, 5, 3, 1, 1, 'www.source.com', 'draft');
CALL insert_recipe(2, 2, 45, 5, 2, 1, 2, 'www.source.com', 'draft');
CALL insert_recipe(3, 3, 60, 10, 1, 2, 1, 'www.source.com', 'draft');
CALL insert_recipe(4, 4, 75, 15, 3, 3, 3, 'www.source.com', 'draft');
CALL insert_recipe(4, 5, 90, 100, 2, 3, 2, 'www.source.com', 'draft');
